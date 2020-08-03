//
//  DataManager.h
//  AlcoApp
//
//  Created by Karina on 8/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (DataManager *)sharedManager;

- (void)saveContext;
- (NSManagedObjectContext *)viewContext;
- (NSManagedObjectContext *)newBackgroundContext;

- (void)configureUserWithAge:(NSInteger)age sex:(NSString *)sex weight:(NSInteger)weight;
- (void)addDrink:(NSString *)name alcoholPercent:(NSInteger)percent volume:(NSInteger)volume;

@end

NS_ASSUME_NONNULL_END
