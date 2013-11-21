//
//  TeamsModel.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/11/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "TeamsModel.h"

@implementation TeamsModel

-(instancetype)initWithTeamDictionary:(NSDictionary *)dictionary redteamName:(NSString*)redTeam blueTeamName:(NSString*)blueTeam
{
    self = [super init];
    
    if (self)
    {
        self.redTeamDictionary = [dictionary objectForKey:redTeam];
        self.blueTeamDictionary = [dictionary objectForKey:blueTeam];
        
        NSLog(@"%@", self.redTeamDictionary);
    }
    
    return self;
}

@end
