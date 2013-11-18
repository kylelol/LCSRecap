//
//  PlayerProfileViewController.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/3/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *playerBackgroundImageVIew;
@property (nonatomic, strong) NSString *playerName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *playerFullNameLabel;

@end
