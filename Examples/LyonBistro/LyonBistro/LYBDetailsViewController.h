//
//  LYBDetailsViewController.h
//  LyonBistro
//
//  Created by Nicolas BACHSCHMIDT on 10/10/2013.
//  Copyright (c) 2013 CocoaHeads Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYBBistro;

@interface LYBDetailsViewController : UIViewController

@property (nonatomic, readonly) LYBBistro *bistro;

- (id)initWithBistro:(LYBBistro *)bistro;

@end
