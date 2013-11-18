//
//  VideoWeekViewController.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/4/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoWeekViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSString *playlistIDArray;
@property (nonatomic, strong) NSString *playlistTitleArray;

@end
