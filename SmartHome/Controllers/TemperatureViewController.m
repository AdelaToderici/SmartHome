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
@property (weak, nonatomic) IBOutlet UIView *graphContentView;

@end

@implementation TemperatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.graphArray = @[@6, @9, @5, @7, @10, @8, @3, @6, @5, @9, @4, @6];
    
    self.graphView = [[GraphicView alloc]
                      initWithFrame:CGRectMake(0, 0,
                                               self.graphContentView.frame.size.width,
                                               self.graphContentView.frame.size.height)];
    self.graphView.backgroundColor = kClearColor;
    [self.graphContentView addSubview:self.graphView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self drawGraphView];
}

#pragma mark - Private Methods

- (void)setupUI {
    self.switchButton.layer.cornerRadius = kCornerRadius18;
    self.segmentedControl.layer.cornerRadius = kCornerRadius6;
    
    self.containerView.layer.borderColor = [kNavyBlueColor CGColor];
    self.containerView.layer.borderWidth = 1.0;
    self.containerView.layer.cornerRadius = kPointSize5;
}

- (void)drawGraphView {
    _graphView.graphPoints = self.graphArray;
    [_graphView setNeedsDisplay];
}

@end
