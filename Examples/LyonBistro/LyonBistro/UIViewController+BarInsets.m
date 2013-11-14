//
//  UIViewController+BarInsets.m
//  LyonBistro
//
//  Created by Nicolas BACHSCHMIDT on 10/10/2013.
//  Copyright (c) 2013 CocoaHeads Lyon. All rights reserved.
//

#import "UIViewController+BarInsets.h"

#import <objc/runtime.h>

static uint8_t kBarInsetsTopLayoutGuideKey;
static uint8_t kBarInsetsBottomLayoutGuideKey;
static uint8_t kBarInsetsInsetsKey;
static uint8_t kBarInsetsInsetsStatusBarObserverKey;

@interface LYBBarInsetsLayoutGuide : UIView <UILayoutSupport>
@property (nonatomic, readwrite) CGFloat length;
@end

@interface LYBBarInsetsStatusBarObserver : NSObject
@property (nonatomic, weak) UIViewController *viewController;
@end

@implementation UIViewController (BarInsets)

- (id <UILayoutSupport>)barInsetsTopLayoutGuide
{
    LYBBarInsetsLayoutGuide *guide = objc_getAssociatedObject(self, &kBarInsetsTopLayoutGuideKey);
    if ( ! guide ) {
        guide = [LYBBarInsetsLayoutGuide new];
        guide.hidden = YES;
        guide.length = self.barInsets.top;
        objc_setAssociatedObject(self, &kBarInsetsTopLayoutGuideKey, guide, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if ( guide.superview != self.view ) {
        [self.view insertSubview:guide atIndex:0];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[guide]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(guide)]];
    }
    return guide;
}

- (id <UILayoutSupport>)barInsetsBottomLayoutGuide
{
    LYBBarInsetsLayoutGuide *guide = objc_getAssociatedObject(self, &kBarInsetsBottomLayoutGuideKey);
    if ( ! guide ) {
        guide = [LYBBarInsetsLayoutGuide new];
        guide.hidden = YES;
        guide.length = self.barInsets.bottom;
        objc_setAssociatedObject(self, &kBarInsetsBottomLayoutGuideKey, guide, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if ( guide.superview != self.view ) {
        [self.view insertSubview:guide atIndex:0];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[guide]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(guide)]];
    }
    return guide;
}

- (UIEdgeInsets)barInsets
{
    NSValue *value = objc_getAssociatedObject(self, &kBarInsetsInsetsKey);
    if ( ! value ) {
        objc_setAssociatedObject(self, &kBarInsetsInsetsKey, [NSValue valueWithUIEdgeInsets:[self defaultBarInsets]], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [value UIEdgeInsetsValue];
}

- (void)setBarInsets:(UIEdgeInsets)barInsets
{
    objc_setAssociatedObject(self, &kBarInsetsInsetsKey, [NSValue valueWithUIEdgeInsets:barInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    LYBBarInsetsLayoutGuide *guide;
    guide = objc_getAssociatedObject(self, &kBarInsetsTopLayoutGuideKey);
    guide.length = barInsets.top;
    guide = objc_getAssociatedObject(self, &kBarInsetsBottomLayoutGuideKey);
    guide.length = barInsets.bottom;
    if ( [self isViewLoaded] ) {
        [self.view setNeedsLayout];
    }
}

- (UIEdgeInsets)defaultBarInsets
{
    return UIEdgeInsetsZero;
}

- (void)registerStatusBarObserverIfNeeded
{
    if ( objc_getAssociatedObject(self, &kBarInsetsInsetsStatusBarObserverKey) ) {
        return;
    }
    
    LYBBarInsetsStatusBarObserver *observer = [LYBBarInsetsStatusBarObserver new];
    observer.viewController = self;
    objc_setAssociatedObject(self, &kBarInsetsInsetsStatusBarObserverKey, observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)barInsetsForChildViewController:(UIViewController *)viewController insets:(UIEdgeInsets)insets
{
    UIEdgeInsets barInsets = self.barInsets;
    insets.top += barInsets.top;
    insets.bottom += barInsets.bottom;
    insets.left += barInsets.left;
    insets.right += barInsets.right;
    
    UIRectEdge edges = viewController.edgesForExtendedLayout;
    if ( ! edges & UIRectEdgeTop ) {
        insets.top = 0;
    }
    if ( ! edges & UIRectEdgeBottom ) {
        insets.bottom = 0;
    }
    if ( ! edges & UIRectEdgeLeft ) {
        insets.left = 0;
    }
    if ( ! edges & UIRectEdgeRight ) {
        insets.right = 0;
    }
    return insets;
}

@end

@implementation LYBBarInsetsLayoutGuide
{
    NSLayoutConstraint *_heightConstraint;
    NSLayoutConstraint *_widthConstraint;
}

- (id)initWithFrame:(CGRect)frame
{
    if ( ! (self = [super initWithFrame:frame]) ) {
        return nil;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:0];
    _widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:0];
    _widthConstraint.priority = 999;
    [self addConstraints:@[_widthConstraint, _heightConstraint]];
    return self;
}

- (CGFloat)length
{
    return _heightConstraint.constant;
}

- (void)setLength:(CGFloat)length
{
    _heightConstraint.constant = length;
}

@end

@implementation LYBBarInsetsStatusBarObserver


@end
