//
//  GraphicView.h
//  GraphicsDemo
//
//  Created by Adela Toderici on 21/12/15.
//  Copyright © 2015 Adela Toderici. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphicView : UIView

@property (nonatomic, strong) NSArray *graphPoints;
@property (strong, nonatomic) UILabel *titleGraphLabel;
@property (nonatomic, assign) NSInteger counter;

- (CGFloat)columnXPoint:(int)column;

@end

