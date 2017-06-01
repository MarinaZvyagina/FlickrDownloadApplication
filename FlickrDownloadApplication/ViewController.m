//
//  ViewController.m
//  FlickrDownloadApplication
//
//  Created by Марина Звягина on 31.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import "ViewController.h"
#import "FDACell.h"
@import Masonry;

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, copy) NSArray <NSString *> * pictures;
@property (nonatomic, strong) id<FDADataBase> picturesManager;
@property (nonatomic, strong) UICollectionView * collectionView;
@end

@implementation ViewController

-(instancetype) initWithPicturesManager:(id<FDADataBase>) picturesManager {
    self = [super init];
    if (self) {
        self.picturesManager = picturesManager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];

    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    

    [self.collectionView registerClass:[FDACell class] forCellWithReuseIdentifier:FDACellIdentifier];
    self.pictures = [self.picturesManager getPictures:@"Cat"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  20;// self.pictures.count;
}


-(UIImage *)imageWithImage:(UIImage *)imageToCompress scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [imageToCompress drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSURL * url = [[NSURL alloc] initWithString:self.pictures[indexPath.row]];
    CIImage * im = [[CIImage alloc] initWithContentsOfURL:url];
    UIImage * image = [[UIImage alloc] initWithCIImage:im scale:1.0 orientation:UIImageOrientationUp];
    UIImage * compressedImage = [self imageWithImage:image scaledToSize:CGSizeMake(image.size.width/3, image.size.height/3)];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FDACellIdentifier forIndexPath:indexPath];
    UIImageView * view = [[UIImageView alloc] initWithImage:compressedImage];
    [cell.contentView addSubview:view];
    
  //  cell.backgroundColor = [UIColor colorWithPatternImage:compressedImage];
    return cell;
    
    /*UICollectionViewCell * cell = (FDACell *)[collectionView dequeueReusableCellWithReuseIdentifier:FDACellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[FDACell alloc] initWithUrl:self.pictures[indexPath.row]];
    }
    return cell;
     */
}

#pragma mark - UICollectionViewDelegateFlowLayout methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSURL * url = [[NSURL alloc] initWithString:self.pictures[indexPath.row]];
    CIImage * im = [[CIImage alloc] initWithContentsOfURL:url];
    UIImage * image = [[UIImage alloc] initWithCIImage:im scale:1.0 orientation:UIImageOrientationUp];
    UIImage * compressedImage = [self imageWithImage:image scaledToSize:CGSizeMake(image.size.width/3, image.size.height/3)];
    return compressedImage.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1;
}

- (CGSize)collectionViewContentSize
{
    // Don't scroll horizontally
    CGFloat contentWidth = self.collectionView.bounds.size.width;
    
    // Scroll vertically to display a full day
    CGFloat contentHeight = 10000.0;
    
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    return contentSize;
}
/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
*/
@end
