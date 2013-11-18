//
//  VideoWeekCell.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/5/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamsModel.h"

@interface VideoWeekCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoThumbnailImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *leftSideTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightSideTeamNameLabel;

@property (strong, nonatomic) NSString *videoID;

@property (strong, nonatomic) TeamsModel *teamStats;
@end
