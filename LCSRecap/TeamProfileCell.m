//
//  TeamProfileCell.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/15/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "TeamProfileCell.h"



@implementation TeamProfileCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSLog(@"TESTTTINGGDSLKFJDJFLS");
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapTopLaneProfileThumbImageView:(id)sender {
    NSLog(@"TREUUUUUUU");
    [self.delegate shouldSegueToPlayerProfilePage:@"top" withInitialFrame:((UIButton*)sender).frame];
}
- (IBAction)didTapJungleLaneProfileImage:(id)sender {
        [self.delegate shouldSegueToPlayerProfilePage:@"jungle" withInitialFrame:((UIButton*)sender).frame];
}
- (IBAction)didTapMidLaneProfilePic:(id)sender
{
    [self.delegate shouldSegueToPlayerProfilePage:@"mid" withInitialFrame:((UIButton*)sender).frame];

}
- (IBAction)didTapADCLaneProfilePic:(id)sender
{
    [self.delegate shouldSegueToPlayerProfilePage:@"adc" withInitialFrame:((UIButton*)sender).frame];

}
- (IBAction)didTapProfileSupportProfilePic:(id)sender
{
    [self.delegate shouldSegueToPlayerProfilePage:@"support" withInitialFrame:((UIButton*)sender).frame];

}

@end
