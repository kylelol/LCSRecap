//
//  TeamPlayerStatsView.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 10/9/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamPlayerStatsView : UIView

@property (nonatomic, strong) IBOutlet UIImageView *playerCharacterImageView;
@property (nonatomic, strong) IBOutlet UILabel *playerNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *playerSummonerSpellOne;
@property (nonatomic, strong) IBOutlet UIImageView *playerSummonerSpellTwo;
@property (nonatomic, strong) IBOutlet UILabel *playerKDALabel;
@property (nonatomic, strong) IBOutlet UILabel *playerGoldLabel;
@property (nonatomic, strong) IBOutlet UILabel *playerCSLabel;

// TODO: ADD ITEM IMAGE VIEWS




@end
