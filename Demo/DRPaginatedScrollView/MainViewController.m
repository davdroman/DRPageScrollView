//
//  MainViewController.m
//  DRPaginatedScrollView
//
//  Created by David Román Aguirre on 24/12/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import "MainViewController.h"

#import "DRPaginatedScrollView.h"

#import <Masonry.h>

@implementation MainViewController

- (id)init {
    if (self = [super init]) {
        self.navigationBar = [UINavigationBar new];
        self.paginatedScrollView = [DRPaginatedScrollView new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self setupView];
    [self setupConstraints];
}

- (void)setup {
    UINavigationItem * item = [[UINavigationItem alloc] initWithTitle:@"DRPaginatedScrollView"];
    [self.navigationBar setItems:@[item]];
    
    [self.paginatedScrollView setJumpDurationPerPage:0.125];
    
    [self.paginatedScrollView addPageWithHandler:^(UIView *pageView) {
        UILabel * label = [UILabel new];
        [label setText:@"Hi! This is a DRPaginatedScrollView. Every page has been easily implemented entirely by blocks.\n\nIt uses Autolayout. Rotate your device and check it out!\n\nPretty nice, isn't it?"];
        [label setNumberOfLines:100];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
        [pageView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(pageView);
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
        }];
    }];
    
    __unsafe_unretained typeof(self) _self = self;
    
    [self.paginatedScrollView addPageWithHandler:^(UIView *pageView) {
        UIButton * jumpButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [jumpButton setTitle:@"Jump bouncy!" forState:UIControlStateNormal];
        [jumpButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
        [jumpButton addTarget:_self action:@selector(jumpBouncy) forControlEvents:UIControlEventTouchUpInside];
        [pageView addSubview:jumpButton];
        
        [jumpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-15);
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.height.equalTo(@44);
        }];
        
        UILabel * label = [UILabel new];
        [label setText:@"Oh, and by the way... there's a function to perform jumps to any page you specify. It's really simple to use, and it has a really cool parameter called \"bounce\".\n\nThis parameter... well, tap the button below and you'll see what it is for."];
        [label setNumberOfLines:100];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
        [pageView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.bottom.equalTo(jumpButton.mas_top).with.offset(-10);
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
        }];
    }];
    
    [self.paginatedScrollView addPageWithHandler:^(UIView *pageView) {
        UIButton * feedbackButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [feedbackButton setTitle:@"Leave some feedback" forState:UIControlStateNormal];
        [feedbackButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
        [feedbackButton addTarget:_self action:@selector(leaveFeedback) forControlEvents:UIControlEventTouchUpInside];
        [pageView addSubview:feedbackButton];
        
        [feedbackButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-15);
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.height.equalTo(@44);
        }];
        
        UILabel * label = [UILabel new];
        [label setText:@"Thanks for using this demo app of DRPaginatedScrollView. I hope you can give it a chance in any of your future projects.\n\n\nAny feedback you'd like to leave me? I'll gladly read it :)"];
        [label setNumberOfLines:100];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
        [pageView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.bottom.equalTo(feedbackButton.mas_top).with.offset(-10);
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
        }];
    }];
}

- (void)jumpBouncy {
    [self.paginatedScrollView jumpToPage:[self.paginatedScrollView lastPage] bounce:30 completion:nil];
}

- (void)leaveFeedback {
    MFMailComposeViewController * mailComposeViewController = [MFMailComposeViewController new];
    [mailComposeViewController setMailComposeDelegate:self];
    [mailComposeViewController setSubject:@"About DRPaginatedScrollView."];
    [mailComposeViewController setToRecipients:@[@"David Román <dromaguirre@gmail.com>"]];
    [self presentViewController:mailComposeViewController animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.navigationBar];
    [self.view insertSubview:self.paginatedScrollView belowSubview:self.navigationBar];
}

- (void)setupConstraints {
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@64);
    }];
    
    [self.paginatedScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.mas_bottom);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

@end
