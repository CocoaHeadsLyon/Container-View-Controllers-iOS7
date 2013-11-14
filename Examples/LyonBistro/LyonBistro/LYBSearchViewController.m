//
//  LYBSearchViewController.m
//  LyonBistro
//
//  Created by Nicolas BACHSCHMIDT on 10/10/2013.
//  Copyright (c) 2013 CocoaHeads Lyon. All rights reserved.
//

#import "LYBSearchViewController.h"

#import "LYBBistro.h"
#import "LYBListViewController.h"
#import "LYBMapViewController.h"
#import "UIViewController+BarInsets.h"

enum {
    kLYBSearchModeList,
    kLYBSearchModeMap,
};

@implementation LYBSearchViewController
{
    UIView              *_contentView;
    UIToolbar           *_toolBar;
    NSArray             *_resultBistros;
    NSInteger            _mode;
    UIViewController    *_selectedViewController;
    UIViewController    *_mapViewController;
    UIViewController    *_listViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ( ! (self = [super initWithNibName:nil bundle:nil]) ) {
        return nil;
    }
    
    [self loadResultBistros];
    self.title = @"Search";
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    _mapViewController = [[LYBMapViewController alloc] initWithBistros:_resultBistros];
    [self addChildViewController:_mapViewController];
    [_mapViewController didMoveToParentViewController:self];

    _listViewController = [[LYBListViewController alloc] initWithBistros:_resultBistros];
    [self addChildViewController:_listViewController];
    [_listViewController didMoveToParentViewController:self];
    
    _selectedViewController = [self selectedViewController:_mode];
    return self;
}

#pragma mark - View Management

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_contentView];
    
    _selectedViewController.view.frame = _contentView.bounds;
    [_contentView addSubview:_selectedViewController.view];
    
    _toolBar = [UIToolbar new];
    _toolBar.items = @[
                       [[UIBarButtonItem alloc] initWithTitle:[self titleSwitchingFromMode:_mode] style:UIBarButtonItemStylePlain target:self action:@selector(switchMode:)],
                       [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL],
                       [[UIBarButtonItem alloc] initWithTitle:@"Nav Bar" style:UIBarButtonItemStylePlain target:self action:@selector(toogleNavBarHidden:)],
                       ];
    [self.view addSubview:_toolBar];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    
    _contentView.frame = bounds;
    _selectedViewController.view.frame = bounds;
    _toolBar.frame = CGRectMake(0, bounds.size.height - 44, bounds.size.width, 44);
}

#pragma mark - Switching Mode

- (NSString *)titleSwitchingFromMode:(NSInteger)mode
{
    return mode ? @"List" : @"Map";
}

- (UIViewController *)selectedViewController:(NSInteger)mode
{
    return mode ? _mapViewController : _listViewController;
}

- (void)switchMode:(UIBarButtonItem *)sender
{
    _mode = ! _mode;
    UIViewController *lastViewController = _selectedViewController;
    UIViewController *nextViewController = [self selectedViewController:_mode];
    
    _selectedViewController = nextViewController;
    sender.title = [self titleSwitchingFromMode:_mode];
    
    [lastViewController beginAppearanceTransition:NO animated:YES];
    [nextViewController beginAppearanceTransition:YES animated:YES];
    nextViewController.view.frame = _contentView.bounds;
    nextViewController.view.hidden = YES;
    [_contentView addSubview:nextViewController.view];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView transitionWithView:_contentView duration:0.5 options:_mode ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight animations:^{
        nextViewController.view.hidden = NO;
        lastViewController.view.hidden = YES;
        
        [self setNeedsStatusBarAppearanceUpdate];
        
    } completion:^(BOOL finished) {
        lastViewController.view.hidden = NO;
        [lastViewController.view removeFromSuperview];
        [lastViewController endAppearanceTransition];
        [nextViewController endAppearanceTransition];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

#pragma mark - Loading Results

- (void)loadResultBistros
{
    NSMutableArray *bistros = [NSMutableArray new];
    for ( NSUInteger i = 0; i < 20; i++ ) {
        NSString *name = [NSString stringWithFormat:@"Bistro #%ti", i + 1];
        NSString *details = @"Le meilleur bistro de Lyon, tout simplement.\nOuvert du lundi au dimanche";
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(0, 0);
        LYBBistro *bistro = [[LYBBistro alloc] initWithName:name details:details coordinate:coordinate];
        [bistros addObject:bistro];
    }
    _resultBistros = bistros;
}

#pragma mark - Navigation Bar

- (void)toogleNavBarHidden:(UIBarButtonItem *)sender
{
    [self.navigationController setNavigationBarHidden:! self.navigationController.navigationBarHidden animated:YES];
    [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
        UIEdgeInsets insets = self.contentEdgeInsets;
        _mapViewController.barInsets = insets;
        _listViewController.barInsets = insets;
        [_mapViewController.view layoutIfNeeded];
        [_listViewController.view layoutIfNeeded];
    } completion:nil];
}

- (UIEdgeInsets)contentEdgeInsets
{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    insets.top += [self.view.window convertRect:[UIApplication sharedApplication].statusBarFrame fromWindow:nil].size.height;
    insets.top = MAX(insets.top, CGRectGetMaxY(self.navigationController.navigationBar.frame));
    insets.bottom += 44;
    return insets;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIEdgeInsets insets = self.contentEdgeInsets;
    _mapViewController.barInsets = insets;
    _listViewController.barInsets = insets;
}

#pragma mark - Status Bar Appearance

- (UIViewController *)childViewControllerForStatusBarHidden
{
    return _selectedViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return _selectedViewController;
}

@end
