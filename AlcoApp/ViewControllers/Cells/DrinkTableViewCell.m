//
//  DrinkTableViewCell.m
//  AlcoApp
//
//  Created by Karina on 8/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "DrinkTableViewCell.h"
#import "UIColor+ProjectColors.h"


@interface DrinkTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *roundedView;

@end


@implementation DrinkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.roundedView.backgroundColor = [UIColor primaryLightColor];

}


- (void)configureWithDrink:(Drink *)drink {
    self.drinkNameLabel.text = drink.name;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSString *dateString = [formatter stringFromDate:drink.date];
    
    self.timeLabel.text = dateString;
    
    self.volumeLabel.text = [NSString stringWithFormat:@"%hd ml",drink.volume];
    
}



@end
