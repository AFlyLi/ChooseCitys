//
//  SearchController.m
//  城市搜索1
//
//  Created by 邱荣贵 on 2017/10/25.
//  Copyright © 2017年 邱荣贵. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];

    //搜索时，背景变暗色
    self.dimsBackgroundDuringPresentation = YES;
    //    /搜索时，背景变模糊
    self.obscuresBackgroundDuringPresentation = YES;
    //
    //点击搜索的时候,是否隐藏导航栏
    self.hidesNavigationBarDuringPresentation = YES;
    
    self.searchBar.placeholder = @"搜索";

    self.searchBar.searchBarStyle = UISearchBarStyleDefault;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
