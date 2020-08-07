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

- (void)configureText;
- (void)nextButtonTapped;

@end

@interface StartViewController : UIViewController <UIConfiguringProtocol>

- (instancetype)initWithType:(ViewControllerType)type;
@property (nonatomic, copy) void (^onDoneBlock)(void);

@end

//NS_ASSUME_NONNULL_END
