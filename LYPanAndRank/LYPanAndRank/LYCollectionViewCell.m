//
//  LYCollectionViewCell.m
//  LYPanAndRank
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 LY. All rights reserved.
//

#import "LYCollectionViewCell.h"

@implementation LYCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        _textLabel = [[UILabel alloc] initWithFrame:self.contentView.frame];
        
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_textLabel];
        
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.hidden = YES;//先隐藏删除或添加按钮
        _editButton.center = CGPointMake(self.contentView.bounds.size.width, 0);
        _editButton.bounds = CGRectMake(0, 0, 20, 20);
        [_editButton setBackgroundImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [_editButton addTarget:self action:@selector(editTheme:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_editButton];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
        
    }
    
    return self;
    
}

- (void)editTheme:(UIButton *)editButton {
    
    [_delegate deleteThemeWithButton:editButton];
    
}

- (void)longPress:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    
    [_delegate didLongPress:longPressGestureRecognizer];
    
}


@end
