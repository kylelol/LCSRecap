//
//  OVPlotGraphViewCell.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/20/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OVPlotGraphViewCellDelegate <NSObject>

-(void)didSwitchStatsByWeekSegment:(NSInteger)selectedSegment;


@end

@interface OVPlotGraphViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISegmentedControl *statsByWeekSegmentedControl;

@property (strong, nonatomic) id<OVPlotGraphViewCellDelegate> delegate;

@end
