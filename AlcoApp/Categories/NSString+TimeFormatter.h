//
//  NSString+TimeFormatter.h
//  AlcoApp
//
//  Created by Karina on 8/2/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TimeFormatter)

+ (NSString *)timeFormatted:(int)totalSeconds;

@end

NS_ASSUME_NONNULL_END
