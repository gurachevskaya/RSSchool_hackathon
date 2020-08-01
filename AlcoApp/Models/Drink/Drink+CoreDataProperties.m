//
//  Drink+CoreDataProperties.m
//  AlcoApp
//
//  Created by Karina on 8/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//
//

#import "Drink+CoreDataProperties.h"

@implementation Drink (CoreDataProperties)

+ (NSFetchRequest<Drink *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Drink"];
}

@dynamic alcoholPercent;
@dynamic date;
@dynamic name;
@dynamic volume;

@end
