//
//  DrinkTableViewCell.h
//  AlcoApp
//
//  Created by Karina on 8/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drink+CoreDataProperties.h"


NS_ASSUME_NONNULL_BEGIN

@interface DrinkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *drinkNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;

- (void)configureWithDrink:(Drink *)drink;
@end

NS_ASSUME_NONNULL_END
