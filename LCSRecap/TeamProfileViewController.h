//
//  TeamProfileViewController.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/15/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSString *teamName;
@property (nonatomic, strong) NSDictionary *teamDictionary;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
