//
//  MainViewController.h
//  DRPaginatedScrollView
//
//  Created by David Román Aguirre on 24/12/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>

@class DRPaginatedScrollView;

@interface MainViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UINavigationBar * navigationBar;
@property (strong, nonatomic) DRPaginatedScrollView * paginatedScrollView;

@end
