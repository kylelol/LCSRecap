//
//  OVPlotGraphViewCell.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/20/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "OVPlotGraphViewCell.h"

@implementation OVPlotGraphViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)segmentedSwitch:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    [self.delegate didSwitchStatsByWeekSegment:selectedSegment];
}

@end
