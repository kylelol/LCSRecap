//
//  TeamPlayerStatsView.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/9/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "TeamPlayerStatsView.h"

@implementation TeamPlayerStatsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       NSArray *views =  [[NSBundle mainBundle] loadNibNamed:@"TeamPlayerStatsView" owner:self options:nil];
        self = views[0];
    }
    return self;
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
