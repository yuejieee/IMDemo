//
//  DataBaseHandler.m
//  IMDemo
//
//  Created by 岳杰 on 2017/2/20.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import "DataBaseHandler.h"
#import "Header.h"

@interface DataBaseHandler ()
//存文件路径
@property (nonatomic, copy) NSString *dataPath;
@property (nonatomic, strong) FMDatabase *fmdb;

@end

@implementation DataBaseHandler

+(instancetype)shareDataBase{
    
    static DataBaseHandler *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataBaseHandler alloc] init];
        [manager openDB];
    });
    return manager;
}

- (void)openDB{
    NSString *sandBoxPatn = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.dataPath =  [sandBoxPatn stringByAppendingPathComponent:@"contact.sqlite"];
    NSLog(@"%@",self.dataPath);
    // 创建一个FMDB的对象
    self.fmdb = [[FMDatabase alloc] initWithPath:self.dataPath];
    BOOL result = [self.fmdb open];
    if (result) {
        NSLog(@"成功");
    }else{
        NSLog(@"失败");
    }
}

- (void)executeSql:(NSString *)sqlStr message:(NSString *)message{
    BOOL result = [self.fmdb executeUpdate:sqlStr];
    if (result) {
        NSLog(@"%@",[NSString stringWithFormat:@"%@成功",message]);
    }else{
        NSLog(@"%@",[NSString stringWithFormat:@"%@失败",message]);
    }
}

- (void)createTable{
    NSString *sqlStr = @"create table if not exists contactlist(number integer primary key autoincrement, username text ,message text)";
    //    执行sql语句
    [self executeSql:sqlStr message:@"创建表"];
}

- (void)insertData:(Contact *)data{
    NSString *sqlStr = [NSString stringWithFormat:@"insert into contactlist(username, message) values ('%@','%@')",data.username, data.message];
    [self executeSql:sqlStr message:@"添加菜单"];
}

- (void)deleteData:(Contact *)data{
    NSString *sqlStr = [NSString stringWithFormat:@"delete from contactlist where username = '%@'",data.username];
    [self executeSql:sqlStr message:@"删除"];
}

- (BOOL)selectOneData:(Contact *)data{
    NSString *sqlStr = [NSString stringWithFormat:@"select * from contactlist where username = '%@'",data.username];
    FMResultSet *resultSet = [self.fmdb executeQuery:sqlStr];
    BOOL result = NO;
    while ([resultSet next]) {
        NSString *title = [resultSet stringForColumn:@"username"];
        if ([title isEqualToString:data.username]) {
            result = YES;
            break;
        }
    }
    return result;
}

- (NSMutableArray *)selectAllData{
    
    NSString *sqlStr = @"select * from contactlist";
    //执行查询的方法
    FMResultSet *resultSet = [self.fmdb executeQuery:sqlStr];
    
    //系统会把查询之后的结果赋值给resultSet
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    //进行遍历
    while ([resultSet next]) {
        NSString *username = [resultSet stringForColumn:@"username"];
        NSString *message = [resultSet stringForColumn:@"message"];
        
        Contact *data = [[Contact alloc] init];
        data.username = username;
        data.message = message;
        [array addObject:data];
    }
    return array;
}
@end
