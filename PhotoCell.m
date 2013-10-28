//
//  PhotoCell.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/9/30.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

@synthesize asset,photoImage;

-(void)setAsset:(ALAsset *)aSset
{
    //self.asset = aSset;

    self.photoImage.image = [UIImage imageWithCGImage:[aSset thumbnail]];
    NSLog(@"image asset test");
}


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //[self setAsset:asset];
        self.photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height)];
        self.photoImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.photoImage];
        self.photoImage.clipsToBounds = YES;
        
//        UIView *selectedView = [[UIView alloc] initWithFrame:frame];
//        selectedView.backgroundColor = [UIColor blueColor];
//        self.selectedBackgroundView = selectedView;
    }
    NSLog(@"image cell test");
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
