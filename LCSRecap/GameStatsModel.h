//
//  GameStatsModel.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/11/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStatsRetriever.h"

@protocol GameStatsModelDelegate <NSObject>

-(void)recievedGameStatsFromRetriever;

@end

@interface GameStatsModel : NSObject <GameStatsRetrieverDelegate>

@property (strong, nonatomic) NSDictionary *gameStatsDictionary;

@property (nonatomic, strong) id<GameStatsModelDelegate> delegate;

@end
