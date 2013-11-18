//
//  GameStatsRetriever.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/10/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameStatsRetrieverDelegate <NSObject>

@optional
-(void)didRetrieveDictionary:(NSDictionary*)dict;

-(void)didNotRetrieveDictionary;

-(void)didRetrieveTeams:(NSString*)teams dictionary:(NSDictionary *)dictionary;

@end

@interface GameStatsRetriever : NSObject

-(NSDictionary*)retrieveGameStatsForTeams:(NSString*)teams;
-(void)retrieveTeamPlayersForTeams:(NSString *)teams;

@property (nonatomic, strong) id<GameStatsRetrieverDelegate> delegate;
@property (nonatomic, strong) id<GameStatsRetrieverDelegate> teamDelegate;

@end
