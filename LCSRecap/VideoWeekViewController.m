//
//  VideoWeekViewController.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/4/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "VideoWeekViewController.h"
#import "REMenu.h"
#import "VideoWeekCell.h"
#import "AFNetworking.h"
#import "ViewController.h"
#import "GameStatsRetriever.h"

@interface VideoWeekViewController ()

@property (nonatomic, strong) REMenu *menu;
@property (nonatomic, strong) NSArray *videoSourcesArray;
@property (nonatomic, strong) NSArray *videoTitlesArray;
@property (nonatomic, strong) NSDictionary *stats;

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
    
    self.playlistIDArray = @"PLPZ7h6L6LC7X2dFjewHyFFYg9HzX7BbVu";
    
    [self retrievePlaylistsVideosFromYouTubeAPI];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoWeekCell" bundle:nil] forCellReuseIdentifier:@"VideoDetailCell"];
    
    [self retrieveTeamPlayersForTeams];
    
}

-(void)retrievePlaylistsVideosFromYouTubeAPI
{
    // Configure the URL of the playlist.
    NSString *url = [NSString stringWithFormat:@"https://gdata.youtube.com/feeds/api/playlists/%@?v=2&alt=json", self.playlistIDArray];
    NSURL *playlistURL = [NSURL URLWithString:url];
    
    // Configure the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:playlistURL];
    
    // Get the request.
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSArray *arrray = [[responseObject objectForKey:@"feed"] objectForKey:@"entry"];
         
         // Debug Code
         //NSLog(@"%@", [[responseObject objectForKey:@"feed"] objectForKey:@"entry"]);
         
         NSMutableArray *videoSources = [[NSMutableArray alloc] init];
         NSMutableArray *videoTitles = [[NSMutableArray alloc] init];
         
         for (NSDictionary *dict in arrray)
         {
             [ videoSources addObject:[self getYouTubeVideoIDFromURL:[[dict objectForKey:@"content"]
                                                                      objectForKey:@"src"]]];
             
             [videoTitles addObject:[[dict objectForKey:@"title"] objectForKey:@"$t"]];
             
         }
         
         // TODO: For some reason one video is not getting removed, have to loop through twice.
         for (NSString *s in videoTitles)
             NSLog(@"%@", s);
         int i=0;
         for (i=0; i < [videoTitles count]; i++)
         {
             NSLog(@"%@", [videoTitles objectAtIndex:i]);
             
            if (![self videoIsAGame:[videoTitles objectAtIndex:i]])
             {
                 [videoTitles removeObjectAtIndex:i];
                 [videoSources removeObjectAtIndex:i];
             }

         }
         
         for (i=0; i < [videoTitles count]; i++)
         {
             NSArray *components = [[videoTitles objectAtIndex:i] componentsSeparatedByString:@" "];
             if ([components[0] isEqualToString:@"Intro"])
             {
                 [videoTitles removeObjectAtIndex:i];
                 [videoSources removeObjectAtIndex:i];
             }
             
         }
         
         //[videoTitles removeObjectAtIndex:6];
         
         self.videoSourcesArray = [NSArray arrayWithArray:videoSources];
         self.videoTitlesArray = [NSArray arrayWithArray:videoTitles];
         
         [self.tableView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         //TODO: Implement Error
     }];
    
    //Start the request
    [operation start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSourceDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.videoSourcesArray count];
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
    NSString *videoID = [self.videoSourcesArray objectAtIndex:indexPath.section];
    
    cell.videoID = videoID;
    
    if ([self videoIsAGame:[self.videoTitlesArray objectAtIndex:indexPath.section]])
    {
        NSArray *components = [[self.videoTitlesArray objectAtIndex:indexPath.section] componentsSeparatedByString:@" "];
        
        cell.leftSideTeamNameLabel.text = [[self.stats objectForKey:components[0]] objectForKey:@"team-name"];
        cell.rightSideTeamNameLabel.text = [[self.stats objectForKey:components[2]] objectForKey:@"team-name"];
    }
    
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"VideoDetailVC" sender:self];
}

-(NSString*)getYouTubeVideoIDFromURL:(NSString*)url
{
    //NSLog(@"%@", url);
    NSArray *components = [url componentsSeparatedByString:@"/"];
    
    NSString *address = [components objectAtIndex:4];
    
    NSArray *newComponents = [address componentsSeparatedByString:@"?"];
    
    //NSLog(@"%@", [newComponents objectAtIndex:0]);
    
    return [newComponents objectAtIndex:0];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"VideoDetailVC"])
    {
        NSInteger section = [self.tableView indexPathForSelectedRow].section;
        
        ((ViewController*)segue.destinationViewController).videoID = [self.videoSourcesArray objectAtIndex:section];
        
         NSArray *components = [[self.videoTitlesArray objectAtIndex:[self.tableView indexPathForSelectedRow].section] componentsSeparatedByString:@" "];
        
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

-(void)retrieveTeamPlayersForTeams
{
    NSURL *newJSONUrl = [NSURL URLWithString:@"http://www.lateknightcookies.com/test/NATeams"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:newJSONUrl];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"%@", responseObject);
         self.stats = [responseObject objectForKey:@"Teams"];
         [self.tableView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     }];
    [operation start];
    
}

@end
