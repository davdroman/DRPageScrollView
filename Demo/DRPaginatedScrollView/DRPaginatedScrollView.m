//
//  DRPaginatedScrollView.m
//  Proday
//
//  Created by David Román Aguirre on 24/12/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import "DRPaginatedScrollView.h"

@interface DRPaginatedScrollView () {
    NSInteger previousPage;
    NSMutableArray * pageViews;
}

@property (strong, nonatomic) UITapGestureRecognizer * tapGestureRecognizer;

@property (readwrite, nonatomic, getter = isJumping) BOOL jumping;

@end

@implementation DRPaginatedScrollView

- (id)init {
    if (self = [super init]) {
        pageViews = [NSMutableArray new];
        
        [self setPagingEnabled:YES];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self setJumpDurationPerPage:0.1];
        
        [self setActionWhenTappedBlock:^(DRPaginatedScrollView * paginatedScrollView) {
            [paginatedScrollView jumpToPage:[paginatedScrollView nextPage] bounce:0 completion:nil];
        }];
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }
    
    return self;
}

- (void)handleTap {
    if (self.actionWhenTappedBlock) self.actionWhenTappedBlock(self);
}

- (void)layoutSubviews {
    if (self.contentSize.width != self.frame.size.width*self.numberOfPages) {
        [self setContentSize:CGSizeMake(self.frame.size.width*self.numberOfPages, self.contentSize.height)];
        [self setContentOffset:CGPointMake(self.frame.size.width*previousPage, self.contentOffset.y)];
    } else {
        previousPage = [self currentPage];
    }
    
    [super layoutSubviews];
}

- (NSInteger)currentPage {
    return round(self.contentOffset.x/self.frame.size.width);
}

- (NSInteger)nextPage {
    return self.currentPage+1;
}

- (NSInteger)lastPage {
    return self.numberOfPages-1;
}

- (NSInteger)numberOfPages {
    return [pageViews count];
}

- (void)addPageWithHandler:(void (^)(UIView * pageView))handler {
    UIView * pageView = [UIView new];
    
    handler(pageView);
    [pageView setBackgroundColor:[UIColor clearColor]];
    [pageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:pageView];
    
    UIView * previousPageView;
    
    if (self.numberOfPages > 0) {
        previousPageView = pageViews[self.numberOfPages-1];
    }
    
    NSLayoutConstraint * topConstraint = [NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint * leftConstraint;
    NSLayoutConstraint * widthConstraint = [NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint * heightConstraint = [NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    
    if (previousPageView) {
        leftConstraint = [NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:previousPageView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    } else {
        leftConstraint = [NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    }
    
    [self addConstraints:@[topConstraint, leftConstraint, widthConstraint, heightConstraint]];
    
    [pageViews addObject:pageView];
}

- (void)jumpToPage:(NSInteger)page bounce:(CGFloat)bounce completion:(void (^)(void))completion {
    if (!self.isJumping && page < [self numberOfPages]) {
        [self setJumping:YES];
        
        [self setPagingEnabled:NO];
        if (self.frame.size.width*page < self.contentOffset.x) bounce = -bounce;
        
        [UIView animateWithDuration:self.jumpDurationPerPage*[self numberOfPages] animations:^{
            [self setContentOffset:CGPointMake(self.frame.size.width*page+bounce, self.contentOffset.y)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:self.jumpDurationPerPage*[self numberOfPages]/2.75 animations:^{
                [self setContentOffset:CGPointMake(self.contentOffset.x-bounce, self.contentOffset.y)];
            } completion:^(BOOL finished) {
                [self setJumping:NO];
                [self setPagingEnabled:YES];
                if (completion) completion();
            }];
        }];
    }
}

@end
