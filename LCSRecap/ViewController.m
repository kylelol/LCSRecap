//
//  ViewController.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/9/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "ViewController.h"
#import "TeamPlayerStatsView.h"
#import "TeamPlayerStatsContainerView.h"
#import "TeamOverallStatsView.h"
#import "GameStatsRetriever.h"
#import "GameStatsModel.h"
#import "TeamsModel.h"
#import "TeamProfileViewController.h"

#import "LCSRecapUtilities.h"

@interface ViewController () <TeamOverallStatsViewDelegate, TeamPlayerStatsContainerViewDelegate, GameStatsModelDelegate, TeamsModelDelegate>

@property (nonatomic, strong) TeamOverallStatsView *redTeamOverallStatsView;
@property (nonatomic, strong) TeamOverallStatsView *blueTeamOverallStatsView;
@property (nonatomic, strong) TeamPlayerStatsContainerView *redTeamContainerView;
@property (nonatomic, strong) TeamPlayerStatsContainerView *blueTeamContainerView;

@property (nonatomic, strong) GameStatsModel *gameStats;
@property (nonatomic, strong) TeamsModel *teamModel;

@end

@implementation ViewController
{
    BOOL _hideStats;
    BOOL _redTeamStats;
    BOOL _blueTeamStats;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
   // self.navigationController.navigationBarHidden = true;
    //self.navigationController.toolbarHidden = NO;
    //self.navigationController.toolbarItems = @[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil] ];

    
    // TEST CODE
    //self.redTeamName = @"CST";
    //self.blueTeamName = @"CLG";
    
    //self.title = [NSString stringWithFormat:@"%@ vs %@", self.redTeamName, self.blueTeamName];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    _hideStats = false;
    _redTeamStats = false;
    _blueTeamStats = false;
    
    [[LCSRecapUtilities sharedUtilities] requestGameStatsForTeam:self.redTeamName andTeam:self.blueTeamName completion:^(BOOL success, NSError *error, NSDictionary *events) {
        
        if (success)
        {
            NSLog(@"%@", events);
        }
        else
        {
            NSLog(@"%@", error);
        }
        
    }];
    
    
    // For future reference, these models might need to be reworked.
    // Simple delegation pattern to pass the information
    // Mainly get the retriever out of the vc and into the model.
    GameStatsRetriever *stats = [[GameStatsRetriever alloc] init];
    self.gameStats = [[GameStatsModel alloc] init];
    self.teamModel = [[TeamsModel alloc] init];
    stats.teamDelegate = self.teamModel;
    stats.delegate = self.gameStats;
    self.gameStats.delegate = self;
    self.teamModel.delegate = self;
    [stats retrieveGameStatsForTeams:[NSString stringWithFormat:@"%@vs%@", self.redTeamName, self.blueTeamName]];
    [stats retrieveTeamPlayersForTeams:[NSString stringWithFormat:@"%@vs%@", self.redTeamName, self.blueTeamName]];
    
    // Simple logic to determine the text of the hide stats bar button item.
    if (!_hideStats)
        self.hideStatsBarButton.title = @"Hide Stats";
    else
        self.hideStatsBarButton.title = @"Show Stats";
    
    // Add the red team container view.
    self.redTeamContainerView = [[TeamPlayerStatsContainerView alloc] initWithFrame:CGRectMake(0, 200, 320, 153)];
    self.redTeamContainerView.delegate = self;
    [self.view addSubview:self.redTeamContainerView];
    
    // Add the blue team container view.
    self.blueTeamContainerView = [[TeamPlayerStatsContainerView alloc] initWithFrame:CGRectMake(0, 352, 320, 152)];
    self.blueTeamContainerView.delegate = self;
    [self.view addSubview:self.blueTeamContainerView];
    
    // Add the overall red team stats.
    [self configureRedTeamOverallStats];
    [self.view addSubview:self.redTeamOverallStatsView];
    
    // Add the overall blue team stats.
    [self configureBlueTeamOverallStats];
    [self.view addSubview:self.blueTeamOverallStatsView];
    

    
    // Add the webview.
    [self embedYouTube:self.videoID frame:CGRectMake(0 , 0, 320, 200)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    


}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[TeamProfileViewController class]])
    {
        NSString *teamName;
        NSDictionary *teamDict;
        if (self.redTeamContainerView.wasTapped)
        {
            teamName = self.redTeamName;
            teamDict = self.teamModel.teamOneDictionary;
            self.redTeamContainerView.wasTapped = NO;
        }
        else
        {
            teamName = self.blueTeamName;
            teamDict = self.teamModel.teamTwoDictionary;
            self.blueTeamContainerView.wasTapped = NO;
        }
        
        ((TeamProfileViewController*)segue.destinationViewController).teamName = teamName;
        ((TeamProfileViewController*)segue.destinationViewController).teamDictionary = teamDict;


    }
}

#pragma mark Subview Configuration Methods
- (void)embedYouTube:(NSString *)urlString frame:(CGRect)frame
{
    NSString *html = [NSString stringWithFormat:@"<html><head><style type='text/css'>body {background-color: transparent;color: white;}</style></head><body style='margin:0'><iframe width='%f' height='%f' src='https://www.youtube.com/embed/%@?feature=player_detailpage&playsinline=1\' frameborder='0' allowfullscreen></iframe></body></html>", frame.size.width, frame.size.height, urlString];
    UIWebView *videoView = [[UIWebView alloc] initWithFrame:frame];
    videoView.allowsInlineMediaPlayback = YES;
    [videoView loadHTMLString:html baseURL:nil];
    [videoView loadHTMLString:html baseURL:nil];
    videoView.scrollView.scrollEnabled = NO;
    [self.view addSubview:videoView];
}

-(void)configureRedTeamOverallStats
{
    self.redTeamOverallStatsView = [[TeamOverallStatsView alloc] initWithFrame:CGRectMake(0, -152, 320, 153)];
    
    self.redTeamOverallStatsView.delegate = self;
    
}

-(void)configureBlueTeamOverallStats
{
    
    self.blueTeamOverallStatsView = [[TeamOverallStatsView alloc] initWithFrame:CGRectMake(0, -153, 320, 152)];
    
    self.blueTeamOverallStatsView.delegate = self;
    
}

#pragma mark Animation Methods
-(void)animateBlueTeamStatsAway
{
    self.blueTeamOverallStatsView.frame = CGRectMake(-320, 352, 320, 152);
    
    [UIView animateWithDuration:0.5 delay:0
                        options:nil
                     animations:^
     {
         CGRect newFrame = self.blueTeamContainerView.frame;
         newFrame.origin.x += 320;
         self.blueTeamContainerView.frame = newFrame;
         
        CGRect otherFrame = self.blueTeamOverallStatsView.frame;
         otherFrame.origin.x += 320;
         self.blueTeamOverallStatsView.frame = otherFrame;
         
         
         
         
     } completion:nil];
    
}

-(void)animateBlueTeamStatsOn
{
    self.blueTeamContainerView.frame = CGRectMake(-320, 352, 320, 152);
    
    [UIView animateWithDuration:0.5 delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         CGRect newFrame = self.blueTeamContainerView.frame;
         newFrame.origin.x += 320;
         self.blueTeamContainerView.frame = newFrame;
         
         CGRect otherFrame = self.blueTeamOverallStatsView.frame;
         otherFrame.origin.x += 320;
         self.blueTeamOverallStatsView.frame = otherFrame;
         
         
         
         
     } completion:nil];
    
}

-(void)animateRedTeamStatsOn
{
    self.redTeamContainerView.frame = CGRectMake(-320, 200, 320, 153);

    [UIView animateWithDuration:0.5 delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         CGRect newFrame = self.redTeamContainerView.frame;
         newFrame.origin.x += 320;
         self.redTeamContainerView.frame = newFrame;
         
         CGRect otherFrame = self.redTeamOverallStatsView.frame;
         otherFrame.origin.x += 320;
         self.redTeamOverallStatsView.frame = otherFrame;
         
         
         
         
     } completion:nil];
    
}

-(void)animateRedTeamStatsAway
{
    self.redTeamOverallStatsView.frame = CGRectMake(-320, 200, 320, 153);
    
    [UIView animateWithDuration:0.5 delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^
    {
        CGRect newFrame = self.redTeamContainerView.frame;
        newFrame.origin.x += 320;
        self.redTeamContainerView.frame = newFrame;
        
        CGRect otherFrame = self.redTeamOverallStatsView.frame;
        otherFrame.origin.x += 320;
        self.redTeamOverallStatsView.frame = otherFrame;
        
       
        
        
    } completion:nil];
}

-(void)hideTeamStatsViewWithAnimationWithDuration:(NSTimeInterval)duration
{
    // Hide the red team stats view.
    [UIView animateWithDuration:duration
                                   delay:0
                                 options:UIViewAnimationOptionCurveLinear
                              animations:^
    {
        if (!_redTeamStats)
        {
            CGRect newFrame = self.redTeamContainerView.frame;
            newFrame.origin.y -= 250;
            self.redTeamContainerView.frame = newFrame;
        }
        else
        {
            CGRect newFrame = self.redTeamOverallStatsView.frame;
            newFrame.origin.y -= 250;
            self.redTeamOverallStatsView.frame = newFrame;
            
        }
        
    } completion:nil];
    
    // Hide the blue team stats view.
    [UIView animateWithDuration:duration
                                   delay:0
                                 options:UIViewAnimationOptionCurveLinear
                              animations:^
     {
         if (!_blueTeamStats)
         {
             CGRect newFrame = self.blueTeamContainerView.frame;
             newFrame.origin.y += 200;
             self.blueTeamContainerView.frame = newFrame;
         }
         else
         {
             CGRect newFrame = self.blueTeamOverallStatsView.frame;
             newFrame.origin.y += 200;
             self.blueTeamOverallStatsView.frame = newFrame;
             
         }
         
     } completion:nil];
    
    
}

-(void)showTeamStatsViewWithAnimationWithDuration:(NSTimeInterval)duration
{
    // Show the red team stats.
    [UIView animateWithDuration:duration
                                   delay:0
                                 options:UIViewAnimationOptionCurveLinear
                              animations:^
     {
         if (!_redTeamStats)
         {
             CGRect newFrame = self.redTeamContainerView.frame;
             newFrame.origin.y += 250;
             self.redTeamContainerView.frame = newFrame;
         }
         else
         {
             CGRect newFrame = self.redTeamOverallStatsView.frame;
             newFrame.origin.y += 250;
             self.redTeamOverallStatsView.frame = newFrame;
             
         }
         
     }
                              completion:nil];
    // Show the blue team stats.
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^
    {
        if (!_blueTeamStats)
        {
            CGRect newFrame = self.blueTeamContainerView.frame;
            newFrame.origin.y -= 200;
            self.blueTeamContainerView.frame = newFrame;
        }
        else
        {
            CGRect newFrame = self.blueTeamOverallStatsView.frame;
            newFrame.origin.y -= 200;
            self.blueTeamOverallStatsView.frame = newFrame;
        }
        
            
                     } completion:nil];
    
}

- (IBAction)didPressHidStatsButton:(id)sender
{
    //TODO: Animate the hiding of the team stats.
    
    if (!_hideStats)
    {
        _hideStats = true;

        self.hideStatsBarButton.title = @"Show Stats";
        
        [self hideTeamStatsViewWithAnimationWithDuration:1.0];
        

    }
    else
    {
        _hideStats = false;
       
        self.hideStatsBarButton.title = @"Hide Stats";
        
        [self showTeamStatsViewWithAnimationWithDuration:1.0];
        

        
    }
}

-(void)populateGameStats
{
    NSDictionary *redTeamStats;
    NSDictionary *blueTeamStats;
    
    if ([[[self.gameStats.gameStatsDictionary objectForKey:self.redTeamName] objectForKey:@"side"] isEqualToString:@"red"])
    {
       redTeamStats = [self.gameStats.gameStatsDictionary objectForKey:self.redTeamName];
        blueTeamStats = [self.gameStats.gameStatsDictionary objectForKey:self.blueTeamName];

    }
    else
    {
        redTeamStats = [self.gameStats.gameStatsDictionary objectForKey:self.blueTeamName];
        blueTeamStats = [self.gameStats.gameStatsDictionary objectForKey:self.redTeamName];
        
    }
    
    self.redTeamContainerView.teamBanOne.image = [UIImage imageNamed:[redTeamStats objectForKey:@"ban-one"]];
    self.redTeamContainerView.teamBanTwo.image = [UIImage imageNamed:[redTeamStats objectForKey:@"ban-two"]];
    self.redTeamContainerView.teamBanThree.image = [UIImage imageNamed:[redTeamStats objectForKey:@"ban-three"]];

    
    // TOP LANER
    self.redTeamContainerView.topLaner.playerCharacterImageView.image = [UIImage imageNamed:[[redTeamStats
                                                                                              objectForKey:@"champions"]
                                                                                             objectForKey:@"top"]];
    self.redTeamContainerView.topLaner.playerKDALabel.text = [[redTeamStats objectForKey:@"kda"]
                                                                            objectForKey:@"top"];
    self.redTeamContainerView.topLaner.playerSummonerSpellOne.image = [UIImage imageNamed:[[[redTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"top"]
                                                                                           objectForKey:@"one"]];
    self.redTeamContainerView.topLaner.playerSummonerSpellTwo.image = [UIImage imageNamed:[[[redTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"top"]
                                                                                           objectForKey:@"two"]];
    self.redTeamContainerView.topLaner.playerCSLabel.text = [[redTeamStats objectForKey:@"cs"]
                                                             objectForKey:@"top"];
    self.redTeamContainerView.topLaner.playerGoldLabel.text = [[redTeamStats objectForKey:@"total-gold"]
                                                               objectForKey:@"top"];
    
    // JUNGLE LANER
    self.redTeamContainerView.jungleLaner.playerCharacterImageView.image = [UIImage imageNamed:[[redTeamStats
                                                                                                 objectForKey:@"champions"]
                                                                                                 objectForKey:@"jungle"]];
    self.redTeamContainerView.jungleLaner.playerKDALabel.text = [[redTeamStats objectForKey:@"kda"]
                                                              objectForKey:@"jungle"];
    self.redTeamContainerView.jungleLaner.playerSummonerSpellOne.image = [UIImage imageNamed:[[[redTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"jungle"]
                                                                                           objectForKey:@"one"]];
    self.redTeamContainerView.jungleLaner.playerSummonerSpellTwo.image = [UIImage imageNamed:[[[redTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"jungle"]
                                                                                           objectForKey:@"two"]];
    self.redTeamContainerView.jungleLaner.playerCSLabel.text = [[redTeamStats objectForKey:@"cs"]
                                                             objectForKey:@"jungle"];
    self.redTeamContainerView.jungleLaner.playerGoldLabel.text = [[redTeamStats objectForKey:@"total-gold"]
                                                               objectForKey:@"jungle"];
    
    // MID LANER
    self.redTeamContainerView.midLaner.playerCharacterImageView.image = [UIImage imageNamed:[[redTeamStats
                                                                                              objectForKey:@"champions"]
                                                                                             objectForKey:@"mid"]];
    self.redTeamContainerView.midLaner.playerKDALabel.text = [[redTeamStats objectForKey:@"kda"]
                                                              objectForKey:@"mid"];
    self.redTeamContainerView.midLaner.playerSummonerSpellOne.image = [UIImage imageNamed:[[[redTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"mid"]
                                                                                           objectForKey:@"one"]];
    self.redTeamContainerView.midLaner.playerSummonerSpellTwo.image = [UIImage imageNamed:[[[redTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"mid"]
                                                                                           objectForKey:@"two"]];
    self.redTeamContainerView.midLaner.playerCSLabel.text = [[redTeamStats objectForKey:@"cs"]
                                                             objectForKey:@"mid"];
    self.redTeamContainerView.midLaner.playerGoldLabel.text = [[redTeamStats objectForKey:@"total-gold"]
                                                               objectForKey:@"mid"];
    
    // ADC LANER
    self.redTeamContainerView.adcLaner.playerCharacterImageView.image = [UIImage imageNamed:[[redTeamStats
                                                                                              objectForKey:@"champions"]
                                                                                             objectForKey:@"adc"]];
    self.redTeamContainerView.adcLaner.playerKDALabel.text = [[redTeamStats objectForKey:@"kda"]
                                                              objectForKey:@"adc"];
    self.redTeamContainerView.adcLaner.playerSummonerSpellOne.image = [UIImage imageNamed:[[[redTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"adc"]
                                                                                           objectForKey:@"one"]];
    self.redTeamContainerView.adcLaner.playerSummonerSpellTwo.image = [UIImage imageNamed:[[[redTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"adc"]
                                                                                           objectForKey:@"two"]];
    self.redTeamContainerView.adcLaner.playerCSLabel.text = [[redTeamStats objectForKey:@"cs"]
                                                             objectForKey:@"adc"];
    self.redTeamContainerView.adcLaner.playerGoldLabel.text = [[redTeamStats objectForKey:@"total-gold"]
                                                               objectForKey:@"adc"];
    
    // SUPPORT LANER
    self.redTeamContainerView.supportLaner.playerCharacterImageView.image = [UIImage imageNamed:[[redTeamStats
                                                                                                  objectForKey:@"champions"]
                                                                                             objectForKey:@"support"]];
    self.redTeamContainerView.supportLaner.playerKDALabel.text = [[redTeamStats objectForKey:@"kda"]
                                                              objectForKey:@"support"];
    self.redTeamContainerView.supportLaner.playerSummonerSpellOne.image = [UIImage imageNamed:[[[redTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"support"]
                                                                                           objectForKey:@"one"]];
    self.redTeamContainerView.supportLaner.playerSummonerSpellTwo.image = [UIImage imageNamed:[[[redTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"support"]
                                                                                           objectForKey:@"two"]];
    self.redTeamContainerView.supportLaner.playerCSLabel.text = [[redTeamStats objectForKey:@"cs"]
                                                             objectForKey:@"support"];
    self.redTeamContainerView.supportLaner.playerGoldLabel.text = [[redTeamStats objectForKey:@"total-gold"]
                                                               objectForKey:@"support"];
    
    // Team Overall Stats Configuration.
    self.redTeamOverallStatsView.kdaStatLabel.text = [[redTeamStats objectForKey:@"stats"] objectForKey:@"kdaratio"];
    self.redTeamOverallStatsView.championStatLabel.text = [[redTeamStats objectForKey:@"stats"] objectForKey:@"champions"];
    self.redTeamOverallStatsView.goldStatLabel.text = [[redTeamStats objectForKey:@"stats"] objectForKey:@"gold-min"];
    self.redTeamOverallStatsView.totalGoldStatLabel.text = [[redTeamStats objectForKey:@"stats"] objectForKey:@"total-gold"];
    self.redTeamOverallStatsView.minionStatLabel.text = [[redTeamStats objectForKey:@"stats"] objectForKey:@"minions"];
    
    /********************BLUE TEAM STATS*******************************************************/
    
    
    
    self.blueTeamContainerView.teamBanOne.image = [UIImage imageNamed:[blueTeamStats objectForKey:@"ban-one"]];
    self.blueTeamContainerView.teamBanTwo.image = [UIImage imageNamed:[blueTeamStats objectForKey:@"ban-two"]];
    self.blueTeamContainerView.teamBanThree.image = [UIImage imageNamed:[blueTeamStats objectForKey:@"ban-three"]];
    
    // TOP LANER
    self.blueTeamContainerView.topLaner.playerCharacterImageView.image = [UIImage imageNamed:[[blueTeamStats
                                                                                              objectForKey:@"champions"]
                                                                                             objectForKey:@"top"]];
    self.blueTeamContainerView.topLaner.playerKDALabel.text = [[blueTeamStats objectForKey:@"kda"]
                                                              objectForKey:@"top"];
    self.blueTeamContainerView.topLaner.playerSummonerSpellOne.image = [UIImage imageNamed:[[[blueTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"top"]
                                                                                           objectForKey:@"one"]];
    self.blueTeamContainerView.topLaner.playerSummonerSpellTwo.image = [UIImage imageNamed:[[[blueTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"top"]
                                                                                           objectForKey:@"two"]];
    self.blueTeamContainerView.topLaner.playerCSLabel.text = [[blueTeamStats objectForKey:@"cs"]
                                                             objectForKey:@"top"];
    self.blueTeamContainerView.topLaner.playerGoldLabel.text = [[blueTeamStats objectForKey:@"total-gold"]
                                                               objectForKey:@"top"];
    
    // JUNGLE LANER
    self.blueTeamContainerView.jungleLaner.playerCharacterImageView.image = [UIImage imageNamed:[[blueTeamStats
                                                                                                 objectForKey:@"champions"]
                                                                                                objectForKey:@"jungle"]];
    self.blueTeamContainerView.jungleLaner.playerKDALabel.text = [[blueTeamStats objectForKey:@"kda"]
                                                                 objectForKey:@"jungle"];
    self.blueTeamContainerView.jungleLaner.playerSummonerSpellOne.image = [UIImage imageNamed:[[[blueTeamStats objectForKey:@"summoner-spells"]
                                                                                               objectForKey:@"jungle"]
                                                                                              objectForKey:@"one"]];
    self.blueTeamContainerView.jungleLaner.playerSummonerSpellTwo.image = [UIImage imageNamed:[[[blueTeamStats objectForKey:@"summoner-spells"]
                                                                                               objectForKey:@"jungle"]
                                                                                              objectForKey:@"two"]];
    self.blueTeamContainerView.jungleLaner.playerCSLabel.text = [[blueTeamStats objectForKey:@"cs"]
                                                                objectForKey:@"jungle"];
    self.blueTeamContainerView.jungleLaner.playerGoldLabel.text = [[blueTeamStats objectForKey:@"total-gold"]
                                                                  objectForKey:@"jungle"];
    
    // MID LANER
    self.blueTeamContainerView.midLaner.playerCharacterImageView.image = [UIImage imageNamed:[[blueTeamStats
                                                                                              objectForKey:@"champions"]
                                                                                             objectForKey:@"mid"]];
    self.blueTeamContainerView.midLaner.playerKDALabel.text = [[blueTeamStats objectForKey:@"kda"]
                                                              objectForKey:@"mid"];
    self.blueTeamContainerView.midLaner.playerSummonerSpellOne.image = [UIImage imageNamed:[[[blueTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"mid"]
                                                                                           objectForKey:@"one"]];
    self.blueTeamContainerView.midLaner.playerSummonerSpellTwo.image = [UIImage imageNamed:[[[blueTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"mid"]
                                                                                           objectForKey:@"two"]];
    self.blueTeamContainerView.midLaner.playerCSLabel.text = [[blueTeamStats objectForKey:@"cs"]
                                                             objectForKey:@"mid"];
    self.blueTeamContainerView.midLaner.playerGoldLabel.text = [[blueTeamStats objectForKey:@"total-gold"]
                                                               objectForKey:@"mid"];
    
    // ADC LANER
    self.blueTeamContainerView.adcLaner.playerCharacterImageView.image = [UIImage imageNamed:[[blueTeamStats
                                                                                              objectForKey:@"champions"]
                                                                                             objectForKey:@"adc"]];
    self.blueTeamContainerView.adcLaner.playerKDALabel.text = [[blueTeamStats objectForKey:@"kda"]
                                                              objectForKey:@"adc"];
    self.blueTeamContainerView.adcLaner.playerSummonerSpellOne.image = [UIImage imageNamed:[[[blueTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"adc"]
                                                                                           objectForKey:@"one"]];
    self.blueTeamContainerView.adcLaner.playerSummonerSpellTwo.image = [UIImage imageNamed:[[[blueTeamStats objectForKey:@"summoner-spells"]
                                                                                            objectForKey:@"adc"]
                                                                                           objectForKey:@"two"]];
    self.blueTeamContainerView.adcLaner.playerCSLabel.text = [[blueTeamStats objectForKey:@"cs"]
                                                             objectForKey:@"adc"];
    self.blueTeamContainerView.adcLaner.playerGoldLabel.text = [[blueTeamStats objectForKey:@"total-gold"]
                                                               objectForKey:@"adc"];
    
    // SUPPORT LANER
    self.blueTeamContainerView.supportLaner.playerCharacterImageView.image = [UIImage imageNamed:[[blueTeamStats
                                                                                                  objectForKey:@"champions"]
                                                                                                 objectForKey:@"support"]];
    self.blueTeamContainerView.supportLaner.playerKDALabel.text = [[blueTeamStats objectForKey:@"kda"]
                                                                  objectForKey:@"support"];
    self.blueTeamContainerView.supportLaner.playerSummonerSpellOne.image = [UIImage imageNamed:[[[blueTeamStats objectForKey:@"summoner-spells"]
                                                                                                objectForKey:@"support"]
                                                                                               objectForKey:@"one"]];
    self.blueTeamContainerView.supportLaner.playerSummonerSpellTwo.image = [UIImage imageNamed:[[[blueTeamStats objectForKey:@"summoner-spells"]
                                                                                                objectForKey:@"support"]
                                                                                               objectForKey:@"two"]];
    self.blueTeamContainerView.supportLaner.playerCSLabel.text = [[blueTeamStats objectForKey:@"cs"]
                                                                 objectForKey:@"support"];
    self.blueTeamContainerView.supportLaner.playerGoldLabel.text = [[blueTeamStats objectForKey:@"total-gold"]
                                                                   objectForKey:@"support"];
    
    // Blue Team Overall Stats
    self.blueTeamOverallStatsView.kdaStatLabel.text = [[blueTeamStats objectForKey:@"stats"] objectForKey:@"kdaratio"];
    self.blueTeamOverallStatsView.championStatLabel.text = [[blueTeamStats objectForKey:@"stats"] objectForKey:@"champions"];
    self.blueTeamOverallStatsView.goldStatLabel.text = [[blueTeamStats objectForKey:@"stats"] objectForKey:@"gold-min"];
    self.blueTeamOverallStatsView.totalGoldStatLabel.text = [[blueTeamStats objectForKey:@"stats"] objectForKey:@"total-gold"];
    self.blueTeamOverallStatsView.minionStatLabel.text = [[blueTeamStats objectForKey:@"stats"] objectForKey:@"minions"];
    
}

-(void)updateTeamNames
{
    self.redTeamContainerView.teamNameLabel.text = [self.teamModel.teamOneDictionary objectForKey:@"team-name"];
    self.redTeamContainerView.teamNameLabel.textColor = [UIColor redColor];
    self.redTeamContainerView.topLaner.playerNameLabel.text = [[self.teamModel.teamOneDictionary objectForKey:@"players"]
                                                                                                    objectForKey:@"top"];
    self.redTeamContainerView.jungleLaner.playerNameLabel.text = [[self.teamModel.teamOneDictionary objectForKey:@"players"]
                                                               objectForKey:@"jungle"];
    self.redTeamContainerView.midLaner.playerNameLabel.text = [[self.teamModel.teamOneDictionary objectForKey:@"players"]
                                                               objectForKey:@"mid"];
    self.redTeamContainerView.adcLaner.playerNameLabel.text = [[self.teamModel.teamOneDictionary objectForKey:@"players"]
                                                               objectForKey:@"adc"];
    self.redTeamContainerView.supportLaner.playerNameLabel.text = [[self.teamModel.teamOneDictionary objectForKey:@"players"]
                                                               objectForKey:@"support"];
    
    
    self.blueTeamContainerView.teamNameLabel.text = [self.teamModel.teamTwoDictionary objectForKey:@"team-name"];
    self.blueTeamContainerView.teamNameLabel.textColor = [UIColor blueColor];
    self.blueTeamContainerView.topLaner.playerNameLabel.text = [[self.teamModel.teamTwoDictionary objectForKey:@"players"]
                                                               objectForKey:@"top"];
    self.blueTeamContainerView.jungleLaner.playerNameLabel.text = [[self.teamModel.teamTwoDictionary objectForKey:@"players"]
                                                                  objectForKey:@"jungle"];
    self.blueTeamContainerView.midLaner.playerNameLabel.text = [[self.teamModel.teamTwoDictionary objectForKey:@"players"]
                                                               objectForKey:@"mid"];
    self.blueTeamContainerView.adcLaner.playerNameLabel.text = [[self.teamModel.teamTwoDictionary objectForKey:@"players"]
                                                               objectForKey:@"adc"];
    self.blueTeamContainerView.supportLaner.playerNameLabel.text = [[self.teamModel.teamTwoDictionary objectForKey:@"players"]
                                                                   objectForKey:@"support"];
}

#pragma mark TeamOverallStatsDelegate
-(void)didSwipeOverallStats:(float)yLocation
{
    if (yLocation < 320)
    {
        [self animateRedTeamStatsOn];
        _redTeamStats = false;
    }
    else
    {
        [self animateBlueTeamStatsOn];
        _blueTeamStats = false;
    }
    
}

#pragma mark TeamPlayerStatsContainerView
-(void)didSwipContainerView:(float)yLocation
{
    if (yLocation < 320)
    {
        [self animateRedTeamStatsAway];
        _redTeamStats = true;
    }
    else
    {
        [self animateBlueTeamStatsAway];
        _blueTeamStats = true;
    }
}

-(void)didTapContainerView:(float)yLocation
{
    [self performSegueWithIdentifier:@"TeamProfileVC" sender:nil];
}

#pragma mark GameStatsRetrieverDelegate
-(void)recievedGameStatsFromRetriever
{
    [self populateGameStats];
}

-(void)didRecieveTeams
{
    if (![[[self.gameStats.gameStatsDictionary objectForKey:self.redTeamName] objectForKey:@"side"] isEqualToString:@"red"])
    {
        NSDictionary * temp;
        temp = self.teamModel.teamTwoDictionary;
        self.teamModel.teamTwoDictionary = self.teamModel.teamOneDictionary;
        self.teamModel.teamOneDictionary = [NSDictionary dictionaryWithDictionary:temp];
        
        NSString *tempString;
        tempString = self.blueTeamName;
        self.blueTeamName = self.redTeamName;
        self.redTeamName = tempString;
        
    }
    
    [self updateTeamNames];
}

@end
