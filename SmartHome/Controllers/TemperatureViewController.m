//
//  TemperatureViewController.m
//  SmartHome
//
//  Created by Adela Toderici on 5/11/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "TemperatureViewController.h"
#import "GraphicView.h"
#import "Constants.h"

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
    
    self.switchButton.layer.cornerRadius = kCornerRadius18;
    self.segmentedControl.layer.cornerRadius = kCornerRadius6;
    
    self.containerView.layer.borderColor = [kNavyBlueColor CGColor];
    self.containerView.layer.borderWidth = 1.0;
    self.containerView.layer.cornerRadius = kPointSize5;
    
    self.graphArray = @[@6, @9, @5, @7, @10, @8, @3, @6, @5, @9, @4, @6];
    
    self.graphView = [[GraphicView alloc]
                      initWithFrame:CGRectMake(kMargin20,
                                               kFrameSize86,
                                               self.view.frame.size.width-kFrameSize40,
                                               self.view.frame.size.height/kFrameDivision2_7)];
    self.graphView.backgroundColor = kClearColor;
    [self.view addSubview:self.graphView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self drawGraphView];
}

- (void)drawGraphView {
    _graphView.graphPoints = self.graphArray;
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
