//
//  UIViewController+BarInsets.h
//  LyonBistro
//
//  Created by Nicolas BACHSCHMIDT on 10/10/2013.
//  Copyright (c) 2013 CocoaHeads Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BarInsets)

@property (nonatomic) UIEdgeInsets barInsets;
@property (nonatomic, readonly) id <UILayoutSupport> barInsetsTopLayoutGuide;
@property (nonatomic, readonly) id <UILayoutSupport> barInsetsBottomLayoutGuide;

- (UIEdgeInsets)barInsetsForChildViewController:(UIViewController *)viewController insets:(UIEdgeInsets)insets;

@end
