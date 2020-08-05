//
//  UIColor+ProjectColors.m
//  AlcoApp
//
//  Created by Karina on 8/2/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "UIColor+ProjectColors.h"

@implementation UIColor (ProjectColors)

+ (UIColor *)primaryColor {
    return [UIColor colorNamed:@"Color2"];
}

+ (UIColor *)primaryDarkColor {
    return [UIColor colorNamed:@"Color3"];
}

+ (UIColor *)primaryLightColor {
    return [UIColor colorNamed:@"Color1"];
}

+ (UIColor *)accentColor {
    return [UIColor colorNamed:@"Color4"];
}

@end
