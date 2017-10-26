//
//  OneViewController.h
//  城市搜索1
//
//  Created by 邱荣贵 on 2017/10/25.
//  Copyright © 2017年 邱荣贵. All rights reserved.
//

#import "ViewController.h"

@protocol OneViewControllerDelegate <NSObject>

- (void)backCityName:(NSString *)aName;

@end

@interface OneViewController : ViewController

/** <#name#>*/
@property (nonatomic,assign) id <OneViewControllerDelegate>  delegate;

@end
