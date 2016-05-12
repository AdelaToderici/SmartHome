//
//  TemperatureViewController.m
//  SmartHome
//
//  Created by Adela Toderici on 5/11/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "TemperatureViewController.h"
#import "GraphicView.h"

#define Y_ORIGIN 86
#define DAMPING_VALUE 70.0f
#define VELOCITY_VALUE 10.0f

@interface TemperatureViewController ()

@property (strong, nonatomic) GraphicView *graphView;
@property (nonatomic, strong) NSArray *graphArray;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation TemperatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.switchButton.layer.cornerRadius = 18.0;
    self.segmentedControl.layer.cornerRadius = 6.0;
    
    self.containerView.layer.borderColor = [[UIColor colorWithRed:13.0/255.0 green:37.0/255.0 blue:63.0/255.0 alpha:1.0] CGColor];
    self.containerView.layer.borderWidth = 1.0;
    self.containerView.layer.cornerRadius = 5.0;
    
    self.graphArray = @[@6, @9, @5, @7, @10, @8, @3, @6, @5, @9, @4, @6];
    
    self.graphView = [[GraphicView alloc] initWithFrame:CGRectMake(20, Y_ORIGIN, self.view.frame.size.width-40, self.view.frame.size.height/2.7)];
    self.graphView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.graphView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self drawGraphView];
}

- (void)drawGraphView {
    _graphView.graphPoints = self.graphArray;
    _graphView.titleGraphLabel.text = @"Temperature Flow";
    [_graphView setNeedsDisplay];
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
