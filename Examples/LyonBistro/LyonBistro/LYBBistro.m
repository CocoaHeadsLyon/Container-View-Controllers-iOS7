//
//  LYBBistro.m
//  LyonBistro
//
//  Created by Nicolas BACHSCHMIDT on 10/10/2013.
//  Copyright (c) 2013 CocoaHeads Lyon. All rights reserved.
//

#import "LYBBistro.h"

@implementation LYBBistro

- (id)initWithName:(NSString *)name details:(NSString *)details coordinate:(CLLocationCoordinate2D)coordinate
{
    if ( ! (self = [super init]) ) {
        return nil;
    }
    
    _name = name;
    _details = details;
    _coordinate = coordinate;
    return self;
}

- (id)init
{
    return [self initWithName:nil details:nil coordinate:CLLocationCoordinate2DMake(0, 0)];
}

@end
