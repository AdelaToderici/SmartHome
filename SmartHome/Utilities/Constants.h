//
//  Constants.h
//  SmartHome
//
//  Created by Adela Toderici on 7/6/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

// Colors
#define kNavyBlueColor [UIColor colorWithRed:13.0/255.0 green:37.0/255.0 blue:63.0/255.0 alpha:1.0]
#define kPaleTurquoiseColor [UIColor colorWithRed:170.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1.0]
#define kTurquoiseColor [UIColor colorWithRed:70.0/255.0 green:191.0/255.0 blue:182.0/255.0 alpha:1.0]
#define kWhiteColor [UIColor whiteColor]
#define kColorWithWhite [UIColor colorWithWhite:1.0 alpha:0.3]
#define kClearColor [UIColor clearColor]

// Special Color Constant
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];

// Fonts
#define kAvenirNextFont17 [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:17.0]
#define kAvenirNextFont15 [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:15.0]
#define kSystemFont12 [UIFont systemFontOfSize:12]

// Frame Size
#define kMargin20 20
#define kTopBorder60 60
#define kBottomBorder50 50

#define kFrameSize14 14
#define kFrameSize22 22
#define kFrameSize157 157
#define kPointSize5 5.0
#define kFrameSize40 40
#define kFrameSize21 21
#define kFrameSize30 30
#define kFrameSize83 83
#define kFrameSize124 124
#define kFrameSize86 86
#define kNavBarHeight 64
#define kFrameSize8 8.0

#define kFrameDivision3_5 3.5
#define kFrameDivision4_5 4.5
#define kFrameDivision1_45 1.45
#define kFrameDivision2_7 2.7

#define kCornerRadius10 10.0
#define kCornerRadius28 28.0
#define kCornerRadius18 18.0
#define kCornerRadius6 6.0
#define kCornerRadius12 12.0

#define kTwo 2
#define kFour 4

// Gradient
#define kGradient0_3 0.3
#define kGradient0_9 0.9

// Animations
#define kVelocity15_5 15.5
#define kVelocity3_5 3.5
#define kVelocity18_5 18.5
#define kDelay0_1 0.1
#define kSeconds3600 3600
#define kSeconds60 60

// Alert Text
#define kBasicTime @"00:00:00"
#define kWarningAlert @"Warning"
#define kMachineStartMessageAlert @"You have to complete the 'Temperature', 'RPM' and 'Time' fileds before you start the washing process."
#define kMachineStopMessageAlert @"Are you sure you want to stop this washing process?"
#define kMachineStopConfirm @"Yes, I want it!"



#endif /* Constants_h */
