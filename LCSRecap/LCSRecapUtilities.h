//
//  LCSRecapUtilities.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/19/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GameStatsRequestCompletionBlock)(BOOL success, NSError *error, NSDictionary *gameStats);
typedef void (^TeamRequestCompletionBlock)(BOOL success, NSError *error, NSDictionary *teams);

@interface LCSRecapUtilities : NSObject

+(instancetype) sharedUtilities;

/**
 *  Fetches the game stats for the two teams passed in.
 *
 *  @param teamOne        the team name of one of the teams in the game
 *
 *  @param teamTwo        the team name of the other team in the game
 *
 *  @param completionBlock A completion block with the dictionary of stats.
 */
// TODO: Might need to add in extra paramter for the week.
-(void)requestGameStatsForTeam:(NSString*)teamOne
                       andTeam:(NSString*)teamTwo
                    completion:(GameStatsRequestCompletionBlock)completionBlock;

/**
 *  Fetches a dictionary of all the teams
 *
 *  @param completionBlock A completion block with the dictionary of stats.
 */
-(void)requestTeamsWithCompletion:(TeamRequestCompletionBlock)completionBlock;

@end
