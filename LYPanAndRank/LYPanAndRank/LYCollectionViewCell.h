//
//  LYCollectionViewCell.h
//  LYPanAndRank
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 LY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYCollectionViewCellDelegate;

@interface LYCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIButton *editButton;

@property (weak, nonatomic) id <LYCollectionViewCellDelegate> delegate;

@end


@protocol LYCollectionViewCellDelegate <NSObject>

- (void)didLongPress:(UILongPressGestureRecognizer *)longPress;
- (void)deleteThemeWithButton:(UIButton *)editButton;

@end