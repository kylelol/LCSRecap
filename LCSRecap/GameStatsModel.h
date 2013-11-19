//
//  GameStatsModel.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/11/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameStatsModel : NSObject

@property (nonatomic, strong) NSDictionary *redTeamStatsDictionary;
@property (nonatomic, strong) NSDictionary *blueTeamStatsDictioanry;

@property (nonatomic, strong) NSString *redTeamName;
@property (nonatomic, strong) NSString *blueTeamName;

-(id)initWithGameStats:(NSDictionary*)gameStats
            forTeamOne:(NSString*)teamOne
            andTeamTwo: (NSString*)teamTwo;
@end
