//
//  LYBMapViewController.m
//  LyonBistro
//
//  Created by Nicolas BACHSCHMIDT on 10/10/2013.
//  Copyright (c) 2013 CocoaHeads Lyon. All rights reserved.
//

#import "LYBMapViewController.h"
#import <MapKit/MapKit.h>

#import "UIViewController+BarInsets.h"

@implementation LYBMapViewController

- (id)initWithBistros:(NSArray *)bistros
{
    if ( ! (self = [super initWithNibName:nil bundle:nil]) ) {
        return nil;
    }
    
    _bistros = bistros;
    self.view.backgroundColor = [UIColor redColor];
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithBistros:nil];
}

- (void)loadView
{
    self.view = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    UILabel *label = [UILabel new];
    label.text = [NSString stringWithFormat:@"%td bistros", _bistros.count];
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    
    id topLayoutGuide = self.barInsetsTopLayoutGuide;
    NSDictionary *views = NSDictionaryOfVariableBindings(label, topLayoutGuide);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[label]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-10-[label]" options:0 metrics:nil views:views]];
}

@end
