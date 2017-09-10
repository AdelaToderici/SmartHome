//
//  LuminosityViewController.m
//  SmartHome
//
//  Created by Adela Toderici on 5/11/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "LuminosityViewController.h"
#import "Constants.h"
#import "UIComponents.h"
#import "TIASmartHomeService.h"

@interface LuminosityViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *switchOnButton;

@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, assign) NSInteger colorIndex;

@end

@implementation LuminosityViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorArray = @[@0x000000, @0xfe0000, @0xff7900, @0xffb900, @0xffde00, @0xfcff00, @0xd2ff00, @0x05c000, @0x00c0a7, @0x0600ff, @0x6700bf, @0x9500c0, @0xbf0199, @0xffffff];

    [UIComponents setupBorderView:self.switchOnButton];
}

#pragma mark - Action Methods

- (IBAction)sliderValueChanged:(id)sender {
    self.colorIndex = (NSInteger)[self.colorArray objectAtIndex:(long)self.slider.value];
    self.imageView.backgroundColor = UIColorFromRGB(self.colorIndex);
}

- (IBAction)switchOnButtonPressed:(id)sender {
    [self postRoomLightColor];
}

#pragma mark - Private methods

- (void)postRoomLightColor {
    
    TIASmartHomeService *service = [TIASmartHomeService sharedInstance];
    
    if (service.serverRoot) {
        __weak typeof(self) weakSelf = self;
        [service postRoomDataWithColor:[NSString stringWithFormat:@"%li", (long)self.colorIndex]
                               success:^{
                                   [weakSelf showAlertWithTitle:@"Succeed"
                                                        andText:@"Light room changed."];
                               } failure:^(NSError *error) {
                                   [weakSelf showAlertWithTitle:@"Error"
                                                        andText:@"The operation couldn't be completed."];
                               }];
    }
}

- (void)showAlertWithTitle:(NSString *)title andText:(NSString *)text {
    
    UIAlertController *alert = [UIComponents showAlertViewWithTitle:title
                                                            message:text];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
