//
//  VideoPlaylistModel.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/19/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoPlaylistModel : NSObject

@property (nonatomic, strong) NSArray *videoSourcesArray;
@property (nonatomic, strong) NSArray *videoTitlesArray;

+(id)videoPlaylistModelWithPlaylist:(NSArray *)playlist;

@end
