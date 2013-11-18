//
//  TeamsModel.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/11/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "TeamsModel.h"

@implementation TeamsModel

-(void)didRetrieveTeams:(NSString *)teams dictionary:(NSDictionary *)dictionary
{
    NSArray *components = [teams componentsSeparatedByString:@"vs"];
    
    self.teamOneDictionary = [dictionary objectForKey:components[0]];
    self.teamTwoDictionary = [dictionary objectForKey:components[1]];
        
    [self.delegate didRecieveTeams];
}

@end
