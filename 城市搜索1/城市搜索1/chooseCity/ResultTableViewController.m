//
//  ResultTableViewController.m
//  城市搜索1
//
//  Created by 邱荣贵 on 2017/10/25.
//  Copyright © 2017年 邱荣贵. All rights reserved.
//

#import "ResultTableViewController.h"
#import "Citys.h"

@interface ResultTableViewController ()

@end

@implementation ResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Cell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    
    
    Citys *cs = self.data[indexPath.row];
    
    cell.textLabel.text = cs.short_name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Citys *mod = self.data[indexPath.row];
    if([self.delegate respondsToSelector:@selector(ResultTableViewController:citysName:)]){
        
        [self.delegate ResultTableViewController:self citysName:mod.short_name];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
