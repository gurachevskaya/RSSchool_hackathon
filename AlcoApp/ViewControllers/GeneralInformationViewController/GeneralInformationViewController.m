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
#import "NSString+TimeFormatter.h"

@interface GeneralInformationViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *promillesLabel;

@property (nonatomic, assign) NSTimeInterval timeProgress;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation GeneralInformationViewController

static float promilles = 0.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addButton.layer.cornerRadius = self.addButton.bounds.size.width / 2;
    
    UIBarButtonItem *preferencesButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"adjust"] style:UIBarButtonItemStylePlain target:self action:@selector(openPreferences)];
    preferencesButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = preferencesButton;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor primaryDarkColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DrinkTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    self.promillesLabel.text = [NSString stringWithFormat:@"There is %g of alcohol in your blood", promilles];
    
    [self updateStateLabelText];
//    self.timeProgress = 
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
    view.tintColor = [UIColor primaryDarkColor];

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
    [self.timerLabel setText:[NSString timeFormatted:self.timeProgress]];
    if (self.timeProgress == 0) {
        
    }
}

- (Behaviour)getBehaviourFromPromilles:(float)promilles {
    if (promilles == 0) return SOBER;
    else if (promilles <= 0.2) return ALMOST_NORMAL;
    else if (promilles <= 0.3) return EUPHORIC;
    else if (promilles <= 0.6) return DISINHIBITIONS;
    else if (promilles <= 1.0) return EXPRESSIVENESS;
    else if (promilles <= 2.0) return STUPOR;
    else if (promilles <= 3.0) return UNCONSCIOUS;
    else if (promilles <= 4.0) return BLACKOUT;
    else return DEAD;
}

- (void)updateStateLabelText {
    Behaviour behaviour = [self getBehaviourFromPromilles:promilles];
    switch (behaviour) {
        case SOBER:
            self.stateLabel.text = @"You are completely fine";
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
            break;
    }
}

@end
