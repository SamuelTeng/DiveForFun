//
//  SignatureViewController.h
//  DiveForFun
//
//  Created by Samuel Teng on 13/10/11.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignatureViewController : UIViewController{
    CGPoint lastpoint;
    BOOL mouseSwiped;
    int mouseMoved;
}

@property (nonatomic,strong) UIImageView *signnatureImage;
@property (nonatomic,strong) UIImageView *signatureSent;


@end
