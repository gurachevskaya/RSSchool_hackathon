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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    StartViewController *vc = [[StartViewController alloc] initWithNibName:@"StartViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    
/*
    [[DataManager sharedManager] configureUserWithAge:18 sex:@"male" weight:55];
    [[DataManager sharedManager] configureUserWithAge:20 sex:@"female" weight:55];

    NSManagedObjectContext *viewContext = [DataManager sharedManager].newBackgroundContext;
    NSFetchRequest *fetchRequest = [User fetchRequest];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSArray *resultArray = [viewContext executeFetchRequest:fetchRequest error:nil];

    NSLog(@"%ld", [[DataManager sharedManager].newBackgroundContext countForFetchRequest:[User fetchRequest] error:nil]);
    
    for (User *user in resultArray) {
        NSLog(@"age: %hd sex: %@ weight: %hd", user.age, user.sex, user.weight);
    }
 */

    return YES;
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
     [[DataManager sharedManager] saveContext];
}

@end
