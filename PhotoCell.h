//
//  PhotoCell.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/9/30.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface PhotoCell : UICollectionViewCell

@property (nonatomic,strong) ALAsset *asset;

@property (nonatomic,strong) UIImageView *photoImage;

@end
