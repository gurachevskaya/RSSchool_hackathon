//
//  StartViewController.h
//  AlcoApp
//
//  Created by Karina on 8/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ViewControllerType) {
  Greeting,
  Preferences
};

@protocol UIConfiguringProtocol

- (void)configureButtonText;

@end

@interface StartViewController : UIViewController <UIConfiguringProtocol>

- (instancetype)initWithType:(ViewControllerType)type;

@end

//NS_ASSUME_NONNULL_END
