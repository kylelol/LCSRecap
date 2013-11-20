//
//  ViewController.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/9/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hideStatsBarButton;
@property (weak, nonatomic) IBOutlet UIView *redTeamPlayerOneStatView;

@property (strong, nonatomic) NSString *redTeamName;
@property (strong, nonatomic) NSString *blueTeamName;

@property (strong, nonatomic) NSString *videoID;

@property (strong, nonatomic) NSDictionary *teamsDictionary;

@end
