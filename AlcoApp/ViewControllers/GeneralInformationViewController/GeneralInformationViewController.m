//
//  GeneralInformationViewController.m
//  AlcoApp
//
//  Created by Karina on 8/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "GeneralInformationViewController.h"
#import "DrinkTableViewCell.h"
#import "StartViewController.h"
#import "UIColor+ProjectColors.h"

#import "DrinkTypeViewController.h"

#import "NSString+TimeFormatter.h"
#import "DataManager.h"
#import "User+CoreDataProperties.h"
#import "Drink+CoreDataProperties.h"


@interface GeneralInformationViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *promillesLabel;

@property (nonatomic, assign) NSTimeInterval timeProgress;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic) NSFetchedResultsController *frc;

@end

@implementation GeneralInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.addButton.layer.cornerRadius = self.addButton.bounds.size.width / 2;
    [self.addButton addTarget:self action:@selector(tapIntoAddButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *preferencesButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"adjust"] style:UIBarButtonItemStylePlain target:self action:@selector(openPreferences)];
    preferencesButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = preferencesButton;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor primaryDarkColor];
    

    [self configureAppearance];
    self.tableView.allowsSelection = NO;
           
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:[Drink fetchRequest] managedObjectContext:[[DataManager sharedManager]viewContext] sectionNameKeyPath:nil cacheName:nil];
    self.frc.delegate = self;


    [self.tableView registerNib:[UINib nibWithNibName:@"DrinkTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    float promilles = [self calculatePromilles];
    self.timeProgress = promilles/0.15 * 60 * 60;
    [self startTimer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.frc performFetch:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.frc.fetchedObjects.count;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     DrinkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    [cell configureWithDrink:self.frc.fetchedObjects[indexPath.row]];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"History";
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    // Background color
    view.tintColor = [UIColor primaryDarkColor];
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSManagedObjectContext *context = [DataManager sharedManager].viewContext;
        [context performBlockAndWait:^{
        Drink *drink = [[[Drink fetchRequest] execute:nil] objectAtIndex: indexPath.row];
        [context deleteObject: drink];
        }];
        [context save:nil];
        completionHandler(YES);
    }];
    deleteAction.backgroundColor = [UIColor accentColor];
    return [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
}



#pragma mark - Fetched Results Controller Delegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            self.timeProgress = [self calculatePromilles]/0.15 * 60 * 60;
            [self stopTimer];
            [self startTimer];

            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            self.timeProgress = [self calculatePromilles]/0.15 * 60 * 60;
            [self stopTimer];

            [self startTimer];

            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            self.timeProgress = [self calculatePromilles]/0.15 * 60 * 60;
            [self stopTimer];

            [self startTimer];
            break;
            
        default:
            break;
    }
}



#pragma mark - UI Setup

- (void)configureAppearance {
    self.addButton.layer.cornerRadius = self.addButton.bounds.size.width / 2;
    UIBarButtonItem *preferencesButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"adjust"] style:UIBarButtonItemStylePlain target:self action:@selector(openPreferences)];
    preferencesButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = preferencesButton;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor primaryDarkColor];
}


#pragma mark - Actions

- (void)openPreferences {
    StartViewController *preferences = [[StartViewController alloc] initWithType:Preferences];
    [self presentViewController:preferences animated:YES completion:nil];

}
-(void)tapIntoAddButton{
    
    DrinkTypeViewController *drinkTypeViewController=[DrinkTypeViewController new];
    
    [self.navigationController pushViewController:drinkTypeViewController animated:YES];

}

- (IBAction)addButtonTapped:(id)sender {
    [[DataManager sharedManager] addDrink:@"Wine" alcoholPercent:12 volume:200];
    
    NSLog(@"%ld", [[DataManager sharedManager].newBackgroundContext countForFetchRequest:[Drink fetchRequest] error:nil]);
}


#pragma mark - Timer

- (void)startTimer {
    if (self.timer) { return; }
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}


#pragma mark - Handlers

- (void)handleTimer {
    self.timeProgress -= 1.0;
    
    if (self.timeProgress <= 0) {
           [self stopTimer];
           self.timerLabel.text = @"You are sober!";
       }
    
    [self.timerLabel setText:[NSString timeFormatted:self.timeProgress]];

    self.promillesLabel.text = [NSString stringWithFormat:@"There is %.2f of alcohol in your blood", [self calculatePromilles]];
    [self updateStateLabelText];

}

- (Behaviour)getBehaviourFromPromilles:(float)promilles {
    if (promilles <= 0.2) return SOBER;
    else if (promilles <= 0.3) return ALMOST_NORMAL;
    else if (promilles <= 0.6) return EUPHORIC;
    else if (promilles <= 1.0) return DISINHIBITIONS;
    else if (promilles <= 2.0) return EXPRESSIVENESS;
    else if (promilles <= 3.0) return STUPOR;
    else if (promilles <= 4.0) return UNCONSCIOUS;
    else if (promilles <= 5.0) return BLACKOUT;
    else return DEAD;
}

- (void)updateStateLabelText {
    Behaviour behaviour = [self getBehaviourFromPromilles:[self calculatePromilles]];
    switch (behaviour) {
        case SOBER:
            self.stateLabel.text = @"You are completely fine";
            [self stopTimer];
            self.timerLabel.text = @"You are sober!";
            break;
        case ALMOST_NORMAL:
            self.stateLabel.text = @"You feel normal, slightly relaxed";
            break;
        case EUPHORIC:
            self.stateLabel.text = @"You are euphoric, completely relaxed";
            break;
        case DISINHIBITIONS:
            self.stateLabel.text = @"You have trouble moving around";
            break;
        case EXPRESSIVENESS:
            self.stateLabel.text = @"You have an urge to talk, Beware!";
            break;
        case STUPOR:
            self.stateLabel.text = @"You have trouble thinking";
            break;
        case UNCONSCIOUS:
            self.stateLabel.text = @"You are unconscious";
            break;
        case BLACKOUT:
            self.stateLabel.text = @"You won't remember shit, almost dead";
            break;
        case DEAD:
            self.stateLabel.text = @"You died, Congrats!";
            [self stopTimer];
            self.timerLabel.text = @"00:00";
            break;
    }
}

- (float)calculatePromilles {
    //c = A/(m * r), where A - amount of ethanol in ml, m - weight in kg, r - Widmark coefficient
    //  -0.15/60 - every minute
    
    NSManagedObjectContext *context = [DataManager sharedManager].newBackgroundContext;
    NSFetchRequest *userFetchRequest = [User fetchRequest];
    NSFetchRequest *drinkFetchRequest = [Drink fetchRequest];
    
    NSArray *userArray = [context executeFetchRequest:userFetchRequest error:nil];
    User *user = [userArray firstObject];
    NSInteger m = user.weight;
    NSString *sex = user.sex;
    
    float r;
         if ([sex isEqualToString:@"Male"]) {
             r = 0.7;
         } else {
             r = 0.6;
         }
    NSArray *drinksArray = [context executeFetchRequest:drinkFetchRequest error:nil];
    float promilles = 0.0;
    for (Drink *drink in drinksArray) {
        NSDate *currentDate = [NSDate date];
        NSDate *dateOfDrink = drink.date;
        NSTimeInterval secondsBetween = [currentDate timeIntervalSinceDate:dateOfDrink];
        float minutesBetween = secondsBetween / 60;
        NSInteger ethanol = (drink.volume * drink.alcoholPercent / 100);
        float prom = ethanol / (m * r) - 0.15/60 * minutesBetween;

        if (prom > 0) {
            promilles = (promilles + prom);
        }
    }
    return promilles;
}


@end
