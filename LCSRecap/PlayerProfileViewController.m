//
//  PlayerProfileViewController.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/3/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "PlayerProfileViewController.h"
#import "PlayerProfileBioCell.h"
#import "AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@interface PlayerProfileViewController ()

@property (nonatomic, strong) NSDictionary *playerDictionary;

@end

@implementation PlayerProfileViewController
{
    BOOL _bioIsSelected;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _bioIsSelected = true;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlayerProfileBioCell" bundle:nil] forCellReuseIdentifier:@"BioCell"];
    
    [self retrievePlayerInfo];
    
    NSLog(@"%@", self.playerName);

}

-(void)retrievePlayerInfo
{
    NSURL *newJSONUrl = [NSURL URLWithString:@"http://www.lateknightcookies.com/test/players"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:newJSONUrl];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"%@", [[responseObject objectForKey:@"players"] objectForKey:self.playerName]);
         self.playerDictionary = [[responseObject objectForKey:@"players"] objectForKey:self.playerName];
         self.playerFullNameLabel.text = [self.playerDictionary objectForKey:@"full-name"];
         [self.tableView reloadData];
         
         [self setProfileImage];
         
         [self checkIfStreamIsLive];
 
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
   }];
    [operation start];
}

-(void)setProfileImage
{
    NSURL *imageURL = [NSURL URLWithString:[self.playerDictionary objectForKey:@"profile-image"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.playerBackgroundImageVIew.image = [UIImage imageWithData:imageData];
        });
    });
}

-(void)checkIfStreamIsLive
{
    NSURL *newJSONUrl = [NSURL URLWithString:@"http://api.justin.tv/api/stream/list.json?channel=trick2g"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:newJSONUrl];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"%@", responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     }];
    [operation start];
}

-(void)viewDidAppear:(BOOL)animated
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(260, 0, 20, 20)];
    button.titleLabel.text = @"TEST BUTTON";
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(didPressCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)viewWillLayoutSubviews
{
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didPressCloseButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!_bioIsSelected)
        return [[self.playerDictionary objectForKey:@"stats"] count];
    return [[self.playerDictionary objectForKey:@"bio"] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerProfileBioCell *cell = (PlayerProfileBioCell*)[tableView dequeueReusableCellWithIdentifier:@"BioCell"];
    if (!_bioIsSelected)
    {
        if (indexPath.section == 0)
        {
            cell.titleLabel.text = @"Gold/Min:";
            cell.detailLabel.text = [[self.playerDictionary objectForKey:@"stats"] objectForKey:@"gpm"];
            
        }
        else if ( indexPath.section == 1)
        {
            cell.titleLabel.text = @"Avg. KDA:";
            cell.detailLabel.text = [[self.playerDictionary objectForKey:@"stats"] objectForKey:@"kda"];
            
        }
        else if (indexPath.section == 2)
        {
            cell.titleLabel.text = @"Total Gold";
            cell.detailLabel.text = [[self.playerDictionary objectForKey:@"stats"] objectForKey:@"total-gold"];
        }
        
    }
    else
    {
        if (indexPath.section == 0)
        {
            cell.titleLabel.text = @"Age:";
            cell.detailLabel.text = [[self.playerDictionary objectForKey:@"bio"] objectForKey:@"age"];
        }
        else if (indexPath.section == 1)
        {
            cell.titleLabel.text = @"Hometown:";
            cell.detailLabel.text = [[self.playerDictionary objectForKey:@"bio"] objectForKey:@"hometown"];
            
        }
        else if ( indexPath.section == 2)
        {
            cell.titleLabel.text = @"Position:";
            cell.detailLabel.text = [[self.playerDictionary objectForKey:@"bio"] objectForKey:@"position"];

        }
        else if ( indexPath.section == 3)
        {
            cell.titleLabel.text = @"Season Wins:";
            cell.detailLabel.text = [[self.playerDictionary objectForKey:@"bio"] objectForKey:@"season-wins"];

        }
        else if (indexPath.section == 4)
        {
            cell.titleLabel.text = @"Total Wins:";
            cell.detailLabel.text = [[self.playerDictionary objectForKey:@"bio"] objectForKey:@"total-wins"];

        }
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 0)];
    
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

- (IBAction)segmentSwtich:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        _bioIsSelected = TRUE;
        [self.tableView reloadData];
        
    }
    else{
        //toggle the correct view to be visible
        _bioIsSelected = FALSE;
        [self.tableView reloadData];
    }
    
}
@end
