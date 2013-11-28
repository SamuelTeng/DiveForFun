//
//  SignatureViewController.m
//  DiveForFun
//
//  Created by Samuel Teng on 13/10/11.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "SignatureViewController.h"
#import "AppDelegate.h"
#import "LogViewController.h"

@interface SignatureViewController (){
    AppDelegate *delegate;
    LogViewController *logViewCOntroller;
}

@end

@implementation SignatureViewController

@synthesize signnatureImage,signatureSent;

-(void)sendSignature:(id)sender
{
    if (signnatureImage.image == nil) {
        NSLog(@"no image");
    }
    delegate.signatureImage = signnatureImage.image;
    signnatureImage.image = nil;
    
    [delegate.navi popViewControllerAnimated:YES];
}

-(void)clear:(id)sender
{
    signnatureImage.image = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    signnatureImage = [[UIImageView alloc] init];
    signnatureImage.frame = self.view.frame;
    [self.view addSubview:signnatureImage];
    mouseMoved = 0;
    self.view.backgroundColor = [UIColor lightGrayColor];

    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(sendSignature:)];
    self.navigationItem.leftBarButtonItem = back;
    
    UIBarButtonItem *erase = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"eraser.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(clear:)];
    self.navigationItem.rightBarButtonItem = erase;
    
    delegate = [[UIApplication sharedApplication] delegate];
    logViewCOntroller = [[LogViewController alloc] init];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
//    if ([touch tapCount] == 2) {
//        signnatureImage.image = nil;
//        return;
//    }
    
    lastpoint = [touch locationInView:self.view];
    lastpoint.y -= 20;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    currentPoint.y -= 20;
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [signnatureImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
	CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
	CGContextBeginPath(UIGraphicsGetCurrentContext());
	CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastpoint.x, lastpoint.y);
	CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
	CGContextStrokePath(UIGraphicsGetCurrentContext());
    signnatureImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    lastpoint = currentPoint;
    mouseMoved ++;
    
    if (mouseMoved == 10) {
        mouseMoved = 0;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
//    
//    if ([touch tapCount] == 2) {
//        signnatureImage.image = nil;
//        return;
//    }
    
    if (!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [signnatureImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
		CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastpoint.x, lastpoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastpoint.x, lastpoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		CGContextFlush(UIGraphicsGetCurrentContext());
        
        signnatureImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        signatureSent = [[UIImageView alloc] initWithImage:signnatureImage.image];
        delegate.signatureImage = signatureSent.image;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
