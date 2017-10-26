//
//  Citys.m
//  城市搜索1
//
//  Created by 邱荣贵 on 2017/10/25.
//  Copyright © 2017年 邱荣贵. All rights reserved.
//

#import "Citys.h"

@implementation Citys

+ (instancetype)citysWithDic:(NSDictionary *)dic{
    
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if(self == [super init]){
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
}

@end



@implementation City

+ (instancetype)cityWithDic:(NSDictionary *)dic{
    
    return [[self alloc] initWithDic:dic];
    
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if(self == [super init]){
        
        [self setValuesForKeysWithDictionary:dic];
        
        NSMutableArray *array = [NSMutableArray array];
        
        [_citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Citys *mod = [Citys citysWithDic:obj];
            [array addObject:mod];
            
        }];
        
        _citys = array;
        
    }
    return self;
}
@end
