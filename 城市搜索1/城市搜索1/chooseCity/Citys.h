//
//  Citys.h
//  城市搜索1
//
//  Created by 邱荣贵 on 2017/10/25.
//  Copyright © 2017年 邱荣贵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Citys : NSObject
/** 600280000*/
@property (nonatomic,copy) NSString  *city_key;
/** 安吉市*/
@property (nonatomic,copy) NSString  *city_name;
/** aj*/
@property (nonatomic,copy) NSString  *initials;
/** anji*/
@property (nonatomic,copy) NSString  *pinyin;
/** 安吉*/
@property (nonatomic,copy) NSString  *short_name;

+ (instancetype)citysWithDic:(NSDictionary *)dic;

@end



@interface City : NSObject
/** A*/
@property (nonatomic,copy) NSString  *initial;
/** 安吉市*/
@property (nonatomic,strong) NSArray  *citys;

+ (instancetype)cityWithDic:(NSDictionary *)dic;


@end

