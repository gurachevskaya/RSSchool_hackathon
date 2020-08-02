//
//  DrinkTableViewCell.h
//  AlcoApp
//
//  Created by Karina on 8/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//typedef NS_ENUM(NSInteger, behaviours) {
//    SOBER,
//    ALMOST_NORMAL,
//    EUPHORIC,
//    DISINHIBITIONS,
//    EXPRESSIVENESS,
//    STUPOR,
//    UNCONSCIOUS,
//    BLACKOUT,
//    DEAD
//};





@interface DrinkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *drinkNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@end

NS_ASSUME_NONNULL_END
