//
//  BublesView.m
//  SmartHome
//
//  Created by Adela Toderici on 5/12/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "BublesView.h"

@implementation BublesView


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(0, 0)];
    [path addClip];
    
    UIColor *startColor = [UIColor whiteColor];
    UIColor *middleColor = [UIColor colorWithRed:70.0/255.0 green:191.0/255.0 blue:182.0/255.0 alpha:1.0];
    UIColor *endColor = [UIColor colorWithRed:13.0/255.0 green:37.0/255.0 blue:63.0/255.0 alpha:1.0];
    
    // draw gradient
    NSArray *colors = @[(id)startColor.CGColor, (id)middleColor.CGColor, (id)endColor.CGColor];
    CFArrayRef colorsRef = (__bridge CFArrayRef)colors;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat colorLocations[4] = {0.0, 0.3, 0.9};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colorsRef, colorLocations);
    
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointMake(0, self.bounds.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    [self setupBublesImage];
}

- (void)setupBublesImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-40)];
    imageView.image = [UIImage imageNamed:@"buble_final.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
}


@end
