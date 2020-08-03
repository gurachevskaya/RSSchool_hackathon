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

@interface GeneralInformationViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic, assign) NSTimeInterval timeProgress;

@property (nonatomic, strong) NSTimer *timer;

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DrinkTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     DrinkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"History";
}





#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    // Background color
    view.tintColor = [UIColor whiteColor];

    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];

    // Another way to set the background color
    // Note: does not preserve gradient effect of original header
    // header.contentView.backgroundColor = [UIColor blackColor];
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
//    [self.timerStackView setTitle:[NSString timeFormatted:self.timeProgress]];
//    if (self.timeProgress == [self.dataSource currentTrack].duration) {
//    }
}

@end
