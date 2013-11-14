//
//  LYBBistro.h
//  LyonBistro
//
//  Created by Nicolas BACHSCHMIDT on 10/10/2013.
//  Copyright (c) 2013 CocoaHeads Lyon. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface LYBBistro : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *details;

- (id)initWithName:(NSString *)name details:(NSString *)details coordinate:(CLLocationCoordinate2D)coordinate;

@end
