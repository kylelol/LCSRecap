//
//  TeamsModel.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/11/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamsModel : NSObject

@property (nonatomic, strong) NSDictionary *redTeamDictionary;
@property (nonatomic, strong) NSDictionary *blueTeamDictionary;

-(id)initWithTeamDictionary:(NSDictionary *)dictionary redteamName:(NSString*)redTeam blueTeamName:(NSString*)blueTeam;

@end
