//
//  ServoMotorViewController.m
//  SmartHome
//
//  Created by Adela Toderici on 5/11/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "ServoMotorViewController.h"
#import "BublesView.h"

#define Y_ORG 70

@interface ServoMotorViewController ()

@property (nonatomic, strong) BublesView *bublesView;

@end

@implementation ServoMotorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bublesView = [[BublesView alloc] initWithFrame:CGRectMake(0, Y_ORG, self.view.frame.size.width, self.view.frame.size.height/2.5)];
    self.bublesView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.bublesView];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
