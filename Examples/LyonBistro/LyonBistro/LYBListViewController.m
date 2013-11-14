//
//  LYBListViewController.m
//  LyonBistro
//
//  Created by Nicolas BACHSCHMIDT on 10/10/2013.
//  Copyright (c) 2013 CocoaHeads Lyon. All rights reserved.
//

#import "LYBListViewController.h"

#import "LYBBistro.h"
#import "LYBDetailsViewController.h"

#import "UIViewController+BarInsets.h"

@implementation LYBListViewController

- (id)initWithBistros:(NSArray *)bistros
{
    if ( ! (self = [super initWithStyle:UITableViewStylePlain]) ) {
        return nil;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _bistros = bistros;
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self initWithBistros:nil];
}

#pragma mark - View Loading

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.contentInset = self.barInsets;
    self.tableView.scrollIndicatorInsets = self.barInsets;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Bistro"];
}

#pragma mark - Bar Insets

- (void)setBarInsets:(UIEdgeInsets)barInsets
{
    [super setBarInsets:barInsets];
    self.tableView.contentInset = barInsets;
    self.tableView.scrollIndicatorInsets = barInsets;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bistros.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYBBistro *bistro = _bistros[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Bistro"];
    cell.textLabel.text = bistro.name;
    cell.backgroundColor = [UIColor darkGrayColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYBBistro *bistro = _bistros[indexPath.row];
    [self.navigationController pushViewController:[[LYBDetailsViewController alloc] initWithBistro:bistro] animated:YES];
}

#pragma mark - Status Bar Appearance

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
