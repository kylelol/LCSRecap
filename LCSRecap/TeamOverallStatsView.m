//
//  TeamOverallStatsView.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/9/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "TeamOverallStatsView.h"

@implementation TeamOverallStatsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TeamOverallStatsView" owner:self options:nil];
        self = array[0];
        frame.origin.x = -320;
        self.frame = frame;
        
        [self addTitleLabels];
        
        [self addStatLabels];
        
        UIGestureRecognizer *anotherSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeTeamStats:)];
        
        [self addGestureRecognizer:anotherSwipe];
    }
    return self;
}

-(void)addStatLabels
{
        UIFontDescriptor *statFont = [UIFontDescriptor fontDescriptorWithFontAttributes:@{UIFontDescriptorFamilyAttribute:@"American Typewriter"}];
    
    self.kdaStatLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 20, 100, 20)];
    self.kdaStatLabel.font = [UIFont fontWithDescriptor:statFont size:12.0f];
    self.kdaStatLabel.text = @"Insert Stat Here";
    self.kdaStatLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.kdaStatLabel];
    
    
    self.goldStatLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 40, 100, 20)];
    self.goldStatLabel.font = [UIFont fontWithDescriptor:statFont size:12.0f];
    self.goldStatLabel.text = @"Insert Stat Here";
    self.goldStatLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.goldStatLabel];
    
    
    self.totalGoldStatLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 60, 100, 20)];
    self.totalGoldStatLabel.font = [UIFont fontWithDescriptor:statFont size:12.0f];
    self.totalGoldStatLabel.text = @"Insert Stat Here";
    self.totalGoldStatLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.totalGoldStatLabel];
    
    
    self.minionStatLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 80, 100, 20)];
    self.minionStatLabel.font = [UIFont fontWithDescriptor:statFont size:12.0f];
    self.minionStatLabel.text = @"Insert Stat Here";
    self.minionStatLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.minionStatLabel];
    
    
    self.championStatLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 100, 100, 20)];
    self.championStatLabel.font = [UIFont fontWithDescriptor:statFont size:12.0f];
    self.championStatLabel.text = @"Insert Stat Here";
    self.championStatLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.championStatLabel];
}

-(void)addTitleLabels
{
    UIFontDescriptor *headerFont = [UIFontDescriptor fontDescriptorWithFontAttributes:@{UIFontDescriptorFamilyAttribute:@"American Typewriter"}];
    UIFontDescriptor *headerFontAttributes = [headerFont fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    
    UILabel *kdaRatio = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 100, 20)];
    kdaRatio.font = [UIFont fontWithDescriptor:headerFontAttributes size:15.0f];
    kdaRatio.text = @"KDA Ratio:";
    kdaRatio.textColor = [UIColor colorWithRed:0.705f green:0.53f blue:0.26f alpha:1.0f];
    [self addSubview:kdaRatio];
    
    UILabel *goldPerMin = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 100, 20)];
    goldPerMin.font = [UIFont fontWithDescriptor:headerFontAttributes size:15.0f];
    goldPerMin.text = @"Gold/Min";
    goldPerMin.textColor = [UIColor colorWithRed:0.705f green:0.53f blue:0.26f alpha:1.0f];
    [self addSubview:goldPerMin];
    
    UILabel *totalGold = [[UILabel alloc] initWithFrame:CGRectMake(40, 60, 100, 20)];
    totalGold.font = [UIFont fontWithDescriptor:headerFontAttributes size:15.0f];
    totalGold.text = @"Total Gold:";
    totalGold.textColor = [UIColor colorWithRed:0.705f green:0.53f blue:0.26f alpha:1.0f];
    [self addSubview:totalGold];
    
    UILabel *minionsHeader = [[UILabel alloc] initWithFrame:CGRectMake(40, 80, 130, 20)];
    minionsHeader.font = [UIFont fontWithDescriptor:headerFontAttributes size:15.0f];
    minionsHeader.text = @"Minions Killed:";
    minionsHeader.textColor = [UIColor colorWithRed:0.705f green:0.53f blue:0.26f alpha:1.0f];
    [self addSubview:minionsHeader];
    
    UILabel *championHeader = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 140, 20)];
    championHeader.font = [UIFont fontWithDescriptor:headerFontAttributes size:15.0f];
    championHeader.text = @"Champions Killed:";
    championHeader.textColor = [UIColor colorWithRed:0.705f green:0.53f blue:0.26f alpha:1.0f];
    [self addSubview:championHeader];
}

-(void)didSwipeTeamStats:(id)sender
{
    NSLog(@"%@", sender);
    [self.delegate didSwipeOverallStats:self.frame.origin.y];
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
