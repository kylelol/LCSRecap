//
//  GameStatsRetriever.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/10/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "GameStatsRetriever.h"
#import "AFNetworking.h"

@implementation GameStatsRetriever

-(NSDictionary*)retrieveGameStatsForTeams:(NSString *)teams
{
    
    NSURL *newJSONUrl = [NSURL URLWithString:@"http://www.lateknightcookies.com/test/NAGames"];
    
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:newJSONUrl];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
        [self.delegate didRetrieveDictionary:[[[responseObject
                                              objectForKey:@"Games"]
                                               objectForKey:@"W8D1"]
                                              objectForKey:teams] ];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate didNotRetrieveDictionary];
    }];
    [operation start];
    
    return nil;
}

-(void)retrieveTeamPlayersForTeams:(NSString *)teams
{    
    NSURL *newJSONUrl = [NSURL URLWithString:@"http://www.lateknightcookies.com/test/NATeams"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:newJSONUrl];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self.teamDelegate didRetrieveTeams:teams dictionary:[responseObject
                                                 objectForKey:@"Teams"]];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [self.delegate didNotRetrieveDictionary];
     }];
    [operation start];
    
}

@end
