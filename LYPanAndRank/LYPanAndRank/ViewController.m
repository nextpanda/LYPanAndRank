//
//  ViewController.m
//  LYPanAndRank
//
//  Created by mac on 16/8/22.
//  Copyright © 2016年 LY. All rights reserved.
//

#import "ViewController.h"
#import "LYCollectionReusableView.h"
#import "LYCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, LYCollectionViewCellDelegate, LYCollectionReusableViewDelegate> {
    
    UIButton *_headerButton;
    
    NSMutableArray *_editButtons;
    
    BOOL _isEditing;
    
}

@property (nonatomic, strong) UICollectionView *collectView;

@property (nonatomic, strong) NSMutableArray *addedThemes;
@property (nonatomic, strong) NSMutableArray *remainingThemes;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _editButtons = [[NSMutableArray alloc] initWithCapacity:0];
    
    _remainingThemes = [[NSMutableArray alloc] initWithObjects:@"推荐", @"科技", @"手机", @"互联网", @"娱乐", @"读书", @"本地", @"电影", @"音乐", nil];
    _addedThemes = [[NSMutableArray alloc] init];
    for (int i = 0; i<4; i++) {
        
        [_addedThemes addObject:[_remainingThemes objectAtIndex:i]];
        
    }
    for (int j = 0; j<4; j++) {
        
        [_remainingThemes removeObjectAtIndex:0];
        
    }
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((self.view.bounds.size.width - 5 * 20) / 4, 30);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    flowLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 40);
    
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20) collectionViewLayout:flowLayout];
    
    _collectView.pagingEnabled = NO;//由于拖移需求，禁止分页效果
    
    _collectView.dataSource = self;
    _collectView.delegate = self;
    
    [_collectView registerClass:[LYCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    [_collectView registerClass:[LYCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_collectView];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return _addedThemes.count;
        
    }else {
        
        return _remainingThemes.count;
        
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.layer.cornerRadius = 5;
    
    cell.delegate = self;
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = [_addedThemes objectAtIndex:indexPath.item];
        
        cell.editButton.hidden = !_isEditing;
        
        cell.editButton.tag = indexPath.item;
        
    }else {
        
        cell.textLabel.text = [_remainingThemes objectAtIndex:indexPath.item];
        cell.editButton.hidden = YES;
        
    }
    
    
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    LYCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    
    headerView.delegate = self;
    
    if (indexPath.section == 0) {
        
        headerView.headerLable.text = @"切换栏目";
        
        _headerButton = headerView.headerButton;
        
        headerView.headerButton.hidden = NO;
        
        headerView.headerButton.selected = _isEditing;
        
    }else {
        
        headerView.headerLable.text = @"添加更多栏目";
        
        headerView.headerButton.hidden = YES;
        
    }
    
    headerView.headerLable.textColor = [UIColor whiteColor];
    
    headerView.headerButton.frame = CGRectMake(self.view.bounds.size.width - 50 - 20, 5, 50, 30);
    
    CGSize size = [headerView.headerLable.text sizeWithFont:headerView.headerLable.font constrainedToSize:CGSizeMake(self.view.bounds.size.width - 40, 30)];
    headerView.headerLable.frame = CGRectMake(20, 5, size.width, 30);
    
    return headerView;
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        if (_remainingThemes.count > 0) {
            
            NSString *tmpString = [_remainingThemes objectAtIndex:indexPath.item];
            [_addedThemes addObject:tmpString];
            [_remainingThemes removeObject:tmpString];
            [_collectView reloadData];////////////////////////////////////////////////
            
        }
        
    }

}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    if (sourceIndexPath.section == 1 && destinationIndexPath.section == 0) {
        
        [_addedThemes insertObject:[_remainingThemes objectAtIndex:sourceIndexPath.item] atIndex:destinationIndexPath.item];
        [_remainingThemes removeObjectAtIndex:sourceIndexPath.item];
        UICollectionViewCell *tmpCell = [_collectView cellForItemAtIndexPath:destinationIndexPath];
        ((LYCollectionViewCell *)tmpCell).editButton.hidden = NO;
        
        return;
    }
    if (sourceIndexPath.section == 0 && destinationIndexPath.section == 1) {
        
        [_remainingThemes insertObject:[_addedThemes objectAtIndex:sourceIndexPath.item] atIndex:destinationIndexPath.item];
        [_addedThemes removeObjectAtIndex:sourceIndexPath.item];
        UICollectionViewCell *tmpCell = [_collectView cellForItemAtIndexPath:destinationIndexPath];
        ((LYCollectionViewCell *)tmpCell).editButton.hidden = YES;
        
        return;
        
    }
    if (sourceIndexPath.section ==0 && destinationIndexPath.section == 0) {
        
        [_addedThemes exchangeObjectAtIndex:destinationIndexPath.item withObjectAtIndex:sourceIndexPath.item];
        
        return;
    }
    
}

#pragma mark - LYCollectionViewCellDelegate
- (void)didLongPress:(UILongPressGestureRecognizer *)longPress {
    
    //只有在编辑状态才能移动item
    if (_isEditing) {
        
        CGPoint point = [longPress locationInView:_collectView];
        NSIndexPath *indexPath = [_collectView indexPathForItemAtPoint:point];
        
        switch (longPress.state) {
            case UIGestureRecognizerStateBegan: {
                
                [_collectView beginInteractiveMovementForItemAtIndexPath:indexPath];
                
            }
                break;
                
            case UIGestureRecognizerStateChanged: {
                
                [_collectView updateInteractiveMovementTargetPosition:point];
                
            }
                break;
                
            case UIGestureRecognizerStateEnded: {
                
                [_collectView endInteractiveMovement];
                
            }
                break;
            default:{
                
                [_collectView cancelInteractiveMovement];
                
            }
                break;
        }
        
    }
    
}

- (void)deleteThemeWithButton:(UIButton *)editButton {
    
    if (_addedThemes.count > 0) {
        
        NSString *tmpString = [_addedThemes objectAtIndex:editButton.tag];
        [_remainingThemes addObject:tmpString];
        [_addedThemes removeObject:tmpString];
        [_collectView reloadData];////////////////////////////////////////////////
    }
    
}

#pragma mark - LYCollectionReusableViewDelegate
- (void)didClickEditOrFinish:(UIButton *)headerButton {
    
    headerButton.selected = !headerButton.isSelected;
    
    _isEditing = headerButton.isSelected;
    
    [_collectView reloadData];////////////////////////////////////////////////
    
}

@end
