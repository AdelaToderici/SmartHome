//
//  LuminosityViewController.m
//  SmartHome
//
//  Created by Adela Toderici on 5/11/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "LuminosityViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];

@interface LuminosityViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (nonatomic, strong) NSArray *colorArray;

@end

@implementation LuminosityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorArray = @[@0x000000, @0xfe0000, @0xff7900, @0xffb900, @0xffde00, @0xfcff00, @0xd2ff00, @0x05c000, @0x00c0a7, @0x0600ff, @0x6700bf, @0x9500c0, @0xbf0199, @0xffffff];
}

- (IBAction)sliderValueChanged:(id)sender {
    int colorIndex = (int)[_colorArray objectAtIndex:(long)_slider.value];
    self.imageView.backgroundColor = UIColorFromRGB(colorIndex);
    NSLog(@"index 2 : %li", (long)_slider.value);
}


@end
