//
//  UIComponents.h
//  SmartHome
//
//  Created by Adela Toderici on 7/6/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIComponents : NSObject

+ (UILabel *)labelWithFrame:(CGRect)frame
                      title:(NSString *)title
                       font:(UIFont *)font
                      color:(UIColor *)color;

+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                              image:(UIImage *)image
                        contentMode:(UIViewContentMode)content;

+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title
                                      message:(NSString *)message;

+ (void)setupBorderView:(UIView *)view;

+ (UIActivityIndicatorView *)showActivityIndicatorInView:(UIViewController *)viewController;

+ (void)hideActivityIndicator:(UIActivityIndicatorView *)activityIndicator;

@end
