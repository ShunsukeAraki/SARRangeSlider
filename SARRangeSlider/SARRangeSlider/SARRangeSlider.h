//
//  SARRangeSlider.h
//  SARRangeSlider
//
//  Created by Shunsuke Araki on 2012/08/25.
//  Copyright (c) 2012年 Shunsuke Araki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SARRangeSlider : UIControl

@property (nonatomic) float leftValue;
@property (nonatomic) float rightValue;
@property (nonatomic) float minimumRange;
@property (nonatomic) float minimumValue;
@property (nonatomic) float maximumValue;
@end
