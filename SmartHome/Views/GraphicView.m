//
//  GraphicView.m
//  GraphicsDemo
//
//  Created by Adela Toderici on 21/12/15.
//  Copyright © 2015 Adela Toderici. All rights reserved.
//

#import "GraphicView.h"

#define MARGIN 20
#define TOP_BORDER 60
#define BOTTOM_BORDER 50
#define LABEL_SIZE 14
#define LABEL_POSITION 22
#define LABEL_WIDTH 157
#define FONT_SIZE 15.0f

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
        _titleGraphLabel = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_POSITION, LABEL_SIZE, LABEL_WIDTH, LABEL_POSITION-1)];
        _titleGraphLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:FONT_SIZE];
        _titleGraphLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleGraphLabel];
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
                                                     cornerRadii:CGSizeMake(8.0, 8.0)];
    [path addClip];
    
    startColor = [UIColor colorWithRed:70.0/255.0 green:191.0/255.0 blue:182.0/255.0 alpha:1.0];
    endColor = [UIColor colorWithRed:13.0/255.0 green:37.0/255.0 blue:63.0/255.0 alpha:1.0];
    
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
    
    margin = MARGIN;
    CGFloat topBorder = TOP_BORDER;
    bottomBorder = BOTTOM_BORDER;
    graphHeight = height - topBorder - bottomBorder;
    
    NSNumber *maxNumber = (NSNumber *)[_graphPoints valueForKeyPath:@"@max.intValue"];
    maxValue = [maxNumber intValue];
    
    // draw the line
    
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    
    UIBezierPath *graphPath = [UIBezierPath bezierPath];
    NSNumber *arrayIndex = _graphPoints[0];
    [graphPath moveToPoint:CGPointMake([self columnXPoint:0], [self columnYPoint:[arrayIndex intValue]])];
    
    for (int i=1; i < _graphPoints.count; i++) {
        arrayIndex = _graphPoints[i];
        CGPoint nextPoint = CGPointMake([self columnXPoint:i], [self columnYPoint:[arrayIndex intValue]]);
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
    
    graphPath.lineWidth = 2.0;
    [graphPath stroke];
    
    for (int i = 0; i < _graphPoints.count; i++) {
        arrayIndex = _graphPoints[i];
        CGPoint point = CGPointMake([self columnXPoint:i], [self columnYPoint:[arrayIndex intValue]]);
        point.x -= 5.0/2;
        point.y -= 5.0/2;
        
        CGSize size = {5.0, 5.0};
        CGRect rect = {point, size};
        
        UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
        [circle fill];
    }
    
    // draw horizontal lines
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    [linePath moveToPoint:CGPointMake(margin, topBorder)];
    [linePath addLineToPoint:CGPointMake(width - margin, topBorder)];
    
    [linePath moveToPoint:CGPointMake(margin, graphHeight/2 + topBorder)];
    [linePath addLineToPoint:CGPointMake(width - margin, graphHeight/2 + topBorder)];
    
    [linePath moveToPoint:CGPointMake(margin, height - bottomBorder)];
    [linePath addLineToPoint:CGPointMake(width - margin, height - bottomBorder)];
    
    UIColor *color = [UIColor colorWithWhite:1.0 alpha:0.3];
    [color setStroke];
    
    linePath.lineWidth = 1.0;
    [linePath stroke];
    
    [self setupGraphicDisplay];
}

// x point
- (CGFloat)columnXPoint:(int)column {
    
    CGFloat spacer = (width - margin*2 - 4)/(CGFloat)(_graphPoints.count-1);
    CGFloat x = (CGFloat)column * spacer;
    x += margin + 2;
    
    return x;
}

// y point
- (CGFloat)columnYPoint:(int)graphPoint {
    CGFloat y = (CGFloat)graphPoint / maxValue * graphHeight;
    y = graphHeight + TOP_BORDER - y;
    return y;
}

- (void)setupGraphicDisplay {
    
    [labelsContainer removeFromSuperview];
    
    labelsContainer = [[UIView alloc] initWithFrame:CGRectMake(0, height-bottomBorder, self.frame.size.width, self.frame.size.height/4)];
    labelsContainer.backgroundColor = [UIColor clearColor];
    
    for (NSInteger i = 0; i < _graphPoints.count; i++) {
        CGFloat xPosition = [self columnXPoint:(int)i];
        xPosition -= 5.0/2;
        
        NSInteger index = i+1;
        UILabel *xGraphLabel = [self labelWithFrame:CGRectMake(xPosition, LABEL_SIZE-2, LABEL_SIZE, LABEL_SIZE)
                                              title:[NSString stringWithFormat:@"%li", (long)index]];
        [labelsContainer addSubview:xGraphLabel];
    }
    [self addSubview:labelsContainer];
}

- (UILabel *)labelWithFrame:(CGRect)frame title:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    
    return label;
}

@end
