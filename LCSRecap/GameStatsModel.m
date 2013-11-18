//
//  GameStatsModel.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/11/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "GameStatsModel.h"

@implementation GameStatsModel

-(void)didRetrieveDictionary:(NSDictionary *)dict
{
    self.gameStatsDictionary = dict;
    [self.delegate recievedGameStatsFromRetriever];
}



@end
