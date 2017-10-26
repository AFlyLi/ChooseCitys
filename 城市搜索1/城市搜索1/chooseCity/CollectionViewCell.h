//
//  CollectionViewCell.h
//  城市搜索1
//
//  Created by 邱荣贵 on 2017/10/25.
//  Copyright © 2017年 邱荣贵. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewCellDelegate <NSObject>

- (void)CollectionViewCellClikeButton:(UIButton *)button;

@end

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *lable;

/** <#name#>*/
@property (nonatomic,assign) id <CollectionViewCellDelegate>  delegate;

@end
