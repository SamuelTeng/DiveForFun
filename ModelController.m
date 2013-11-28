//
//  ModalController.m
//  DiveForFun
//
//  Created by Samuel Teng on 2013/11/15.
//  Copyright (c) 2013年 Samuel Teng. All rights reserved.
//

#import "ModelController.h"

#import "LogShoViewController.h"
#import "PageViewController.h"
#import "AppDelegate.h"
#import "LogDatabase.h"

@interface ModelController (){
    
    AppDelegate *delegate;
    LogShoViewController *contentPage;

}



@end

@implementation ModelController



- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    contentPage = (LogShoViewController *)viewController;
    int currentPage = contentPage.contenPath.row;
    int currentSection = contentPage.contenPath.section;
    
//    if (currentPage <= 1 || currentSection <=1) {
//        return nil;
//    }else{
//        
//        int page = currentPage-1;
//        int pageSection = contentPage.contenPath.section-1;
//        
//        contentPage = [[LogShoViewController alloc] init];
//        contentPage.contenPath = [NSIndexPath indexPathForRow:page inSection:pageSection];
//        
//        return contentPage;
//        
//    }

    /*the section from tableview start with 0*/
    if (currentSection <1) {
        return nil;
    }else{
        
        int page = currentPage;
        int pageSection = contentPage.contenPath.section-1;
        
        contentPage = [[LogShoViewController alloc] init];
        contentPage.contenPath = [NSIndexPath indexPathForRow:page inSection:pageSection];
        
        return contentPage;
        
    }
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    contentPage = (LogShoViewController *)viewController;
    int currentPage = contentPage.contenPath.row;
    int currentSection = contentPage.contenPath.section;
    
    LogDatabase *logDatabase = [LogDatabase new];
    int total = [logDatabase numberOfPages];
    
    /*the "row == currentPage" might have no differences, but the "section == currenctSection" has lots*/
    
//    if (currentPage >= total-1 || currentSection >= total-1) {
//        return nil;
//    }else{
//        
//        int page = currentPage+1;
//        int pageSection = contentPage.contenPath.section;
//        contentPage = [[LogShoViewController alloc] init];
//        contentPage.contenPath = [NSIndexPath indexPathForRow:page inSection:pageSection];
//        return contentPage;
//        
//    }
    
    if (currentSection >= total-1) {
        return nil;
    }else{
        
        int page = currentPage;
        int pageSection = contentPage.contenPath.section+1;
        contentPage = [[LogShoViewController alloc] init];
        contentPage.contenPath = [NSIndexPath indexPathForRow:page inSection:pageSection];
        return contentPage;
        
    }

}

@end
