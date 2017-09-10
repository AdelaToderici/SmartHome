//
//  AuthenticationViewController.m
//  SmartHome
//
//  Created by Adela Toderici on 4/19/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "AuthenticationViewController.h"

@interface AuthenticationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation AuthenticationViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"here I am");
}

#pragma mark - Actions

- (IBAction)registerAction:(id)sender {
    
}

- (IBAction)loginAction:(id)sender {
    [self.delegate authenticationViewControllerSuccedded:self];
}

@end
