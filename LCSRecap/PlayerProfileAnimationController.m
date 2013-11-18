//
//  PlayerProfileAnimationController.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/21/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "PlayerProfileAnimationController.h"

@implementation PlayerProfileAnimationController

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Obtain the state from the context
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    // Obtain the container view
    UIView *containerView = [transitionContext containerView];
    
    // Set initial state
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
  //  toViewController.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    toViewController.view.frame = self.selectedFrame;
    
    // Add the view
    [containerView addSubview:toViewController.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                     animations:^{
                         toViewController.view.frame = CGRectMake(finalFrame.origin.x + 20, finalFrame.origin.y + 20, finalFrame.size.width - 40, finalFrame.size.height - 40);
                     }
                     completion:^(BOOL finished) {
            // 6. inform the context of completion
            [transitionContext completeTransition:YES];
                     }];
}

@end
