//
//  ViewController.m
//  UICollectionViewDemo
//
//  Created by EasonFeng on 11/18/15.
//  Copyright © 2015 Eveason. All rights reserved.
//

#import "ViewController.h"
#import "TagCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@end

static NSString* const kReuseCellId = @"collectionViewReuseIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseCellId forIndexPath:indexPath];
    [self configureCell:cell forItemAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell
   forItemAtIndexPath:(NSIndexPath *)indexPath
{
    TagCollectionViewCell *tagCell =  (TagCollectionViewCell*)cell;
    [tagCell.title setText:[NSString stringWithFormat:@"Section-%ld-Row-%ld",(long)indexPath.section,(long)indexPath.row]];
    tagCell.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Lazy inits
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = ({
            UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.view.frame
                                                        collectionViewLayout:self.flowLayout];
            view.backgroundColor = [UIColor redColor];
            [view registerNib:[UINib nibWithNibName:@"TagCollectionViewCell"
                                             bundle:nil] forCellWithReuseIdentifier:kReuseCellId];
            view.dataSource = self;
            view;
        });
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.itemSize = CGSizeMake(self.view.frame.size.width, 44);
            layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
            layout.minimumInteritemSpacing = 5.f;
            layout.minimumLineSpacing = 5.f;
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            switch (layout.scrollDirection) {
                case UICollectionViewScrollDirectionHorizontal:
                    layout.headerReferenceSize = CGSizeMake(20,self.view.frame.size.height);
                    layout.footerReferenceSize = CGSizeMake(30,self.view.frame.size.height);
                    break;
                default:
                    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 20);
                    layout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 30);
                    break;
            }
            layout;
        });
    }
    return _flowLayout;
}

@end
