//
//  LYCollectionView.m
//  LYPanAndRank
//
//  Created by mac on 16/8/22.
//  Copyright © 2016年 LY. All rights reserved.
//

#import "LYCollectionReusableView.h"

@implementation LYCollectionReusableView

- (id)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        
        _headerLable = [[UILabel alloc] init];
        [self addSubview:_headerLable];
        
        _headerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _headerButton.hidden = YES;
        [_headerButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_headerButton setTitle:@"完成" forState:UIControlStateSelected];
        [_headerButton addTarget:self action:@selector(editOrFinished:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_headerButton];
        
    }
    
    return self;
    
}

- (void)editOrFinished:(UIButton *)headerButton {
    
    [_delegate didClickEditOrFinish:headerButton];
}

@end
