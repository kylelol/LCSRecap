//
//  TestViewController.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 11/9/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "TestViewController.h"
#import "OVGraphView.h"
#import "OVGraphViewPoint.h"

@interface TestViewController ()

@end

@implementation TestViewController

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
    
    OVGraphView *graphview=[[OVGraphView alloc]initWithFrame:CGRectMake(0, 0, 200, 300) ContentSize:CGSizeMake(200, 300)];
    
    graphview.plotContainer.graphcolor=[UIColor colorWithRed:0.31 green:0.73 blue:0.78 alpha:1.0];

    
    //customizations go here
    
    [self.view addSubview:graphview];
    
    [graphview setPoints:@[[[OVGraphViewPoint alloc]initWithXLabel:@"today" YValue:@3.2 ],[[OVGraphViewPoint alloc]initWithXLabel:@"yesterday" YValue:@4 ],[[OVGraphViewPoint alloc]initWithXLabel:@"3" YValue:@6 ]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
