//
//  TeamOverallStatsView.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/9/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TeamOverallStatsViewDelegate <NSObject>

// Pass the yLocation so we can determine which view has been swiped.
-(void)didSwipeOverallStats:(float)yLocation;

@end

@interface TeamOverallStatsView : UIView

@property (nonatomic, strong) id<TeamOverallStatsViewDelegate> delegate;

@property (nonatomic, strong) UILabel *kdaStatLabel;
@property (nonatomic, strong) UILabel *goldStatLabel;
@property (nonatomic, strong) UILabel *totalGoldStatLabel;
@property (nonatomic, strong) UILabel *minionStatLabel;
@property (nonatomic, strong) UILabel *championStatLabel;



@end
