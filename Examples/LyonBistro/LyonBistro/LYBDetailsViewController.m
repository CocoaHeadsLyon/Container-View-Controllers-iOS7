//
//  LYBDetailsViewController.m
//  LyonBistro
//
//  Created by Nicolas BACHSCHMIDT on 10/10/2013.
//  Copyright (c) 2013 CocoaHeads Lyon. All rights reserved.
//

#import "LYBDetailsViewController.h"

#import "LYBBistro.h"

@implementation LYBDetailsViewController

- (id)initWithBistro:(LYBBistro *)bistro
{
    if ( ! (self = [super initWithNibName:nil bundle:nil]) ) {
        return nil;
    }
    
    self.title = bistro.name;
    _bistro = bistro;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithBistro:nil];
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel new];
    label.text = _bistro.details;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    id topLayoutGuide = self.topLayoutGuide;
    NSDictionary *views = NSDictionaryOfVariableBindings(label, topLayoutGuide);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[label]-10-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-10-[label]" options:0 metrics:nil views:views]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
