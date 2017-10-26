//
//  ResultTableViewController.h
//  城市搜索1
//
//  Created by 邱荣贵 on 2017/10/25.
//  Copyright © 2017年 邱荣贵. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ResultTableViewControllerCitysDelegate <NSObject>

- (void)ResultTableViewController:(UITableViewController *)ResultTableViewController citysName:(NSString *)name;

@end

@interface ResultTableViewController : UITableViewController

/** <#name#>*/
@property (nonatomic,strong) NSArray  *data;

/** <#name#>*/
@property (nonatomic,assign) id<ResultTableViewControllerCitysDelegate>  delegate;

@end
