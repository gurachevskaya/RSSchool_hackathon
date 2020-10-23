//
//  AppDelegate.m
//  AlcoApp
//
//  Created by Karina on 8/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "AppDelegate.h"
#import "StartViewController.h"
#import "DataManager.h"
#import "User+CoreDataProperties.h"
#import "GeneralInformationViewController.h"
#import "DataManager.h"
#import "Drink+CoreDataProperties.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSManagedObjectContext *viewContext = [DataManager sharedManager].newBackgroundContext;
    NSFetchRequest *fetchRequest = [User fetchRequest];
    NSArray *resultArray = [viewContext executeFetchRequest:fetchRequest error:nil];
    
    if (resultArray.count == 0) {
        StartViewController *vc = [[StartViewController alloc] initWithType:Greeting];
        self.window.rootViewController = vc;

    } else {
        GeneralInformationViewController *vc = [[GeneralInformationViewController alloc]initWithNibName:@"GeneralInformationViewController" bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = navigationController;
    }

    [self.window makeKeyAndVisible];
    
    
//    [[DataManager sharedManager] addDrink:@"Beer" alcoholPercent:8 volume:1000];
//    [[DataManager sharedManager] addDrink:@"Wine" alcoholPercent:12 volume:200];
    
    /*
     [[DataManager sharedManager] configureUserWithAge:18 sex:@"male" weight:55];
     [[DataManager sharedManager] configureUserWithAge:20 sex:@"female" weight:55];
     */
    
     
     NSManagedObjectContext *context = [DataManager sharedManager].newBackgroundContext;
     NSFetchRequest *request = [Drink fetchRequest];
     [fetchRequest setReturnsObjectsAsFaults:NO];
     NSArray *drinks = [context executeFetchRequest:request error:nil];
    
//    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:[User fetchRequest]];
//     [context executeRequest:deleteRequest error:nil];
//    [context save:nil];

     NSLog(@"%ld", [[DataManager sharedManager].newBackgroundContext countForFetchRequest:[User fetchRequest] error:nil]);
     
     for (Drink *drink in drinks) {
         NSLog(@"percent: %hd name: %@ volume: %hd", drink.alcoholPercent, drink.name, drink.volume);
     }
    
    return YES;
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
     [[DataManager sharedManager] saveContext];
}

@end
