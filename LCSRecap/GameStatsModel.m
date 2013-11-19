//
//  GameStatsModel.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/11/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "GameStatsModel.h"

@implementation GameStatsModel

-(id)initWithGameStats:(NSDictionary*)gameStats forTeamOne:(NSString*)teamOne andTeamTwo: (NSString*)teamTwo
{
    
    self = [super init];
    
    if (self)
    {
        if ( [[[gameStats objectForKey:teamOne] objectForKey:@"side"] isEqualToString:@"red"] )
        {
            self.redTeamName = teamOne;
            self.blueTeamName = teamTwo;
        }
        else
        {
            self.redTeamName = teamTwo;
            self.blueTeamName = teamOne;
        }
                
        self.redTeamStatsDictionary = [gameStats objectForKey:self.redTeamName];
        self.blueTeamStatsDictioanry = [gameStats objectForKey:self.blueTeamName];

    }
    
    return self;
}

@end
