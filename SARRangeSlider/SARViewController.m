//
//  SARViewController.m
//  SARRangeSlider
//
//  Created by Shunsuke Araki on 2012/08/25.
//  Copyright (c) 2012年 Shunsuke Araki. All rights reserved.
//

#import "SARViewController.h"
#import "SARRangeSlider.h"

@interface SARViewController ()

@end

@implementation SARViewController
{
	IBOutlet SARRangeSlider *oRangeSlider1;
	IBOutlet SARRangeSlider *oRangeSlider2;
	IBOutlet SARRangeSlider *oRangeSlider3;
	IBOutlet UILabel *oLabel1;
	IBOutlet UILabel *oLabel2;
	IBOutlet UILabel *oLabel3;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	oRangeSlider1.lockLength = 0.2;
	
	oRangeSlider2.minimumValue = 20;
	oRangeSlider2.maximumValue = 200;
	oRangeSlider2.lockLength = 50;
	[oRangeSlider2 setLeftValue:30 rightValue:150];

	[oRangeSlider3 setLeftValue:0.2 rightValue:0.5];

	[self rangeSlider1ValueChanged:oRangeSlider1];
	[self rangeSlider2ValueChanged:oRangeSlider2];
	[self rangeSlider3ValueChanged:oRangeSlider3];
}

- (void)viewDidUnload
{
	oRangeSlider1 = nil;
	oRangeSlider2 = nil;
	oRangeSlider3 = nil;
	oLabel1 = nil;
	oLabel2 = nil;
	oLabel3 = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (IBAction)rangeSlider1ValueChanged:(SARRangeSlider *)sender {
	oLabel1.text = [NSString stringWithFormat:@"left=%.1f, right=%.1f, min=%.1f, max=%.1f, minRange=%.1f", sender.leftValue, sender.rightValue, sender.minimumValue, sender.maximumValue, sender.lockLength];
}

- (IBAction)rangeSlider2ValueChanged:(SARRangeSlider *)sender {
	oLabel2.text = [NSString stringWithFormat:@"left=%.1f, right=%.1f, min=%.1f, max=%.1f, minRange=%.1f", sender.leftValue, sender.rightValue, sender.minimumValue, sender.maximumValue, sender.lockLength];
}

- (IBAction)rangeSlider3ValueChanged:(SARRangeSlider *)sender {
	oLabel3.text = [NSString stringWithFormat:@"left=%.1f, right=%.1f, min=%.1f, max=%.1f, minRange=%.1f", sender.leftValue, sender.rightValue, sender.minimumValue, sender.maximumValue, sender.lockLength];
}

@end
