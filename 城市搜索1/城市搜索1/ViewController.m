//
//  ViewController.m
//  城市搜索1
//
//  Created by 邱荣贵 on 2017/10/24.
//  Copyright © 2017年 邱荣贵. All rights reserved.
//

#import "OneViewController.h"

#import "ViewController.h"

@interface ViewController ()<OneViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *clikeBut;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    
 
}
- (IBAction)clike:(id)sender {
    
    OneViewController *one = [[OneViewController alloc] init];
    one.delegate = self;
    [self.navigationController pushViewController:one animated:YES];
}

#pragma mark -- OneViewControllerDelegate

- (void)backCityName:(NSString *)aName{
    
    NSLog(@"%@---aName",aName);
    
    [self.clikeBut setTitle:aName forState:UIControlStateNormal];
    
    
}
@end
