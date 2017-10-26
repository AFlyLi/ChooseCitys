//
//  HeaderTableViewCell.m
//  城市搜索1
//
//  Created by 邱荣贵 on 2017/10/25.
//  Copyright © 2017年 邱荣贵. All rights reserved.
//

#define  Margen 5

#define WIDTH  [UIScreen mainScreen].bounds.size.width

#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(r, g, b)     RGBA(r, g, b, 1.0f)


#import "HeaderTableViewCell.h"

#import "CollectionViewCell.h"


@interface HeaderTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CollectionViewCellDelegate>{
    
    UICollectionView *coll ;
    
}

@end

@implementation HeaderTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
     
    }
    return self;
}

- (void)setArray:(NSArray *)array{
    
    _array = array;
    
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, [HeaderTableViewCell returnHeighWithArray:self.array]) collectionViewLayout:flow];
    coll.delegate = self;
    coll.dataSource = self;
    coll.backgroundColor = RGB(242, 242, 242);
    [self.contentView addSubview:coll];
    
    
    [coll registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.array.count){
        
        CGFloat width = (WIDTH - Margen * 6) / 3;
        return CGSizeMake(width, 44);

    }else{
        
        return CGSizeMake(WIDTH - Margen * 2, 44);
    }
  
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(self.array.count){
        return self.array.count;
    }else{
        return 1;
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(Margen, Margen, Margen, Margen);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *Cell = @"Cell";
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell forIndexPath:indexPath];
    cell.delegate = self;
    if(self.array.count){
        [cell.lable setTitle:self.array[indexPath.item] forState:UIControlStateNormal];
        cell.lable.enabled = YES;
    }else{
        [cell.lable setTitle:@"暂无数据" forState:UIControlStateNormal];
        cell.lable.enabled = NO;
    }
    return cell;
}
- (void)CollectionViewCellClikeButton:(UIButton *)button{
 
    if([self.delegate respondsToSelector:@selector(HeaderTableViewCell:citysName:)]){

        [self.delegate HeaderTableViewCell:self citysName:button.titleLabel.text];
    }
}

/**
 计算返回的 height
 @param array <#array description#>
 @return <#return value description#>
 */
+ (CGFloat)returnHeighWithArray:(NSArray *)array{
        
    CGFloat h;
    
    if(array.count){
        
        if(array.count%3 == 0){
            
            h = array.count/3 * (44+Margen * 2);
        }else{
            h = (array.count/3 + 1)* (44+Margen * 2);
        }

    }else{
        h = 44+Margen * 2;

    }
    
    return h;
}


@end
