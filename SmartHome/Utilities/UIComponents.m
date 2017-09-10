//
//  UIComponents.m
//  SmartHome
//
//  Created by Adela Toderici on 7/6/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "UIComponents.h"
#import "Constants.h"

static UIView *shadowView;

@implementation UIComponents

+ (UILabel *)labelWithFrame:(CGRect)frame
                      title:(NSString *)title
                       font:(UIFont *)font
                      color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = color;
    label.font = font;
    
    return label;
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                              image:(UIImage *)image
                        contentMode:(UIViewContentMode)content {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    imageView.contentMode = content;
    
    return imageView;
}

+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:nil];
    [alert addAction:ok];
    return alert;
}

+ (void)setupBorderView:(UIView *)view {
    
    view.layer.borderColor = [kNavyBlueColor CGColor];
    view.layer.borderWidth = 1.0;
    view.layer.cornerRadius = kPointSize5;
}

+ (UIActivityIndicatorView *)showActivityIndicatorInView:(UIViewController *)viewController {
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]
                                                  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center = viewController.view.center;
    [activityIndicator startAnimating];
    [viewController.view addSubview:activityIndicator];
    
    if (shadowView == nil) {
        shadowView = [[UIView alloc]
                      initWithFrame:CGRectMake(0, 0,
                                               viewController.view.frame.size.width,
                                               viewController.view.frame.size.height)];
        shadowView.backgroundColor = [UIColor blackColor];
        shadowView.alpha = 0.5;
        [viewController.view addSubview:shadowView];
    }

    return activityIndicator;
}

+ (void)hideActivityIndicator:(UIActivityIndicatorView *)activityIndicator {
    
    [activityIndicator stopAnimating];
    shadowView.alpha = 0;
    [shadowView removeFromSuperview];
    shadowView = nil;
    activityIndicator = nil;
}

@end
