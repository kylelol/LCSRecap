//
//  TeamPlayerStatsContainerView.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/10/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamPlayerStatsView.h"

@protocol TeamPlayerStatsContainerViewDelegate <NSObject>

@optional
-(void)didSwipContainerView:(float)yLocation;
-(void)didTapContainerView:(float)yLocation;

@end

@interface TeamPlayerStatsContainerView : UIView

@property (nonatomic, strong) UILabel *teamNameLabel;

@property (nonatomic, assign) BOOL wasTapped;

@property (nonatomic, strong) id<TeamPlayerStatsContainerViewDelegate> delegate;

@property (nonatomic, strong) TeamPlayerStatsView *topLaner;
@property (nonatomic, strong) TeamPlayerStatsView *jungleLaner;
@property (nonatomic, strong) TeamPlayerStatsView *midLaner;
@property (nonatomic, strong) TeamPlayerStatsView *adcLaner;
@property (nonatomic, strong) TeamPlayerStatsView *supportLaner;

@property (nonatomic, strong) UIImageView *teamBanOne;
@property (nonatomic, strong) UIImageView *teamBanTwo;

@property (nonatomic, strong) UIImageView *teamBanThree;




@end
