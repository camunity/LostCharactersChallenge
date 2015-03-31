//
//  LCCTableViewCell.h
//  LostCharactersChallenge
//
//  Created by Jose Garcia on 3/31/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCCTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *characterImage;
@property (weak, nonatomic) IBOutlet UILabel *actorLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *passengerLabel;

@end
