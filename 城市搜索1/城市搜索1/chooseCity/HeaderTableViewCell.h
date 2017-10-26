//
//  HeaderTableViewCell.h
//  城市搜索1
//
//  Created by 邱荣贵 on 2017/10/25.
//  Copyright © 2017年 邱荣贵. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderTableViewCellCitysDelegate <NSObject>

- (void)HeaderTableViewCell:(UITableViewCell *)HeaderTableViewCell citysName:(NSString *)name;

@end

@interface HeaderTableViewCell : UITableViewCell

/** <#name#>*/
@property (nonatomic,strong) NSArray  *array;

/** <#name#>*/
@property (nonatomic,assign) id<HeaderTableViewCellCitysDelegate>  delegate;

+ (CGFloat)returnHeighWithArray:(NSArray *)array;

@end
