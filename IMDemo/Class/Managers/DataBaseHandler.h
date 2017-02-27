//
//  DataBaseHandler.h
//  IMDemo
//
//  Created by 岳杰 on 2017/2/20.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Contact.h"

@interface DataBaseHandler : NSObject {
    
    sqlite3 *dataBasePoint;
    
}

+(instancetype)shareDataBase;

-(void)createTable;

-(void)openDB;

-(void)insertData:(Contact *)data;

-(void)deleteData:(Contact *)data;

-(BOOL)selectOneData:(Contact *)data;

-(NSMutableArray *)selectAllData;

@end
