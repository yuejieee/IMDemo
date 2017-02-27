//
//  Marco.h
//  IMDemo
//
//  Created by 岳杰 on 2017/2/17.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

#ifndef Marco_h
#define Marco_h

// 颜色
#define RGB(r, g, b)                    [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a)            [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
// 设备尺寸
#define kScreen_Height                  ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width                   ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Frame                   (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))
#define kScreen_CenterX                 kScreen_Width / 2
#define kScreen_CenterY                 kScreen_Height / 2
#define kScale                          kScreen_Width / 375
#define FontWithSize(size)              [UIFont systemFontOfSize:(size) * kScale]
#define FontWithNameAndSize(name, size) [UIFont fontWithName:name size:(size) * kScale]

#define IMAGE(imageName) [UIImage imageNamed:imageName]

#endif /* Marco_h */
