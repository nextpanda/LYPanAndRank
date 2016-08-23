//
//  LYCollectionView.h
//  LYPanAndRank
//
//  Created by mac on 16/8/22.
//  Copyright © 2016年 LY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYCollectionReusableViewDelegate;

@interface LYCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UILabel *headerLable;
@property (nonatomic, strong) UIButton *headerButton;
@property (weak, nonatomic) id <LYCollectionReusableViewDelegate> delegate;

@end

@protocol LYCollectionReusableViewDelegate <NSObject>

- (void)didClickEditOrFinish:(UIButton *)headerButton;

@end