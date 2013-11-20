//
//  VideoPlaylistModel.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/19/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "VideoPlaylistModel.h"

@implementation VideoPlaylistModel

+(id)videoPlaylistModelWithPlaylist:(NSArray *)playlist
{
    VideoPlaylistModel *model = [[VideoPlaylistModel alloc] init];
    
    NSMutableArray *videoSources = [[NSMutableArray alloc] init];
    NSMutableArray *videoTitles = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in playlist)
    {
        [ videoSources addObject:[self getYouTubeVideoIDFromURL:[[dict objectForKey:@"content"]
                                                                 objectForKey:@"src"]]];
        
        [videoTitles addObject:[[dict objectForKey:@"title"] objectForKey:@"$t"]];
        
    }
    
    // TODO: For some reason one video is not getting removed, have to loop through twice.

    int i=0;
    for (i=0; i < [videoTitles count]; i++)
    {
        
        if (![self videoIsAGame:[videoTitles objectAtIndex:i]])
        {
            [videoTitles removeObjectAtIndex:i];
            [videoSources removeObjectAtIndex:i];
        }
        
    }
    
    for (i=0; i < [videoTitles count]; i++)
    {
        NSArray *components = [[videoTitles objectAtIndex:i] componentsSeparatedByString:@" "];
        if ([components[0] isEqualToString:@"Intro"])
        {
            [videoTitles removeObjectAtIndex:i];
            [videoSources removeObjectAtIndex:i];
        }
        
    }
    
    //[videoTitles removeObjectAtIndex:6];
    
    model.videoSourcesArray = [NSArray arrayWithArray:videoSources];
    model.videoTitlesArray = [NSArray arrayWithArray:videoTitles];
        
    return model;
}

+(NSString*)getYouTubeVideoIDFromURL:(NSString*)url
{
    //NSLog(@"%@", url);
    NSArray *components = [url componentsSeparatedByString:@"/"];
    
    NSString *address = [components objectAtIndex:4];
    
    NSArray *newComponents = [address componentsSeparatedByString:@"?"];
    
    //NSLog(@"%@", [newComponents objectAtIndex:0]);
    
    return [newComponents objectAtIndex:0];
}

+(BOOL)videoIsAGame:(NSString *)videoTitle
{
    NSArray *components = [videoTitle componentsSeparatedByString:@" "];
    
    if ([components[1] isEqualToString:@"vs"] && ![components[3] isEqualToString:@"Interview"])
        return YES;
    else if ( [components[0] isEqualToString:@"Signoff"])
        return NO;
    else if ( [components[0] isEqualToString:@"Intro"])
        return NO;
    else return NO;
}

@end
