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

@interface GeneralInformationViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation GeneralInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addButton.layer.cornerRadius = 25.0;
    
    UIBarButtonItem *preferencesButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"adjust"] style:UIBarButtonItemStylePlain target:self action:@selector(openPreferences)];
    preferencesButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = preferencesButton;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
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

#pragma mark - Actions

- (void)openPreferences {
    StartViewController *preferences = [[StartViewController alloc] initWithType:Preferences];
    [self presentViewController:preferences animated:YES completion:nil];

}

@end
