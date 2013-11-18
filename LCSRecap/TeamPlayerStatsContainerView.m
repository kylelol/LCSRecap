//
//  TeamPlayerStatsContainerView.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/10/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "TeamPlayerStatsContainerView.h"

@implementation TeamPlayerStatsContainerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.09f
                                               green:0.09f
                                                blue:0.09f
                                               alpha:1.0f];
        
        // Configure the team name label
        UIFontDescriptor *descriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:@{UIFontDescriptorFamilyAttribute:@"Trebuchet MS"}];
        UIFontDescriptor *styles = [descriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
        self.teamNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, -48, 190, 121)];
        self.teamNameLabel.textColor = [UIColor whiteColor];
        self.teamNameLabel.font = [UIFont fontWithDescriptor:styles size:13.0f];
        self.teamNameLabel.text = @"Insert Team Name Here";
        [self addSubview:self.teamNameLabel];
        [self bringSubviewToFront:self.teamNameLabel];
        
        // Configure the first ban image view
        self.teamBanOne = [[UIImageView alloc] initWithFrame:CGRectMake(250, 2, 20, 20)];
        self.teamBanOne.image = [UIImage imageNamed:@"ahri"];
        [self addSubview:self.teamBanOne];
        [self bringSubviewToFront:self.teamBanOne];
        
        // Confgure the second ban image view
        self.teamBanTwo = [[UIImageView alloc] initWithFrame:CGRectMake(275, 2, 20, 20)];
        self.teamBanTwo.image = [UIImage imageNamed:@"shen"];
        [self addSubview:self.teamBanTwo];
        [self bringSubviewToFront:self.teamBanTwo];
        
        // Configure the third ban image view
        self.teamBanThree = [[UIImageView alloc] initWithFrame:CGRectMake(300, 2, 20, 20)];
        self.teamBanThree.image = [UIImage imageNamed:@"twitch"];
        [self addSubview:self.teamBanThree];
        [self bringSubviewToFront:self.teamBanThree];
        
        // Configure the ban label
        UIFontDescriptor *statFont = [UIFontDescriptor fontDescriptorWithFontAttributes:@{UIFontDescriptorFamilyAttribute:@"American Typewriter"}];
        UILabel *bans = [[UILabel alloc] initWithFrame:CGRectMake(210, 3, 60, 20)];
        bans.text = @"Bans -";
        bans.font = [UIFont fontWithDescriptor:statFont size:12.0f];
        bans.textColor = [UIColor colorWithRed:0.705f green:0.53f blue:0.26f alpha:1.0f];
        [self addSubview:bans];
        [self bringSubviewToFront:bans];
        
        // Set up the player stats.
        [self setUpTeamPlayerStatsView];
        
        
        // Add the gesture recognizers.
        UIGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeTeamStats:)];
        [self addGestureRecognizer:swipe];
        
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTeamStats:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)didSwipeTeamStats:(id)sender
{
    [self.delegate didSwipContainerView:self.frame.origin.y];
}

-(void)didTapTeamStats:(id)sender
{
    self.wasTapped = YES;
    [self.delegate didTapContainerView:self.frame.origin.y];
}

-(void)setUpTeamPlayerStatsView
{
    CGFloat height = 24;
    
    CGFloat yOffSet= 25;
    
    self.topLaner = [[TeamPlayerStatsView alloc] initWithFrame:CGRectMake(0, 0, 310, 20)];
    self.topLaner.frame = CGRectMake(5, 23, 310, height);
    [self addSubview:self.topLaner];
    
    self.jungleLaner = [[TeamPlayerStatsView alloc] initWithFrame:CGRectMake(5 , 50, 310, 20)];
    self.jungleLaner.frame = CGRectMake(5 , self.topLaner.frame.origin.y + yOffSet, 310, height);
    [self addSubview:self.jungleLaner];
    
    self.midLaner = [[TeamPlayerStatsView alloc] initWithFrame:CGRectMake(5, 75, 310, 20)];
    self.midLaner.frame = CGRectMake(5, self.topLaner.frame.origin.y + (yOffSet * 2), 310, height);
    [self addSubview:self.midLaner];
    
    self.adcLaner = [[TeamPlayerStatsView alloc] init];
    self.adcLaner.frame = CGRectMake(5, self.topLaner.frame.origin.y + (yOffSet * 3), 310, height);
    [self addSubview:self.adcLaner];
    
    self.supportLaner = [[TeamPlayerStatsView alloc] init];
    self.supportLaner.frame = CGRectMake(5, self.topLaner.frame.origin.y + (yOffSet * 4), 310, height);
    [self addSubview:self.supportLaner];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
