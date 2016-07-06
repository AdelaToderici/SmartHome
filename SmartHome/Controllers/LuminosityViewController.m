//
//  LuminosityViewController.m
//  SmartHome
//
//  Created by Adela Toderici on 5/11/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "LuminosityViewController.h"
#import "Constants.h"

@interface LuminosityViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *switchOnButton;

@property (nonatomic, strong) NSArray *colorArray;

@end

@implementation LuminosityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorArray = @[@0x000000, @0xfe0000, @0xff7900, @0xffb900, @0xffde00, @0xfcff00, @0xd2ff00, @0x05c000, @0x00c0a7, @0x0600ff, @0x6700bf, @0x9500c0, @0xbf0199, @0xffffff];
    
    self.switchOnButton.layer.borderColor = [kNavyBlueColor CGColor];
    self.switchOnButton.layer.cornerRadius = kCornerRadius12;
    self.switchOnButton.layer.borderWidth = 1.0;
}

- (IBAction)sliderValueChanged:(id)sender {
    int colorIndex = (int)[_colorArray objectAtIndex:(long)_slider.value];
    self.imageView.backgroundColor = UIColorFromRGB(colorIndex);
}

@end
