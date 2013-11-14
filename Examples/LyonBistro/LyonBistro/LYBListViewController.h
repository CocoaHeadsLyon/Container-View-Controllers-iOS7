//
//  LYBListViewController.h
//  LyonBistro
//
//  Created by Nicolas BACHSCHMIDT on 10/10/2013.
//  Copyright (c) 2013 CocoaHeads Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYBListViewController : UITableViewController

@property (nonatomic, readonly) NSArray *bistros;

- (id)initWithBistros:(NSArray *)bistros;

@end
