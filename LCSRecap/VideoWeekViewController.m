//
//  VideoWeekViewController.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/4/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "VideoWeekViewController.h"
#import "VideoWeekCell.h"
#import "ViewController.h"

#import "LCSRecapUtilities.h"
#import "VideoPlaylistModel.h"

@interface VideoWeekViewController ()

@property (nonatomic, strong) NSArray *videoSourcesArray;
@property (nonatomic, strong) NSArray *videoTitlesArray;
@property (nonatomic, strong) NSDictionary *teamsDictionary;

@property (nonatomic, strong) VideoPlaylistModel *playlistModel;

@end

@implementation VideoWeekViewController

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoWeekCell" bundle:nil] forCellReuseIdentifier:@"VideoDetailCell"];
    
    self.playlistIDArray = @"PLPZ7h6L6LC7X2dFjewHyFFYg9HzX7BbVu";
    
    [[LCSRecapUtilities sharedUtilities] requestVideosFromYoutubeAPIForPlaylistID:self.playlistIDArray
                                                             completion:^(BOOL success, NSError *error, NSArray *playlistVideos){
                                                                 
                                                                 self.playlistModel = [VideoPlaylistModel videoPlaylistModelWithPlaylist:playlistVideos];
                                                                 
                                                                 NSLog(@"%@", self.playlistModel);
                                                                 [self.tableView reloadData];
                                                                 
                                                             }];
    
    [[LCSRecapUtilities sharedUtilities] requestTeamsWithCompletion:^(BOOL success, NSError *error, NSDictionary *teams) {
        self.teamsDictionary = teams;
        [self.tableView reloadData];
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSourceDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.playlistModel.videoSourcesArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: add in after retrieving videos
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 0)];
    
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


#pragma mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoWeekCell *cell = (VideoWeekCell*)[tableView dequeueReusableCellWithIdentifier:@"VideoDetailCell"];
    
    // Retrieve the thumbnail image of the video
    NSString *videoID = [self.playlistModel.videoSourcesArray objectAtIndex:indexPath.section];
    
    cell.videoID = videoID;
    
    //if ([self videoIsAGame:[self.playlistModel.videoTitlesArray objectAtIndex:indexPath.section]])
   // {
        NSArray *components = [[self.playlistModel.videoTitlesArray objectAtIndex:indexPath.section] componentsSeparatedByString:@" "];
        
        cell.leftSideTeamNameLabel.text = [[self.teamsDictionary objectForKey:components[0]] objectForKey:@"team-name"];
        cell.rightSideTeamNameLabel.text = [[self.teamsDictionary objectForKey:components[2]] objectForKey:@"team-name"];
    //}
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"VideoDetailVC" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"VideoDetailVC"])
    {
        NSInteger section = [self.tableView indexPathForSelectedRow].section;
        
        ((ViewController*)segue.destinationViewController).videoID = [self.playlistModel.videoSourcesArray objectAtIndex:section];
        
         NSArray *components = [[self.playlistModel.videoTitlesArray objectAtIndex:[self.tableView indexPathForSelectedRow].section] componentsSeparatedByString:@" "];
        
        ((ViewController*)segue.destinationViewController).teamsDictionary = self.teamsDictionary;

        
        ((ViewController*)segue.destinationViewController).redTeamName = components[0];
        ((ViewController*)segue.destinationViewController).blueTeamName = components[2];
    }
}

-(BOOL)videoIsAGame:(NSString *)videoTitle
{
    NSArray *components = [videoTitle componentsSeparatedByString:@" "];
    
    if ([components[1] isEqualToString:@"vs"] && ![components[3] isEqualToString:@"Interview"])
        return YES;
    else if ( [components[0] isEqualToString:@"Signoff"])
        return NO;
    else if ( [components[0] isEqualToString:@"Intro"])
        return NO;
    else return NO;
}

@end
