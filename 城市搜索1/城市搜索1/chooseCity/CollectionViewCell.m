//
//  CollectionViewCell.m
//  城市搜索1
//
//  Created by 邱荣贵 on 2017/10/25.
//  Copyright © 2017年 邱荣贵. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)clike:(UIButton *)sender {
    
    NSLog(@"%@--",sender.titleLabel.text);
    
    if([self.delegate respondsToSelector:@selector(CollectionViewCellClikeButton:)]){
        
        [self.delegate CollectionViewCellClikeButton:sender];
    }
}

@end
