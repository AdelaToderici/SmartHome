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
#import "TIATemperatureModel.h"
#import "UIComponents.h"

@interface TemperatureViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *graphContentView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) GraphicView *graphView;
@property (nonatomic, strong) NSArray *graphArray;
@property (nonatomic, strong) TIAThermostatModel *thermostatModel;

@end

@implementation TemperatureViewController

#pragma mark - View Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(authenticationRequired:)
                                                 name:TIAServiceAuthRequireNotification
                                               object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self fetchTemperatureData];
    [self fetchThermostatData];
}

#pragma mark - Notifications

- (void)authenticationRequired:(NSNotification *)notification {
    
    if (self.presentedViewController == nil) {
        [self performSegueWithIdentifier:@"AuthenticationSegue" sender:nil];
    }
}

#pragma mark - CCVAuthenticationViewControllerDelegate

- (void)authenticationViewControllerSuccedded:(AuthenticationViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self fetchThermostatData];
}

#pragma mark - Private UI methods

- (void)setupUI {
    self.switchButton.layer.cornerRadius = kCornerRadius18;
    self.segmentedControl.layer.cornerRadius = kCornerRadius6;
    self.switchButton.tintColor = kNavyBlueColor;
    self.switchButton.onTintColor = kTurquoiseColor;
    [UIComponents setupBorderView:self.submitButton];
    [UIComponents setupBorderView:self.containerView];
}

- (void)drawGraphView {
    self.graphView.graphPoints = self.graphArray;
    [self.graphView setNeedsDisplay];
}

- (void)setupGraphView {
    
    self.graphView = [[GraphicView alloc]
                      initWithFrame:CGRectMake(0, 0,
                                               self.graphContentView.bounds.size.width,
                                               self.graphContentView.bounds.size.height)];
    self.graphView.backgroundColor = kClearColor;
    self.graphView.clipsToBounds = YES;
    [self.graphContentView addSubview:self.graphView];
}

- (void)reloadUI {
    if (self.thermostatModel != nil) {
        [self.switchButton setOn:[self.thermostatModel.thermostatStatus integerValue] animated:YES];
        self.segmentedControl.selectedSegmentIndex = [self.thermostatModel.temperatureType integerValue];
        if ([self.thermostatModel.temperatureType isEqualToString:@"1"]) {
            [self calculateFahrenheit];
        }
    }
}

- (void)calculateCelsius {
    
    if (self.graphArray.count > 0) {
        
        NSMutableArray *changedValues = [[NSMutableArray alloc] init];
        // fahrenheit -> celsius is (fahrenheit - 32) / 1.8
        NSInteger value;
        NSInteger temperatureValue;
        for (NSInteger i = 0; i < self.graphArray.count; i++) {
            temperatureValue = [self.graphArray[i] integerValue];
            value = (NSInteger)[self calculateCelsiusValue:temperatureValue];
            [changedValues addObject:[NSNumber numberWithInteger:value]];
        }
        
        self.graphArray = changedValues;
        
        self.temperatureLabel.text = [NSString stringWithFormat:@"%@℃", self.graphArray.firstObject];
        self.graphView.isFahrenheit = NO;
        [self drawGraphView];
    }
}

- (void)calculateFahrenheit {
    
    if (self.graphArray.count > 0) {
        
        NSMutableArray *changedValues = [[NSMutableArray alloc] init];
        // celsius -> fahrenheit is (celsius * 1.8) + 32
        NSInteger value;
        NSInteger temperatureValue;
        for (NSInteger i = 0; i < self.graphArray.count; i++) {
            temperatureValue = [self.graphArray[i] integerValue];
            value = (NSInteger)[self calculateFahrenheitValue:temperatureValue];
            [changedValues addObject:[NSNumber numberWithInteger:value]];
        }
        
        self.graphArray = changedValues;
        
        self.temperatureLabel.text = [NSString stringWithFormat:@"%@℉", self.graphArray.firstObject];
        self.graphView.isFahrenheit = YES;
        [self drawGraphView];
    }
}

- (Float32)calculateFahrenheitValue:(NSInteger)temperatureValue {
    
    return roundf((temperatureValue * 1.8) + 32);
}

- (Float32)calculateCelsiusValue:(NSInteger)temperatureValue {
    
    return roundf((temperatureValue - 32) / 1.8);
}

- (void)enableTemperatureValues:(BOOL)enabled {
    self.temperatureLabel.alpha = (enabled) ? 1 : 0.5;
    self.segmentedControl.enabled = enabled;
}

#pragma mark - Actions

- (IBAction)segmentedControlAction:(id)sender {
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            [self calculateCelsius];
            break;
        case 1:
            [self calculateFahrenheit];
            break;
            
        default:
            break;
    }
}

- (IBAction)SubmitAction:(id)sender {
    
    [self postThermostatData];
}

#pragma mark - Service methods

- (void)fetchThermostatData {
    
    TIASmartHomeService *service = [TIASmartHomeService sharedInstance];
    
     __weak typeof(self) weakSelf = self;
    
    if (service.serverRoot) {
        
        [service fetchThermostatDataSuccess:^(TIAThermostatModel *thermostatModel) {
            if (weakSelf) {
                __strong typeof(self) strongSelf = weakSelf;
                strongSelf.thermostatModel = thermostatModel;
                [strongSelf reloadUI];
                [UIComponents hideActivityIndicator:self.activityIndicator];
            }
        } failure:^(NSError *error) {
            if (weakSelf) {
                __strong typeof(self) strongSelf = weakSelf;
                UIAlertController *alert = [UIComponents showAlertViewWithTitle:@"Error"
                                                                    message:error.description];
                [strongSelf presentViewController:alert animated:YES completion:nil];
                
                [UIComponents hideActivityIndicator:self.activityIndicator];
            }
        }];
    }
}

- (void)fetchTemperatureData {
    
    self.activityIndicator = [UIComponents showActivityIndicatorInView:self];

    TIASmartHomeService *service = [TIASmartHomeService sharedInstance];
    
     __weak typeof(self) weakSelf = self;
    
    [service fetchTemperatureDataSuccess:^(NSArray *temperatureArray) {
        if (weakSelf) {
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf fillTemperatureGraphWithArray:temperatureArray];
        }
    } failure:^(NSError *error) {
        if (weakSelf) {
            __strong typeof(self) strongSelf = weakSelf;
            UIAlertController *alert = [UIComponents showAlertViewWithTitle:@"Error"
                                                                    message:error.description];
            [strongSelf presentViewController:alert animated:YES completion:nil];
            
            [UIComponents hideActivityIndicator:self.activityIndicator];
        }
    }];
}

- (void)postThermostatData {
    
    TIASmartHomeService *service = [TIASmartHomeService sharedInstance];
    
    __weak typeof(self) weakSelf = self;
    
    [service postThermostatDataWithTemperatureType:[NSString stringWithFormat:@"%li", (long)self.segmentedControl.selectedSegmentIndex]
                                  thermostatStatus:[NSString stringWithFormat:@"%i", self.switchButton.isOn]
                                           success:^{
                                               if (weakSelf) {
                                                   __strong typeof(self) strongSelf = weakSelf;
                                                   [strongSelf enableTemperatureValues:self.switchButton.isOn];
                                                   
                                                   NSString *message = @"Thermostat status changed.";
                                                   UIAlertController *alert = [UIComponents showAlertViewWithTitle:@"Succeed"
                                                                                                           message:message];
                                                   [strongSelf presentViewController:alert animated:YES completion:nil];
                                               }
                                           } failure:^(NSError *error) {
                                               if (weakSelf) {
                                                   __strong typeof(self) strongSelf = weakSelf;
                                                   UIAlertController *alert = [UIComponents showAlertViewWithTitle:@"Error"
                                                                                                           message:error.description];
                                                   [strongSelf presentViewController:alert animated:YES completion:nil];
                                               }
                                           }];
}

#pragma mark - Private helpers

- (void)fillTemperatureGraphWithArray:(NSArray *)temperaureArray {
    
    if (temperaureArray.count > 0) {
        NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
        
        for(TIATemperatureModel *temperatureModel in temperaureArray) {
            
            [valuesArray addObject:[NSNumber numberWithInteger:temperatureModel.temperatureValue]];
        }
        
        self.graphArray = valuesArray;
        self.temperatureLabel.text = [NSString stringWithFormat:@"%@℃", self.graphArray.firstObject];

        [self setupGraphView];
        [self drawGraphView];
    }
}

@end
