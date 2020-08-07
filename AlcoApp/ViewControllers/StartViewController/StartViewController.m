//
//  StartViewController.m
//  AlcoApp
//
//  Created by Karina on 8/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "StartViewController.h"
#import "GeneralInformationViewController.h"
#import "DataManager.h"
#import "UIColor+ProjectColors.h"
#import "User+CoreDataClass.h"

static NSString *NAME_CONST=@"Alchometr";
static NSString *FONT_CONST=@"Gauge-Regular";
static CGFloat TEXT_FIELD_HEIGHT_CONST=(CGFloat)50;
static CGFloat TEXT_FIELD_WIDTH_CONST=(CGFloat)350;


@interface StartViewController ()

@property (strong, nonatomic) UITextField *ageTextField;
@property (strong, nonatomic) UITextField *weightTextField;
@property (strong, nonatomic) UISegmentedControl *sexSegmentControl;
@property (strong, nonatomic) UIButton *nextButton;
@property(assign,nonatomic) NSString *weightInt;
@property(assign,nonatomic) NSInteger *ageInt;
@property(strong,nonatomic) UILabel *helloLabel;
@property(strong,nonatomic) UILabel *appNameLabel;


@end

@interface GreetingViewController : StartViewController

@end

@interface PreferencesViewController : StartViewController

@end

@implementation StartViewController

//Ensuring below that the configureText and nextButtonTapped method must be implemented by the private subclasses

-(void)configureText{
    [NSException raise:NSInternalInconsistencyException
    format:@"You have not implemented %@ in %@", NSStringFromSelector(_cmd), NSStringFromClass([self class])];
}

- (void)nextButtonTapped {
    [NSException raise:NSInternalInconsistencyException
      format:@"You have not implemented %@ in %@", NSStringFromSelector(_cmd), NSStringFromClass([self class])];
}

- (instancetype)initWithType:(ViewControllerType)type {
    self = nil;
    if (type == Greeting) {
        self = [[GreetingViewController alloc] init];
    } else if (type == Preferences) {
        self = [[PreferencesViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor primaryColor];
    
    self.helloLabel=[self setUpHelloLabel];
    self.appNameLabel = [self setUpAppNameLabel];
    [self.appNameLabel setHidden:YES];
    
    [self.view addSubview:self.helloLabel];
    [self.view addSubview:self.appNameLabel];
    
    UIStackView *stackView=[self setUpStackView];
    [self.view addSubview:stackView];
    
    self.nextButton=[self setUpNextButton];
    [self.view addSubview:self.nextButton];
    
    [self creatingConstraints:self.helloLabel andStackView:stackView andNextButton:self.nextButton];
    [self configureText];
    
    [self hideWhenTappedAround];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}



-(UILabel* )setUpHelloLabel{
    UILabel *helloLabel=[UILabel new];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth=screenRect.size.width;
    helloLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:20];
    
    helloLabel.textAlignment=NSTextAlignmentCenter;
    helloLabel.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
        [helloLabel.widthAnchor constraintEqualToConstant:screenWidth],
    ]];
    return helloLabel;
}

- (UILabel *)setUpAppNameLabel {
    UILabel *appName=[UILabel new];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth=screenRect.size.width;
    
    appName.textAlignment=NSTextAlignmentCenter;
    appName.font=[UIFont fontWithName:FONT_CONST size:45];
    appName.text=NAME_CONST;
    appName.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
        [appName.widthAnchor constraintEqualToConstant:screenWidth],
    ]];
    return appName;
}

-(UIStackView *)setUpStackView{
    UIStackView *stackView=[UIStackView new];
    stackView.axis=UILayoutConstraintAxisVertical;
    stackView.alignment=UIStackViewAlignmentCenter;
    stackView.distribution=UIStackViewDistributionEqualSpacing;
    stackView.spacing=35;
    
    self.ageTextField=[self setUpAgeTextField];
    self.weightTextField=[self setUpWeightTextField];
    self.sexSegmentControl=[self setUpSexSegmentControl];
    
    [stackView addArrangedSubview:self.ageTextField];
    [stackView addArrangedSubview:self.weightTextField];
    [stackView addArrangedSubview:self.sexSegmentControl];
    return stackView;
}

-(UITextField *) setUpAgeTextField{
    UITextField *ageTextField=[UITextField new];
    
    
    ageTextField.borderStyle = UITextBorderStyleRoundedRect;
    ageTextField.clearsOnBeginEditing = YES;
    ageTextField.placeholder = @"Enter your age";
    
    
    ageTextField.keyboardType =UIKeyboardTypeNumberPad;
    
    ageTextField.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
        [ageTextField.widthAnchor constraintEqualToConstant:TEXT_FIELD_WIDTH_CONST],
        [ageTextField.heightAnchor constraintEqualToConstant:TEXT_FIELD_HEIGHT_CONST]
    ]];
    
    return ageTextField;
}


-(UITextField *) setUpWeightTextField{
    
    UITextField *weightTextField=[UITextField new];
    
    weightTextField.borderStyle = UITextBorderStyleRoundedRect;
    weightTextField.clearsOnBeginEditing = YES;
    weightTextField.placeholder = @"Enter your weight";
    weightTextField.keyboardType =UIKeyboardTypeNumberPad;
    
    
    weightTextField.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
    [weightTextField.widthAnchor constraintEqualToConstant:TEXT_FIELD_WIDTH_CONST],
    [weightTextField.heightAnchor constraintEqualToConstant:TEXT_FIELD_HEIGHT_CONST]
    ]];
 
    return weightTextField;
    
}
-(UISegmentedControl *) setUpSexSegmentControl{
    
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"Male",@"Female"]];
    
    segmentControl.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
        [segmentControl.widthAnchor constraintEqualToConstant:TEXT_FIELD_WIDTH_CONST],
       [segmentControl.heightAnchor constraintEqualToConstant:TEXT_FIELD_HEIGHT_CONST]
    ]];
    segmentControl.layer.cornerRadius=70;
    
    segmentControl.selectedSegmentIndex=0;
    
    return segmentControl;
}

-(UIButton *)setUpNextButton{
    UIButton *nextButton=[UIButton new];
    nextButton.translatesAutoresizingMaskIntoConstraints=NO;
    [nextButton.widthAnchor constraintEqualToConstant:150].active=YES;
    [nextButton.heightAnchor constraintEqualToConstant:50].active=YES;
    nextButton.backgroundColor = [UIColor accentColor];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextButton.layer.cornerRadius = 20;
    
    //nextButton.titleLabel.font=[UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    
    [nextButton addTarget:self action:@selector(nextButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    return nextButton;
}

-(void)creatingConstraints:(UILabel *) helloLabel andStackView:(UIStackView *)stackView andNextButton: (UIButton *) nextButton{
    self.appNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.appNameLabel.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.appNameLabel.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.appNameLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20]
    ]];
    helloLabel.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
        [helloLabel.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [helloLabel.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [helloLabel.topAnchor constraintEqualToAnchor:self.appNameLabel.bottomAnchor constant:50]
    ]];
    stackView.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
        [stackView.topAnchor constraintEqualToAnchor:helloLabel.bottomAnchor constant:10],
        [stackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [stackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor]
    ]];
    nextButton.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
        [nextButton.topAnchor constraintGreaterThanOrEqualToAnchor: stackView.bottomAnchor],
        [nextButton.trailingAnchor constraintEqualToAnchor:self.ageTextField.trailingAnchor],
        [nextButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-40]
    ]];
}

-(void)hideWhenTappedAround{
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.view addGestureRecognizer:gesture];
}


-(void)hide{
    [self.view endEditing:YES];
}


- (void)showAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Please, enter your age and weight"
                                                            message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showAgeAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You are too young for this stuff, honey"
                                                            message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end


@implementation GreetingViewController

- (void)configureText {
    [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
    self.helloLabel.text=@"Hello! ";
}


- (void)nextButtonTapped {
    NSString *sex =  [self.sexSegmentControl titleForSegmentAtIndex:self.sexSegmentControl.selectedSegmentIndex];
    NSInteger age = [self.ageTextField.text intValue];
    NSInteger weight =[self.weightTextField.text intValue];
    
    if (age != 0 && weight != 0) {
        if (age < 18) {
            [self showAgeAlert];
        } else {
        [[DataManager sharedManager] configureUserWithAge:age sex:sex weight:weight];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[GeneralInformationViewController new]];
          navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
          [self presentViewController:navigationController animated:YES completion:nil];
        }
    } else {
        [self showAlert];
    }
}


@end


@implementation PreferencesViewController

- (void)configureText {
    [self.nextButton setTitle:@"Update" forState:UIControlStateNormal];
    self.helloLabel.text=@"Info about me:";
    
    NSManagedObjectContext *viewContext = [DataManager sharedManager].newBackgroundContext;
    NSFetchRequest *fetchRequest = [User fetchRequest];
    NSArray *resultArray = [viewContext executeFetchRequest:fetchRequest error:nil];
    
    if (resultArray.count != 0) {
        User *user = [resultArray firstObject];
        self.weightTextField.placeholder = [NSString stringWithFormat:@"%hd kg", user.weight];
        self.ageTextField.placeholder = [NSString stringWithFormat:@"%hd ages", user.age];
    }
}

- (void)nextButtonTapped {
    
    NSString *sex =  [self.sexSegmentControl titleForSegmentAtIndex:self.sexSegmentControl.selectedSegmentIndex];
    NSInteger age = [self.ageTextField.text intValue];
    NSInteger weight =[self.weightTextField.text intValue];
    
    if (age != 0 && weight != 0) {
        if (age < 18) {
            [self showAgeAlert];
        } else {
            [[DataManager sharedManager] configureUserWithAge:age sex:sex weight:weight];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        [self showAlert];
    }
}



@end
