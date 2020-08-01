//
//  Drink+CoreDataProperties.h
//  AlcoApp
//
//  Created by Karina on 8/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//
//

#import "Drink+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Drink (CoreDataProperties)

+ (NSFetchRequest<Drink *> *)fetchRequest;

@property (nonatomic) int16_t alcoholPercent;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) float volume;

@end

NS_ASSUME_NONNULL_END
