//
//  AuthenticationViewController.h
//  SmartHome
//
//  Created by Adela Toderici on 4/19/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TIAAuthenticationViewControllerDelegate;

@interface AuthenticationViewController : UIViewController

@property (nonatomic, weak) id<TIAAuthenticationViewControllerDelegate> delegate;

@end

@protocol TIAAuthenticationViewControllerDelegate

- (void)authenticationViewControllerSuccedded:(AuthenticationViewController *)viewController;

@end
