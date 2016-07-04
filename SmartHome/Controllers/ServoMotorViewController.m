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

@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (nonatomic, strong) BublesView *bublesView;
@property (nonatomic, strong) NSArray *segmentedArray;

@end

@implementation ServoMotorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBublesView];
    
    self.segmentedControl.layer.cornerRadius = 5.0;
    
    self.startButton.layer.borderColor = [[UIColor colorWithRed:13.0/255.0 green:37.0/255.0 blue:63.0/255.0 alpha:1.0] CGColor];
    self.startButton.layer.cornerRadius = 28.0;
    self.startButton.layer.borderWidth = 1.0;
}

- (void)setupBublesView {
    self.bublesView = [[BublesView alloc] initWithFrame:CGRectMake(0, Y_ORG, self.view.frame.size.width, self.view.frame.size.height/3.5)];
    self.bublesView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.bublesView];
}

- (IBAction)segmentedControlAction:(id)sender {
    switch ((self.segmentedControl.selectedSegmentIndex)) {
        case 0:
            self.segmentedArray = @[@"30℃", @"60℃", @"90℃"];
            break;
        case 1:
            self.segmentedArray = @[@"600", @"900", @"1200", @"1800", @"2000", @"2200"];
            break;
        case 2:
            self.segmentedArray = @[@"40 min", @"1h", @"1h 30min", @"2h", @"3h"];
            break;
            
        default:
            break;
    }
}

- (IBAction)startAction:(id)sender {
    
}

@end
