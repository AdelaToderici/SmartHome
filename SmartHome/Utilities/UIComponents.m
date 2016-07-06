//
//  UIComponents.m
//  SmartHome
//
//  Created by Adela Toderici on 7/6/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "UIComponents.h"

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

@end
