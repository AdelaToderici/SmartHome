//
//  BublesView.m
//  SmartHome
//
//  Created by Adela Toderici on 5/12/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "BublesView.h"
#import "Constants.h"
#import "UIComponents.h"

@implementation BublesView


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(0, 0)];
    [path addClip];
    
    UIColor *startColor = kWhiteColor;
    UIColor *middleColor = kTurquoiseColor;
    UIColor *endColor = kNavyBlueColor;
    
    // draw gradient
    NSArray *colors = @[(id)startColor.CGColor, (id)middleColor.CGColor, (id)endColor.CGColor];
    CFArrayRef colorsRef = (__bridge CFArrayRef)colors;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat colorLocations[3] = {0.0, kGradient0_3, kGradient0_9};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colorsRef, colorLocations);
    
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointMake(0, self.bounds.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    [self setupBublesImage];
    [self setupServoLabes];
}

- (void)setupBublesImage {
    UIImageView *imageView = [UIComponents imageViewWithFrame:CGRectMake(0, 0,
                                                                         self.frame.size.width,
                                                                         self.frame.size.height-kFrameSize40)
                                                        image:[UIImage imageNamed:@"buble_final.png"]
                                                  contentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:imageView];
}

- (void)setupServoLabes {
    UILabel *startLabel = [UIComponents labelWithFrame:CGRectMake(kMargin20,
                                                                  self.frame.size.height-kFrameSize30,
                                                                  kFrameSize83, kFrameSize21)
                                                 title:@"Start Time"
                                                  font:kAvenirNextFont17
                                                 color:kWhiteColor];
    [self addSubview:startLabel];
    
    UILabel *remainingLabel = [UIComponents labelWithFrame:CGRectMake(self.frame.size.width-kFrameSize124,
                                                                      self.frame.size.height-kFrameSize30,
                                                                      kFrameSize124, kFrameSize21)
                                                     title:@"Remaining Time"
                                                      font:kAvenirNextFont17
                                                     color:kWhiteColor];
    [self addSubview:remainingLabel];
}

@end
