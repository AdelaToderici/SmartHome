//
//  GraphicView.m
//  GraphicsDemo
//
//  Created by Adela Toderici on 21/12/15.
//  Copyright © 2015 Adela Toderici. All rights reserved.
//

#import "GraphicView.h"
#import "Constants.h"
#import "UIComponents.h"

@interface GraphicView() {
    
    UIColor *startColor;
    UIColor *endColor;
    
    CGFloat margin;
    int maxValue;
    CGFloat graphHeight;
    CGFloat bottomBorder;
    
    CGFloat width;
    CGFloat height;
    
    UIView *labelsContainer;
}

@end

@implementation GraphicView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleGraphLabel = [UIComponents labelWithFrame:CGRectMake(kFrameSize22,
                                                                           kFrameSize14,
                                                                           kFrameSize157,
                                                                           kFrameSize22-1)
                                                  title:@"Temperature Flow"
                                                   font:kAvenirNextFont15
                                                  color:kWhiteColor];
        [self addSubview:titleGraphLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
//    if (rect.size.width == self.frame.size.width) return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    width = rect.size.width;
    height = rect.size.height;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(kFrameSize8,
                                                                            kFrameSize8)];
    [path addClip];
    
    startColor = kTurquoiseColor;
    endColor = kNavyBlueColor;
    
    // draw gradient
    NSArray *colors = @[(id)startColor.CGColor, (id)endColor.CGColor];
    CFArrayRef colorsRef = (__bridge CFArrayRef)colors;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat colorLocations[2] = {0.0, 1.0};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colorsRef, colorLocations);
    
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointMake(0, self.bounds.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    // create graphic
    
    margin = kMargin20;
    CGFloat topBorder = kTopBorder60;
    bottomBorder = kBottomBorder50;
    graphHeight = height - topBorder - bottomBorder;
    
    NSNumber *maxNumber = (NSNumber *)[_graphPoints valueForKeyPath:@"@max.intValue"];
    maxValue = [maxNumber intValue];
    
    // draw the line
    
    [kWhiteColor setFill];
    [kWhiteColor setStroke];
    
    UIBezierPath *graphPath = [UIBezierPath bezierPath];
    NSNumber *arrayIndex = _graphPoints[0];
    [graphPath moveToPoint:CGPointMake([self columnXPoint:0],
                                       [self columnYPoint:[arrayIndex intValue]])];
    
    for (int i=1; i < _graphPoints.count; i++) {
        arrayIndex = _graphPoints[i];
        CGPoint nextPoint = CGPointMake([self columnXPoint:i],
                                        [self columnYPoint:[arrayIndex intValue]]);
        [graphPath addLineToPoint:nextPoint];
    }
    
    CGContextSaveGState(context);
    
    // add graph points
    UIBezierPath *clippingPath = [graphPath copy];
    
    [clippingPath addLineToPoint:CGPointMake([self columnXPoint:(int)(_graphPoints.count - 1)], height)];
    [clippingPath addLineToPoint:CGPointMake([self columnXPoint:0], height)];
    [clippingPath closePath];
    [clippingPath addClip];
    
    CGFloat highestYPoint = [self columnYPoint:maxValue];
    startPoint = CGPointMake(margin, highestYPoint);
    endPoint = CGPointMake(margin, self.bounds.size.height);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    graphPath.lineWidth = kTwo;
    [graphPath stroke];
    
    for (int i = 0; i < _graphPoints.count; i++) {
        arrayIndex = _graphPoints[i];
        CGPoint point = CGPointMake([self columnXPoint:i],
                                    [self columnYPoint:[arrayIndex intValue]]);
        point.x -= kPointSize5/kTwo;
        point.y -= kPointSize5/kTwo;
        
        CGSize size = {kPointSize5, kPointSize5};
        CGRect rect = {point, size};
        
        UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
        [circle fill];
    }
    
    // draw horizontal lines
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    [linePath moveToPoint:CGPointMake(margin, topBorder)];
    [linePath addLineToPoint:CGPointMake(width - margin, topBorder)];
    
    [linePath moveToPoint:CGPointMake(margin, graphHeight/kTwo + topBorder)];
    [linePath addLineToPoint:CGPointMake(width - margin, graphHeight/kTwo + topBorder)];
    
    [linePath moveToPoint:CGPointMake(margin, height - bottomBorder)];
    [linePath addLineToPoint:CGPointMake(width - margin, height - bottomBorder)];
    
    UIColor *color = kColorWithWhite;
    [color setStroke];
    
    linePath.lineWidth = 1.0;
    [linePath stroke];
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    [self setupGraphicDisplay];
}

// x point
- (CGFloat)columnXPoint:(int)column {
    CGFloat spacer = (width - margin*kTwo - kFour)/(CGFloat)(_graphPoints.count-1);
    CGFloat x = (CGFloat)column * spacer;
    x += margin + kTwo;
    return x;
}

// y point
- (CGFloat)columnYPoint:(int)graphPoint {
    CGFloat y = (CGFloat)graphPoint / maxValue * graphHeight;
    y = graphHeight + kTopBorder60 - y;
    return y;
}

- (void)setupGraphicDisplay {
    
    [labelsContainer removeFromSuperview];
    
    labelsContainer = [[UIView alloc] initWithFrame:CGRectMake(0, height-bottomBorder,
                                                               self.frame.size.width,
                                                               self.frame.size.height/kFour)];
    labelsContainer.backgroundColor = kClearColor;
    
    for (NSInteger i = 0; i < _graphPoints.count; i++) {
        CGFloat xPosition = [self columnXPoint:(int)i];
        xPosition -= kPointSize5/kTwo;
        
        NSInteger index = i+1;
        UILabel *xGraphLabel = [UIComponents labelWithFrame:CGRectMake(xPosition,
                                                                       kFrameSize14-kTwo,
                                                                       kFrameSize14,
                                                                       kFrameSize14)
                                                      title:[NSString stringWithFormat:@"%li", (long)index]
                                                       font:kSystemFont12
                                                      color:kWhiteColor];
        [labelsContainer addSubview:xGraphLabel];
    }
    [self addSubview:labelsContainer];
}

@end
