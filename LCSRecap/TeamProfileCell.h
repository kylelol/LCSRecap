//
//  TeamProfileCell.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/15/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TeamProfileCellDelegate <NSObject>

-(void)shouldSegueToPlayerProfilePage:(NSString*)player withInitialFrame:(CGRect)frame;

@end

@interface TeamProfileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *teamProfileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *teamLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *seasonRecordLabel;
@property (weak, nonatomic) IBOutlet UILabel *nationalityLabel;
@property (weak, nonatomic) IBOutlet UITextView *teamInfoTextView;
@property (weak, nonatomic) IBOutlet UIImageView *topLaneThumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *topLaneNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jungleThumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *jungleNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *midThumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *midNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *adcThumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *adcNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *supportThumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *supportNameLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *GraphView;

@property (strong, nonatomic) id<TeamProfileCellDelegate> delegate;

@end
