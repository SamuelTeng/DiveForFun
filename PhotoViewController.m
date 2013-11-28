//
//  PhotoViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/9/26.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCell.h"
#import "AppDelegate.h"
#import "LogViewController.h"

@interface PhotoViewController (){
    
    AppDelegate *delegate;
    LogViewController *logViewController;
}

@end

@implementation PhotoViewController

@synthesize collectionView,assets;

+(ALAssetsLibrary *)defaultAssetLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred , ^{
        library = [[ALAssetsLibrary alloc] init];
        
    });
    return library;
}

-(void)fetchCameraRoll
{
    assets = [@[]mutableCopy];
    NSMutableArray *tmpAssets= [@[] mutableCopy];
    
    ALAssetsLibrary *assetsLibrary = [PhotoViewController defaultAssetLibrary];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                [tmpAssets addObject:result];
                
            }
        }
         ];
        self.assets = tmpAssets;
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error loading images %@", error);
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    delegate = [[UIApplication sharedApplication] delegate];
    logViewController = [[LogViewController alloc] init];
    
    
//    self.collectionView.autoresizesSubviews = YES;
//    self.collectionView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView setBackgroundColor:[UIColor brownColor]];
    
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"PhotoCell"];
    
    
    
    [self.view addSubview:self.collectionView];
    
    [self fetchCameraRoll];
//    assets = [@[]mutableCopy];
//    NSMutableArray *tmpAssets= [@[] mutableCopy];
//    
//    ALAssetsLibrary *assetsLibrary = [PhotoViewController defaultAssetLibrary];
//    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//            if (result) {
//                [tmpAssets addObject:result];
//               
//            }
//        }
//         ];
//        self.assets = tmpAssets;
//        [self.collectionView reloadData];
//    } failureBlock:^(NSError *error) {
//        NSLog(@"Error loading images %@", error);
//    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchCameraRoll];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.assets = NULL;
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
    NSLog(@"%i",self.assets.count);
    //return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    PhotoCell *cell = (PhotoCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    ALAsset * asset = self.assets[indexPath.row];
    
    UIImageView *cellImage = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:[asset thumbnail]]];
    //cell.asset = asset;
    //cell.photoImage.image = cellImage;
    //cell.backgroundColor = [UIColor redColor];
    [cell addSubview:cellImage];
    NSLog(@"cell test");
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //ALAsset * cellAsset = self.assets[indexPath.row];
    
    //UIImageView *cellSizeImage = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:[cellAsset thumbnail]]];
    
    CGSize cellSize = CGSizeMake(100, 100);
    //cellSizeImage.image.size.width>0 ? cellSizeImage.image.size: CGSizeMake(0, 0);
    cellSize.height += 35; cellSize.width += 35;
    return cellSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ALAsset *selectedImageAsset = self.assets[indexPath.row];
    //ALAssetRepresentation *selectedImageRepresentation = [selectedImageAsset defaultRepresentation];
    
    NSLog(@"URL:%@",[selectedImageAsset valueForProperty:ALAssetPropertyURLs]); 
    UIImage *beSelectedImage = [UIImage imageWithCGImage:[selectedImageAsset thumbnail]];
    delegate.selectedCellImage = beSelectedImage;
    NSLog(@"be touched");
    [delegate.navi popViewControllerAnimated:YES];
}


//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    //return toInterfaceOrientation == UIInterfaceOrientationPortrait;
//    return toInterfaceOrientation == UIDeviceOrientationPortrait;
//}

//-(BOOL)shouldAutorotate
//{
//    return NO;
//}
//
//-(NSUInteger)supportedInterfaceOrientations
//{
//    return 2;
//    //UIInterfaceOrientationMaskPortrait;
//}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationPortrait;
//}


@end
