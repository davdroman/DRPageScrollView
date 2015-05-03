//
//  MainViewController.m
//  DRPageScrollView
//
//  Created by David Román Aguirre on 3/4/15.
//  Copyright (c) 2015 David Román Aguirre. All rights reserved.
//

#import "MainViewController.h"

#import "DRPageScrollView.h"

@interface MainViewController ()

@property (nonatomic, strong) DRPageScrollView *pageScrollView;

@end

@implementation MainViewController

- (instancetype)init {
	if (self = [super init]) {
		self.pageScrollView = [DRPageScrollView new];
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"DRPageScrollView";
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.pageScrollView.pageReuseEnabled = YES;
	[self.view addSubview:self.pageScrollView];
	applyConstraints(self.pageScrollView);
	
	// Note: you can either take this nib approach or directly instantiate your UI elements programatically and add them to pageView.
	
	NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PageViews" owner:self options:nil];
	
	for (UIView *pv in nibViews) {
		[self.pageScrollView addPageWithHandler:^(UIView *pageView) {
			[pageView addSubview:pv];
			applyConstraints(pv);
		}];
	}
}

void applyConstraints(UIView *view) {
	view.translatesAutoresizingMaskIntoConstraints = NO;
	
	NSArray *attributeArray = @[@(NSLayoutAttributeTop), @(NSLayoutAttributeLeft), @(NSLayoutAttributeBottom), @(NSLayoutAttributeRight)];
	
	for (NSNumber *attributeNumber in attributeArray) {
		NSLayoutAttribute attribute = (NSLayoutAttribute)[attributeNumber integerValue];
		
		NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:attribute multiplier:1 constant:0];
		
		[view.superview addConstraint:constraint];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	// Uncomment for a nice page to page jumping demo
	// [self performSelector:@selector(jumpToRandomPagesIndefinitely) withObject:nil afterDelay:1];
}

- (void)jumpToRandomPagesIndefinitely {
	NSInteger randomPage = arc4random() % self.pageScrollView.numberOfPages;
	
	[UIView animateWithDuration:1 animations:^{
		self.pageScrollView.currentPage = randomPage;
	} completion:^(BOOL finished) {
		[self performSelector:@selector(jumpToRandomPagesIndefinitely) withObject:nil afterDelay:1];
	}];
}

@end
