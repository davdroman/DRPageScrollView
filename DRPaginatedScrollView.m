//
//  DRPaginatedScrollView.m
//  Proday
//
//  Created by David Román Aguirre on 24/12/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import "DRPaginatedScrollView.h"

@interface DRPaginatedScrollView ()

@property (strong, nonatomic) UITapGestureRecognizer * tapGestureRecognizer;

@property (readwrite, nonatomic) NSInteger currentPage;
@property (readwrite, nonatomic) NSInteger numberOfPages;

@property (readwrite, nonatomic, getter = isJumping) BOOL jumping;

@end

@implementation DRPaginatedScrollView

- (id)init {
    if (self = [super init]) {
        [self setPagingEnabled:YES];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self setJumpDurationPerPage:0.1];
        
        [self setActionWhenTappedBlock:^(DRPaginatedScrollView * paginatedScrollView) {
            [paginatedScrollView jumpToPage:[paginatedScrollView currentPage]+1 bounce:0 completion:nil];
        }];
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }
    
    return self;
}

- (void)handleTap {
    if (self.actionWhenTappedBlock) self.actionWhenTappedBlock(self);
}

- (NSInteger)lastPage {
    return self.numberOfPages-1;
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

- (void)addPageWithHandler:(void (^)(UIView * pageView))handler {
    UIView * pageView = [UIView new];
    
    handler(pageView);
    [pageView setTag:self.numberOfPages];
    [pageView setBackgroundColor:[UIColor clearColor]];
    [pageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:pageView];
    
    UIView * previousPageView = nil;
    
    if (self.numberOfPages > 0) {
        previousPageView = [self subviewWithTag:self.numberOfPages-1];
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
    
    self.numberOfPages++;
}

- (UIView *)subviewWithTag:(NSInteger)tag {
    for (UIView * subview in self.subviews) {
        if (subview.tag == tag) return subview;
    }
    
    return nil;
}

- (NSInteger)currentPage {
    return round(self.contentOffset.x/self.frame.size.width);
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
