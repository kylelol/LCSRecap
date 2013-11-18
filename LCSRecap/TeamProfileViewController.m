//
//  TeamProfileViewController.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/15/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "TeamProfileViewController.h"
#import "TeamProfileCell.h"
#import "PlayerProfileAnimationController.h"
#import "PlayerProfileViewController.h"
#import "OVGraphView.h"
#import "OVGraphViewPoint.h"

@interface TeamProfileViewController () <TeamProfileCellDelegate>

@end

@implementation TeamProfileViewController
{
    PlayerProfileAnimationController *_animationController;
    NSString *selectedPlayer;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _animationController = [PlayerProfileAnimationController new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = self.teamName;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    NSLog(@"%@", self.teamDictionary);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TeamProfileCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    // TODO: Fix this tap gesture recognizer.
   // UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnScreen:)];
   // [self.view addGestureRecognizer:tap];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ProfileVC"])
    {
        PlayerProfileViewController *toVc = segue.destinationViewController;
        toVc.transitioningDelegate = self;
        
        toVc.playerName = selectedPlayer;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.seasonRecordLabel.text = [self.teamDictionary objectForKey:@"season-record"];
    cell.nationalityLabel.text = [self.teamDictionary objectForKey:@"nationality"];
    
    NSString *profilePicName = [NSString stringWithFormat:@"%@Profile", self.teamName];
    NSLog(@"%@", profilePicName);
    cell.teamProfileImageView.image = [UIImage imageNamed:profilePicName];
    
    NSString *logoPicName = [NSString stringWithFormat:@"%@Logo", self.teamName];
    cell.teamLogoImageView.image = [UIImage imageNamed:logoPicName];
    
 

    
    cell.topLaneNameLabel.text = [[self.teamDictionary objectForKey:@"full-name"]
                                  objectForKey:@"top"];
    cell.jungleNameLabel.text = [[self.teamDictionary objectForKey:@"full-name"]
                                 objectForKey:@"jungle"];
    cell.midNameLabel.text = [[self.teamDictionary objectForKey:@"full-name"]
                                 objectForKey:@"mid"];
    cell.adcNameLabel.text = [[self.teamDictionary objectForKey:@"full-name"]
                                 objectForKey:@"adc"];
    cell.supportNameLabel.text = [[self.teamDictionary objectForKey:@"full-name"]
                                 objectForKey:@"support"];
    
    // Configure the thumbnail pictures.
    NSString *topName = [[self.teamDictionary objectForKey:@"players"] objectForKey:@"top"];
    NSString *topLaneThumbString = [NSString stringWithFormat:@"%@Thumb", topName];
    cell.topLaneThumbImageView.image = [UIImage imageNamed:topLaneThumbString];
    
    NSString *jungleName = [[self.teamDictionary objectForKey:@"players"] objectForKey:@"jungle"];
    NSString *jungleThumbString = [NSString stringWithFormat:@"%@Thumb", jungleName];
    cell.jungleThumbImageView.image = [UIImage imageNamed:jungleThumbString];
    
    NSString *midName = [[self.teamDictionary objectForKey:@"players"] objectForKey:@"mid"];
    NSString *midThumbString = [NSString stringWithFormat:@"%@Thumb", midName];
    cell.midThumbImageView.image = [UIImage imageNamed:midThumbString];
    
    NSString *adcName = [[self.teamDictionary objectForKey:@"players"] objectForKey:@"adc"];
    NSString *adcThumbString = [NSString stringWithFormat:@"%@Thumb", adcName];
    cell.adcThumbImageView.image = [UIImage imageNamed:adcThumbString];
    
    NSString *supportName = [[self.teamDictionary objectForKey:@"players"] objectForKey:@"support"];
    NSString *supportNameString = [NSString stringWithFormat:@"%@Thumb", supportName];
    cell.supportThumbImageView.image = [UIImage imageNamed:supportNameString];
    
    cell.delegate = self;
    
    OVGraphView *graphview=[[OVGraphView alloc]initWithFrame:CGRectMake(0, 0, 306, 180) ContentSize:CGSizeMake(306, 180)];
    
    graphview.plotContainer.graphcolor=[UIColor colorWithRed:0.31 green:0.73 blue:0.78 alpha:1.0];
    
    //customizations go here
    
    [cell.GraphView addSubview:graphview];
    //[cell.contentView bringSubviewToFront:graphview];
    
    [graphview setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"1" YValue:@3.2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"2" YValue:@4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@6 ],
                           [[OVGraphViewPoint alloc]initWithXLabel:@"4" YValue:@6 ],
                           [[OVGraphViewPoint alloc]initWithXLabel:@"5" YValue:@9 ],
                           [[OVGraphViewPoint alloc]initWithXLabel:@"6" YValue:@3 ],
                           [[OVGraphViewPoint alloc]initWithXLabel:@"7" YValue:@4 ],
                           [[OVGraphViewPoint alloc]initWithXLabel:@"8" YValue:@11 ],
                           [[OVGraphViewPoint alloc]initWithXLabel:@"9" YValue:@13 ],
                           ]];
    [cell sendSubviewToBack:graphview];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMidLane:)];
    [cell.adcThumbImageView addGestureRecognizer:tap];
    [cell bringSubviewToFront:cell.adcThumbImageView];
    
    return cell;
}

-(void)didTapMidLane:(id)sender
{
    [self shouldSegueToPlayerProfilePage:@"mid" withInitialFrame:CGRectMake(0, 0, 0, 0)];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1050;
}

-(void)shouldSegueToPlayerProfilePage:(NSString *)player withInitialFrame:(CGRect)frame
{
    _animationController.selectedFrame = frame;
    selectedPlayer = [[self.teamDictionary objectForKey:@"players"] objectForKey:player];
    [self performSegueWithIdentifier:@"ProfileVC" sender:nil];
}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:
(UIViewController *)presented presentingController:
(UIViewController *)presenting sourceController: (UIViewController *)source
{
    return _animationController;
}
@end
