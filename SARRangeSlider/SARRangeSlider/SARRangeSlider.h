//
//  SARRangeSlider.h
//  SARRangeSlider
//
//  Created by Shunsuke Araki on 2012/08/25.
//  Copyright (c) 2012年 Shunsuke Araki. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct SARRangeSettings {
	float lockLength;
	float minimum;
	float maximum;
} SARRangeSetting;

//typedef struct SARRangeValue {
//	float left;
//	float right;
//}SARRangeValue;

@interface SARRangeSlider : UIControl

//@property (nonatomic) SARRangeSetting setting;

// lockRength is the minimum range of the leftValue and rightValue.
// This property work only by user operation, but it is not work by programmatically changed.
@property (nonatomic) float lockLength;

@property (nonatomic) float minimumValue;
@property (nonatomic) float maximumValue;
@property (nonatomic, readonly) float leftValue;
@property (nonatomic, readonly) float rightValue;
- (void)setLeftValue:(float)leftValue rightValue:(float)rightValue;
//- (void)setMinimum:(float)minimum maximum:(float)maximum lockLength:(float)lockLength;
//@property (nonatomic) SARRangeValue value;
@end
