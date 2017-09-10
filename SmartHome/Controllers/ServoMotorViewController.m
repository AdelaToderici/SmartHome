//
//  ServoMotorViewController.m
//  SmartHome
//
//  Created by Adela Toderici on 5/11/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "ServoMotorViewController.h"
#import "BublesView.h"
#import "Constants.h"
#import "UIComponents.h"
#import "TIASmartHomeService.h"
#import "TIAWashingMachineModel.h"

@interface ServoMotorViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *RPMLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *bubbleViewContainer;

@property (nonatomic, strong) BublesView *bubblesView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *segmentedArray;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, weak)   NSTimer *timer;
@property (nonatomic, assign) BOOL isRunning;
@property (nonatomic, assign) NSInteger timeLeft;
@property (nonatomic, assign) NSInteger initialTime;

@end

@implementation ServoMotorViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isRunning = false;
    [self setupPickerView];
    [self editUIComponents];
    [self setupPanGestureRecognizer];
    [self fetchMachineData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self setupBubblesView];
}

#pragma mark - Action Methods

- (IBAction)segmentedControlAction:(id)sender {
    
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            self.segmentedArray = @[@"30℃", @"40℃",@"60℃", @"95℃"];
            break;
        case 1:
            self.segmentedArray = @[@"600", @"900", @"1200", @"1800", @"2000", @"2200"];
            break;
        case 2:
            self.segmentedArray = @[@"3 min", @"10 min", @"20 min", @"30 min", @"40 min", @"50 min"];
            break;
            
        default:
            break;
    }
    
    [self.pickerView reloadAllComponents];
    [self showPickerView];
}

- (IBAction)startAction:(id)sender {
    
    if([self.temperatureLabel.text isEqualToString:@"0"]||
       [self.RPMLabel.text isEqualToString:@"0"]||
       [self.timeLabel.text isEqualToString:@"0"]) {
        
        [self showAlertWithTitle:kWarningAlert andText:kMachineStartMessageAlert];
    } else {
        
        [self postMachineData];
    }
}

#pragma mark - Service Methods

- (void)postMachineData {
    
    TIASmartHomeService *service = [TIASmartHomeService sharedInstance];
    
    __weak typeof(self) weakSelf = self;
    
    [service postWashingMachineDataWithTemperature:self.temperatureLabel.text
                                               RPM:self.RPMLabel.text
                                              time:self.timeLabel.text
                                           success:^{
                                               if (weakSelf) {
                                                   __strong typeof(self) strongSelf = weakSelf;
                                                   [strongSelf startTimer];
                                               }
                                               
                                           } failure:^(NSError *error) {
                                               [self showAlertWithTitle:@"Error"
                                                                andText:@"The operation couldn't be completed"];
                                           }];
}

- (void)fetchMachineData {
    
    TIASmartHomeService *service = [TIASmartHomeService sharedInstance];
    
    __weak typeof(self) weakSelf = self;
    
    [service fetchMachineDataSuccess:^(TIAWashingMachineModel *machineModel) {
        if (weakSelf) {
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf reloadUIWithModel:machineModel];
            
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UIPickerView DataSource

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView
             attributedTitleForRow:(NSInteger)row
                      forComponent:(NSInteger)component {
    
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithString:self.segmentedArray[row]
                                            attributes:@{NSForegroundColorAttributeName:kNavyBlueColor}];
    return attributedString;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.segmentedArray.count;
}

#pragma mark - UIPickerViewDelegate

-(NSString*) pickerView:(UIPickerView*)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component {
    
    return self.segmentedArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    switch ((self.segmentedControl.selectedSegmentIndex)) {
        case 0:
            self.temperatureLabel.text = self.segmentedArray[row];
            break;
        case 1:
            self.RPMLabel.text = self.segmentedArray[row];
            break;
        case 2:
            self.timeLabel.text = self.segmentedArray[row];
            break;
            
        default:
            break;
    }
}

#pragma mark - AlertView Methods

- (void)showAlertWithTitle:(NSString *)title andText:(NSString *)text {
    
    UIAlertController *alert = [UIComponents showAlertViewWithTitle:title
                                                            message:text];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAlertView {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:kWarningAlert
                                                                             message:kMachineStopMessageAlert
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:kMachineStopConfirm
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          [self stopTimer];
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          [self closeAlertview];
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)closeAlertview {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private UI Methods

- (void)reloadUIWithModel:(TIAWashingMachineModel *)model {
    self.temperatureLabel.text = model.temperature;
    self.RPMLabel.text         = model.RPM;
    self.timeLabel.text        = model.time;
}

- (void)setupBubblesView {
    
    self.bubblesView = [[BublesView alloc]
                       initWithFrame:CGRectMake(0.F, 0.F,
                                                self.bubbleViewContainer.frame.size.width,
                                                self.bubbleViewContainer.frame.size.height)];
    self.bubblesView.backgroundColor = kClearColor;
    [self.bubbleViewContainer addSubview:self.bubblesView];
}

- (void)setupPickerView {
    
    self.pickerView = [[UIPickerView alloc]
                       initWithFrame:CGRectMake(0, self.view.frame.size.height,
                                                self.view.frame.size.width,
                                                self.view.frame.size.height/kFrameDivision4_5)];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.backgroundColor = kPaleTurquoiseColor;
    self.pickerView.hidden = NO;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.view addSubview:self.pickerView];
}

- (void)editUIComponents {
    
    self.segmentedControl.layer.cornerRadius = kPointSize5;
    self.pickerView.layer.cornerRadius = kCornerRadius10;
    
    [UIComponents setupBorderView:self.startButton];
}

- (void)setupPanGestureRecognizer {
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(moveViewWithGestureRecognizer:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void)createTimer {
    
    if (self.timer == nil) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(updateTimer)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

#pragma mark - Private UI Helpers

- (void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
    
    [self hidePickerView];
}

- (void)showPickerView {
    
    [self animatePickerViewWithValue:CGRectMake(0, self.view.frame.size.height/kFrameDivision1_45,
                                                self.view.frame.size.width,
                                                self.view.frame.size.height/kFrameDivision4_5)
                         andVelocity:kVelocity15_5];
}

- (void)hidePickerView {
    
    [self animatePickerViewWithValue:CGRectMake(0,
                                                self.view.frame.size.height,
                                                self.view.frame.size.width,
                                                self.view.frame.size.height/kFrameDivision4_5)
                         andVelocity:kVelocity3_5];
}

- (void)animatePickerViewWithValue:(CGRect)frame andVelocity:(CGFloat)velocity {
    
    [UIView animateWithDuration:1.0
                          delay:kDelay0_1
         usingSpringWithDamping:kVelocity18_5
          initialSpringVelocity:velocity
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         self.pickerView.frame = frame;
                     }
                     completion:nil];
}

- (void)startTimer {
    
    if(!self.isRunning) {
        
        self.isRunning = true;
        self.segmentedControl.enabled = NO;
        [self calculateMachineStartTime];
        [self calculateMachineEndTime];
        [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self createTimer];
    } else {
        
        [self showAlertView];
    }
}

- (void)updateTimer {
    
    if (_timeLeft == 0) {
        
        [self stopTimer];
    } else {
        
        self.timeLeft--;
        self.remainingTimeLabel.text = [self formattedTime:self.timeLeft];
        self.progressBar.progress += (1.0/self.initialTime);
    }
}

- (void)stopTimer {
    
    self.isRunning = false;
    self.segmentedControl.enabled = YES;
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    self.startTimeLabel.text = kBasicTime;
    self.remainingTimeLabel.text = kBasicTime;
    self.progressBar.trackTintColor = kNavyBlueColor;
    self.progressBar.progress = 0.0;
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Private Methods

- (NSString *)formattedTime:(NSInteger)totalSeconds {
    
    NSInteger seconds = totalSeconds % kSeconds60;
    NSInteger minutes = (totalSeconds / kSeconds60) % kSeconds60;
    NSInteger hours = totalSeconds / kSeconds3600;
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours, (long)minutes, (long)seconds];
}

- (void)calculateMachineStartTime {
    
    self.startDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ro_RO"]];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:self.startDate];
    self.startTimeLabel.text = dateString;
}

- (void)calculateMachineEndTime {
    
    NSString *newString = [[self.timeLabel.text componentsSeparatedByCharactersInSet:
                            [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                           componentsJoinedByString:@""];
    self.timeLeft = [newString integerValue]*kSeconds60;
    self.initialTime = self.timeLeft;
}

@end
