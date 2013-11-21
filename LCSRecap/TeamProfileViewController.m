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
#import "OVPlotGraphViewCell.h"

@interface TeamProfileViewController () <TeamProfileCellDelegate, OVPlotGraphViewCellDelegate>

@end

@implementation TeamProfileViewController
{
    PlayerProfileAnimationController *_animationController;
    NSInteger _statsByWeekSelectedSegment;
    NSString *selectedPlayer;
    BOOL firstRun;
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
    
        [self.tableView registerNib:[UINib nibWithNibName:@"OVPlotGraphViewCell" bundle:nil] forCellReuseIdentifier:@"graphViewCell"];
    
    // Initial Condition
    _statsByWeekSelectedSegment = 0;
    firstRun = false;
    
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
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
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
       /* if (!cell.statsGraphview)
        {
            cell.statsGraphview = [[OVGraphView alloc]initWithFrame:CGRectMake(0, 0, 306, 180) ContentSize:CGSizeMake(306, 180)];
        
            cell.statsGraphview.plotContainer.graphcolor = [UIColor colorWithRed:0.31 green:0.73 blue:0.78 alpha:1.0];
        
            [cell.GraphView addSubview:cell.statsGraphview];
        
            [cell.statsGraphview setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"1" YValue:@3.2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"2" YValue:@4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@6 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"4" YValue:@6 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"5" YValue:@9 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"6" YValue:@3 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"7" YValue:@4 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"8" YValue:@11 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"9" YValue:@13 ],
                               ]];

        }*/
    
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMidLane:)];
        [cell.adcThumbImageView addGestureRecognizer:tap];
        [cell bringSubviewToFront:cell.adcThumbImageView];
            
            firstRun = true;
        return cell;
    }
    else
    {
        OVPlotGraphViewCell *cell = (OVPlotGraphViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"graphViewCell"];
        
        cell.delegate = self;
        
        cell.statsByWeekSegmentedControl.selectedSegmentIndex = _statsByWeekSelectedSegment;
        
        OVGraphView *graph = [[OVGraphView alloc]initWithFrame:CGRectMake(2, 23, 310, 180) ContentSize:CGSizeMake(310, 180)];
        
        graph.plotContainer.graphcolor = [UIColor colorWithRed:0.31 green:0.73 blue:0.78 alpha:1.0];
        
        [cell addSubview:graph];
        
        if( _statsByWeekSelectedSegment == 0)
        {
        [graph setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"1" YValue:@3.2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"2" YValue:@4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@6 ],
                                         [[OVGraphViewPoint alloc]initWithXLabel:@"4" YValue:@6 ],
                                         [[OVGraphViewPoint alloc]initWithXLabel:@"5" YValue:@9 ],
                                         [[OVGraphViewPoint alloc]initWithXLabel:@"6" YValue:@3 ],
                                         [[OVGraphViewPoint alloc]initWithXLabel:@"7" YValue:@4 ],
                                         [[OVGraphViewPoint alloc]initWithXLabel:@"8" YValue:@11 ],
                                         [[OVGraphViewPoint alloc]initWithXLabel:@"9" YValue:@13 ],
                                         ]];
        }
        else if (_statsByWeekSelectedSegment == 1)
        {
            [graph setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"1" YValue:@3.2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"2" YValue:@4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@6 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"4" YValue:@10 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"5" YValue:@9 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"6" YValue:@3 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"7" YValue:@10 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"8" YValue:@4 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"9" YValue:@5 ],
                               ]];
            
        }
        else
        {
            [graph setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"1" YValue:@3000 ],[[OVGraphViewPoint alloc]initWithXLabel:@"2" YValue:@2500 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@2000 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"4" YValue:@4000 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"5" YValue:@4500 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"6" YValue:@1000 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"7" YValue:@20000 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"8" YValue:@3000 ],
                               [[OVGraphViewPoint alloc]initWithXLabel:@"9" YValue:@15000 ],
                               ]];
            
        }
        
        return cell;
        
    }

}

/*-(void)resetGraphView
{
    TeamProfileCell *cell = (TeamProfileCell*)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
    
    cell.statsGraphview = nil;
    
    cell.statsGraphview = [[OVGraphView alloc]initWithFrame:CGRectMake(0, 0, 306, 180) ContentSize:CGSizeMake(306, 180)];
    
    cell.statsGraphview.plotContainer.graphcolor = [UIColor colorWithRed:0.31 green:0.73 blue:0.78 alpha:1.0];
    
    [cell.GraphView addSubview:cell.statsGraphview];
    
    [cell.statsGraphview setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"1" YValue:@3.2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"2" YValue:@4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@6 ],
                                     [[OVGraphViewPoint alloc]initWithXLabel:@"4" YValue:@6 ],
                                     [[OVGraphViewPoint alloc]initWithXLabel:@"5" YValue:@9 ],
                                     [[OVGraphViewPoint alloc]initWithXLabel:@"6" YValue:@3 ],
                                     [[OVGraphViewPoint alloc]initWithXLabel:@"7" YValue:@8 ],
                                     [[OVGraphViewPoint alloc]initWithXLabel:@"8" YValue:@10 ],
                                     [[OVGraphViewPoint alloc]initWithXLabel:@"9" YValue:@4 ],
                                     ]];
    
   // [self.tableView reloadData];
    
   
    
    
    
    
}*/

-(void)didTapMidLane:(id)sender
{
    [self shouldSegueToPlayerProfilePage:@"mid" withInitialFrame:CGRectMake(0, 0, 0, 0)];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        return 300;
    }
    return 800;
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


-(void)didSwitchStatsByWeekSegment:(NSInteger)selectedSegment
{
    NSLog(@"%d", selectedSegment);
    _statsByWeekSelectedSegment = selectedSegment;
    NSIndexPath* indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
    
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath1] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    //[self.tableView reloadData];
    
}
@end
