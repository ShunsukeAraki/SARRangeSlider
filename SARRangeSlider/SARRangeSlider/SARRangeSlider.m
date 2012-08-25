//
//  SARRangeSlider.m
//  SARRangeSlider
//
//  Created by Shunsuke Araki on 2012/08/25.
//  Copyright (c) 2012年 Shunsuke Araki. All rights reserved.
//

#import "SARRangeSlider.h"
#import <QuartzCore/QuartzCore.h>

#define CORNER_RADIUS   5.0
#define HANDLE_WIDTH	12.0

#pragma mark - SARRangeSliderHandleView

typedef enum HandleDirection : NSUInteger {
	LeftDirection,
	RightDirection,
}HandleDirection;

@interface SARRangeSliderHandleView : UIView

@end

@implementation SARRangeSliderHandleView

- (id)initWithParentView:(UIView *)parentView andDirection:(HandleDirection)direction {
	self = [super init];
	if (self) {
		switch (direction) {
			case LeftDirection:
				self.frame = CGRectMake(0, 0, HANDLE_WIDTH, parentView.frame.size.height);
				break;
			case RightDirection:
				self.frame = CGRectMake(parentView.frame.size.width - HANDLE_WIDTH, 0, HANDLE_WIDTH, parentView.frame.size.height);
				break;
			default:
				break;
		}
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	// draw two vertical black line
	CGFloat lineLength = rect.size.height / 2;
	CGFloat lineTop = rect.size.height / 2 / 2;
	UIBezierPath *bpath = [UIBezierPath bezierPath];
	bpath.lineWidth = 1.0;
	[[UIColor blackColor] setStroke];
	[bpath moveToPoint:CGPointMake( HANDLE_WIDTH / 2 - 2, lineTop )];
	[bpath addLineToPoint:CGPointMake( HANDLE_WIDTH / 2 - 2, lineTop + lineLength)];
	[bpath closePath];
	[bpath stroke];
	[bpath moveToPoint:CGPointMake( HANDLE_WIDTH / 2 + 2, lineTop )];
	[bpath addLineToPoint:CGPointMake( HANDLE_WIDTH / 2 + 2, lineTop + lineLength)];
	[bpath closePath];
	[bpath stroke];
}

@end

#pragma mark - SARRangeSlider
@implementation SARRangeSlider
{
	UIView *sliderView;
	UIView *leftHandleView;
	UIView *rightHandleView;
}

#pragma mark property
- (void)setLeftValue:(float)leftValue {
	if (leftValue < self.minimumValue) {
		leftValue = self.minimumValue;
	}
    
	if (leftValue + self.minimumRange > self.rightValue) {
		leftValue = self.rightValue - self.minimumRange;
	}
	
	_leftValue = leftValue;
    
	[self setNeedsLayout];
}

- (void)setRightValue:(float)rightValue {
	if (rightValue > self.maximumValue) {
		rightValue = self.maximumValue;
	}

    if (rightValue - self.minimumRange < self.leftValue) {
		rightValue = self.leftValue + self.minimumRange;
	}
	
	_rightValue = rightValue;
    
	[self setNeedsLayout];
}

- (void)setMinimumRange:(float)minimumRange {
	_minimumRange = minimumRange;
	[self setNeedsLayout];
}

- (void)setMinimumValue:(float)minimumValue {
	_minimumValue = minimumValue;
	[self setNeedsLayout];
}

- (void)setMaximumValue:(float)maximumValue {
	_maximumValue = maximumValue;
	[self setNeedsLayout];
}

#pragma mark initilize
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setup];
	}
	return self;
}

- (void)setup {
	// setup basics
	self.backgroundColor = [UIColor clearColor];
	self.minimumValue = 0.0;
	self.maximumValue = 1.0;
	self.leftValue = 0.0;
	self.rightValue = 1.0;
	self.minimumRange = 0.0;
	
    // setup base layer
	sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
	sliderView.backgroundColor = [UIColor yellowColor];
    sliderView.layer.cornerRadius = CORNER_RADIUS;
    sliderView.layer.masksToBounds = YES;
    sliderView.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.75].CGColor;
    sliderView.layer.borderWidth = 1.0;
	
    // setup gradient layer
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.contentsScale = [[UIScreen mainScreen] scale];
    gradientLayer.frame = sliderView.bounds;
    gradientLayer.locations = [NSArray arrayWithObjects:
							   [NSNumber numberWithFloat:0.0],
							   [NSNumber numberWithFloat:0.5],
							   [NSNumber numberWithFloat:0.5],
							   [NSNumber numberWithFloat:1.0],
							   nil];
	gradientLayer.colors = [NSArray arrayWithObjects:
							(id)[UIColor colorWithWhite:1 alpha:0.7].CGColor,
							(id)[UIColor colorWithWhite:1 alpha:0.4].CGColor,
							(id)[UIColor colorWithWhite:1 alpha:0.3].CGColor,
							(id)[UIColor colorWithWhite:1 alpha:0.0].CGColor,
							nil];
	
	[sliderView.layer addSublayer:gradientLayer];
	
	// setup handle
	leftHandleView = [[SARRangeSliderHandleView alloc] initWithParentView:self andDirection:LeftDirection];
	rightHandleView = [[SARRangeSliderHandleView alloc] initWithParentView:self andDirection:RightDirection];
	UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftPan:)];
	[leftHandleView addGestureRecognizer:leftPan];
	UIPanGestureRecognizer *rightPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightPan:)];
	[rightHandleView addGestureRecognizer:rightPan];

	[self addSubview:sliderView];
	[self addSubview:leftHandleView];
	[self addSubview:rightHandleView];
}

#pragma mark draw
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
	
	// TODO:スライダー内部を透明にする
}

- (void)layoutSubviews {
    CGFloat availableWidth = self.frame.size.width - HANDLE_WIDTH * 2;
    
    CGFloat rangeValue = self.maximumValue - self.minimumValue;
    
    CGFloat leftPoint = floorf((self.leftValue - self.minimumValue) / rangeValue * availableWidth);
    CGFloat rightPoint = floorf((self.rightValue - self.minimumValue) / rangeValue * availableWidth);
    if (isnan(leftPoint)) {
        leftPoint = 0;
    }
    
    if (isnan(rightPoint)) {
        rightPoint = 0;
    }

    CGFloat rangeWidth = rightPoint - leftPoint;
	CGRect frame = sliderView.frame;
	frame.origin.x = leftPoint;
	frame.size.width = rangeWidth + HANDLE_WIDTH * 2;
	sliderView.frame = frame;
    
    leftHandleView.center = CGPointMake(leftPoint + HANDLE_WIDTH / 2, self.frame.size.height / 2);
    rightHandleView.center = CGPointMake(rightPoint + HANDLE_WIDTH + HANDLE_WIDTH / 2, self.frame.size.height / 2);
}

- (void)handleLeftPan:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];
        CGFloat rangeValue = self.maximumValue - self.minimumValue;
        CGFloat availableWidth = self.frame.size.width - HANDLE_WIDTH * 2;
        self.leftValue += translation.x / availableWidth * rangeValue;
        
        [gesture setTranslation:CGPointZero inView:self];
        
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
}

- (void)handleRightPan:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];
        CGFloat rangeValue = self.maximumValue - self.minimumValue;
        CGFloat availableWidth = self.frame.size.width - HANDLE_WIDTH * 2;
        self.rightValue += translation.x / availableWidth * rangeValue;
        
        [gesture setTranslation:CGPointZero inView:self];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
