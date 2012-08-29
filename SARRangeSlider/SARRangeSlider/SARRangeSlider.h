//
//  SARRangeSlider.h
//  SARRangeSlider
//
//  Created by Shunsuke Araki on 2012/08/25.
//  Copyright (c) 2012年 Shunsuke Araki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SARRangeSlider : UIControl

// lockRength is the minimum range of the leftValue and rightValue.
// This property work only by user operation, but it is not work by programmatically changed.
@property (nonatomic) float lockLength;

@property (nonatomic) float minimumValue;
@property (nonatomic) float maximumValue;
@property (nonatomic, readonly) float leftValue;
@property (nonatomic, readonly) float rightValue;
- (void)setLeftValue:(float)leftValue rightValue:(float)rightValue;
@end
