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
#import "TIASmartHomeService.h"
#import "TIAThermostatModel.h"
#import "UIComponents.h"

@interface TemperatureViewController ()

@property (strong, nonatomic) GraphicView *graphView;
@property (nonatomic, strong) NSArray *graphArray;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *graphContentView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic, strong) TIAThermostatModel *thermostatModel;

@end

@implementation TemperatureViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupGraphView];
    
    [self fetchThermostatData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self drawGraphView];
}

#pragma mark - Private UI helpers

- (void)setupUI {
    self.switchButton.layer.cornerRadius = kCornerRadius18;
    self.segmentedControl.layer.cornerRadius = kCornerRadius6;
    [UIComponents setupBorderView:self.submitButton];
    [UIComponents setupBorderView:self.containerView];
}

- (void)drawGraphView {
    _graphView.graphPoints = self.graphArray;
    [_graphView setNeedsDisplay];
}

- (void)setupGraphView {
    self.graphArray = @[@6, @9, @5, @7, @10, @8, @3, @6, @5, @9, @4, @6];
    
    self.graphView = [[GraphicView alloc]
                      initWithFrame:CGRectMake(0, 0,
                                               self.graphContentView.frame.size.width,
                                               self.graphContentView.frame.size.height)];
    self.graphView.backgroundColor = kClearColor;
    [self.graphContentView addSubview:self.graphView];
}

- (void)reloadUI {
    
}

#pragma mark - Service methods

- (void)fetchThermostatData {
    
    __weak typeof(self) weakSelf = self;
    
    TIASmartHomeService *service = [TIASmartHomeService sharedInstance];
    
    if (service.serverRoot) {
        
        [service fetchThermostatDataSuccess:^(TIAThermostatModel *thermostatModel) {
            if (weakSelf) {
                typeof(self) strongSelf = weakSelf;
                strongSelf.thermostatModel = thermostatModel;
                [strongSelf reloadUI];
            }
        } failure:^(NSError *error) {
            
            UIAlertController *alert = [UIComponents showAlertViewWithTitle:@"Error"
                                                                    message:error.description];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    }
}

#pragma mark - Private helpers

@end
