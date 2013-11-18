//
//  VideoWeekCell.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/5/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "VideoWeekCell.h"

@implementation VideoWeekCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code

    }
    return self;
}

-(void)setVideoID:(NSString *)videoID
{
    _videoID = videoID;
    NSLog(@"%@", _videoID);
    [self updateUI];
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x += 0;
    frame.size.width = 320;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateUI
{
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg", self.videoID]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.videoThumbnailImageVIew.image = [UIImage imageWithData:imageData];
        });
    });
    // Done.
    
}

@end
