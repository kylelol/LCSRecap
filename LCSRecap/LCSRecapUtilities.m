//
//  LCSRecapUtilities.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/19/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "LCSRecapUtilities.h"
#import "AFNetworking.h"

@implementation LCSRecapUtilities

#pragma mark - Singleton
+(instancetype) sharedUtilities
{
    static LCSRecapUtilities *sharedUtilities;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtilities = [[LCSRecapUtilities alloc] init];
    });
    
    return sharedUtilities;
}

#pragma mark - LCS Recap API

-(void)requestGameStatsForTeam:(NSString*)teamOne
                       andTeam:(NSString*)teamTwo
                    completion:(EventRequestCompletionBlock)completionBlock
{
    // The URL of the stats.
    NSURL *newJSONUrl = [NSURL URLWithString:@"http://www.lateknightcookies.com/test/NAGames"];
    
    
    // Create the URL reqeust
    NSURLRequest *request = [NSURLRequest requestWithURL:newJSONUrl];
    
    // Create the key for the reqeusted game stats
    // Format: "teamOnevsteamTwo"
    NSString *gameStatsKey = [NSString stringWithFormat:@"%@vs%@", teamOne, teamTwo];
    
    // Create the operation
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    
    // Set the completion and failure blocks
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         if (completionBlock)
         {
             completionBlock(YES, nil, [[[responseObject objectForKey:@"Games"]
                                                        objectForKey:@"W8D1"]
                                                        objectForKey:gameStatsKey]
                             );
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (completionBlock)
        {
            completionBlock(NO, error, nil);
        }
     }];
    
    // Request the stats
    [operation start];
    
}


@end
