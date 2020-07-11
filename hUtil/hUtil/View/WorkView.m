//
//  WorkView.m
//  hUtil
//
//  Created by ygf on 2020/7/9.
//  Copyright © 2020 wjr. All rights reserved.
//

#import "WorkView.h"
#import "JJCollectionViewRoundFlowLayout.h"
#import "WorkCollectionViewCell.h"

@interface WorkView()<UICollectionViewDelegate,UICollectionViewDataSource,JJCollectionViewDelegateRoundFlowLayout>
@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)JJCollectionViewRoundFlowLayout *layout;

@end

@implementation WorkView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WorkCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([WorkCollectionViewCell class])] forIndexPath:indexPath];

    return cell;
}

/*
* 返回头视图
*/
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    UICollectionReusableView *header = nil;
//    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
//        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"BlankView" forIndexPath:indexPath];
//        UIView* blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HSCREEN_WIDTH, 50*HSCALAE)];
//        blankView.backgroundColor = [UIColor clearColor];
//        [header addSubview:blankView];
//        return header;
//    }
//    return header;
//}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(HSCREEN_WIDTH, 50*HSCALAE);
//}


- (JJCollectionViewRoundConfigModel *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout configModelForSectionAtIndex:(NSInteger)section{
    JJCollectionViewRoundConfigModel *model = [[JJCollectionViewRoundConfigModel alloc]init];
    if (@available(iOS 13.0, *)) {
        model.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return [UIColor whiteColor];
        }];
        
    } else {
        // Fallback on earlier versions
        model.backgroundColor = [UIColor whiteColor];
    }
    model.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
    model.shadowOffset = CGSizeMake(0,2);
    model.shadowOpacity = 1;
    model.shadowRadius = 7;
    model.cornerRadius = 10;
    return model;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout borderEdgeInsertsForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 24*HSCALAE, 5, 24*HSCALAE);
}


#pragma mark-- lazy load
-(UICollectionView*) collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30*HSCALAE, HSCREEN_WIDTH, HSCREEN_HEIGHT-HTABBAR_HEIGHT) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[WorkCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([WorkCollectionViewCell class])]];
//        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"BlankView"];
    }
    return _collectionView;
}

- (JJCollectionViewRoundFlowLayout *)layout {
    if (!_layout) {
        _layout = [[JJCollectionViewRoundFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake((HSCREEN_WIDTH-48*HSCALAE)/4, ceil(204*HSCALAE));
        _layout.minimumInteritemSpacing = 0;
        _layout.minimumLineSpacing = 0;
        _layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _layout.isCalculateHeader = NO;
        _layout.isCalculateFooter = NO;
    }
    return _layout;
}

@end
