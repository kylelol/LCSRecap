//
//  TeamsModel.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/11/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameStatsRetriever.h"

@protocol TeamsModelDelegate <NSObject>

-(void)didRecieveTeams;

@end

@interface TeamsModel : NSObject <GameStatsRetrieverDelegate>

@property (nonatomic, strong) NSDictionary *teamOneDictionary;
@property (nonatomic, strong) NSDictionary *teamTwoDictionary;

@property (nonatomic, strong) id<TeamsModelDelegate> delegate;


@end
