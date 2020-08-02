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

static NSString *NAME_CONST=@"Alchometr";
static NSString *FONT_CONST=@"AmaticSC-Regular";
static CGFloat TEXT_FIELD_HEIGHT_CONST=(CGFloat)50;
static CGFloat TEXT_FIELD_WIDTH_CONST=(CGFloat)350;


@interface StartViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *ageTextField;
@property (strong, nonatomic) UITextField *weightTextField;
@property (strong, nonatomic) UISegmentedControl *sexSegmentControl;
@property (strong, nonatomic) UIButton *nextButton;
@property(strong,nonatomic) UILabel *helloLabel;
@property(strong,nonatomic) UIStackView *stackView;

@end

@interface GreetingViewController : StartViewController

@end

@interface PreferencesViewController : StartViewController

@end

@implementation StartViewController

//Ensuring below that the startLoading and cellForRowAtIndexPath method must be implemented by the private subclasses
- (void)configureButtonText {
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
    self.view.backgroundColor = [UIColor systemPinkColor];
    
    self.helloLabel=[self setUpHelloLabel];
    [self.view addSubview:self.helloLabel];
    
    self.stackView=[self setUpStackView];
    [self.view addSubview:self.stackView];
    
    self.nextButton=[self setUpNextButton];
    [self.view addSubview:self.nextButton];
    
 [self creatingConstraintsVertical:self.helloLabel andStackView:self.stackView andNextButton:self.nextButton];
    [self configureButtonText];
    
    [self hideWhenTappedAround];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

#pragma mark - SetupElements

-(UILabel* )setUpHelloLabel{
    UILabel *helloLabel=[UILabel new];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth=screenRect.size.width;
    
    helloLabel.textAlignment=NSTextAlignmentCenter;
    helloLabel.font=[UIFont fontWithName:FONT_CONST size:55];
    helloLabel.text=NAME_CONST;
    helloLabel.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
    [helloLabel.widthAnchor constraintEqualToConstant:screenWidth],
    ]];
    return helloLabel;
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
    ageTextField.text = @"Enter your age";
    
    ageTextField.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
    [ageTextField.widthAnchor constraintEqualToConstant:TEXT_FIELD_WIDTH_CONST],
    [ageTextField.heightAnchor constraintEqualToConstant:TEXT_FIELD_HEIGHT_CONST]
    ]];
    
    return ageTextField;
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
    nextButton.backgroundColor = [UIColor yellowColor];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextButton.layer.cornerRadius = 20;
    
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    //nextButton.titleLabel.font=[UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    
    [nextButton addTarget:self action:@selector(nextButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    
    return nextButton;
}

-(UITextField *) setUpWeightTextField{
    
    UITextField *weightTextField=[UITextField new];
    
    weightTextField.borderStyle = UITextBorderStyleRoundedRect;
    weightTextField.clearsOnBeginEditing = YES;
    weightTextField.text = @"Enter your weight";
    
    weightTextField.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
    [weightTextField.widthAnchor constraintEqualToConstant:TEXT_FIELD_WIDTH_CONST],
    [weightTextField.heightAnchor constraintEqualToConstant:TEXT_FIELD_HEIGHT_CONST]
    
    ]];
    
    return weightTextField;
    
}
#pragma mark - CreatingOfConstraints

-(void)creatingConstraintsVertical:(UILabel *) helloLabel andStackView:(UIStackView *)stackView andNextButton: (UIButton *) nextButton{
    helloLabel.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
        [helloLabel.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [helloLabel.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [helloLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:50]
    ]];
    stackView.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
    [stackView.topAnchor constraintEqualToAnchor:helloLabel.bottomAnchor constant:90],
    [stackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
    [stackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor]
    ]];
    nextButton.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
    [nextButton.topAnchor constraintLessThanOrEqualToSystemSpacingBelowAnchor:stackView.bottomAnchor multiplier:10],
    [nextButton.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-40]
    ]];
}

-(void)creatingConstraintsHorizontal:(UILabel *) helloLabel andStackView:(UIStackView *)stackView andNextButton: (UIButton *) nextButton{
    helloLabel.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
        [helloLabel.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [helloLabel.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [helloLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:0]
    ]];
    stackView.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
    [stackView.topAnchor constraintEqualToAnchor:helloLabel.bottomAnchor constant:30],
    [stackView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
    [stackView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor]
    ]];
    nextButton.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
    [nextButton.topAnchor constraintLessThanOrEqualToSystemSpacingBelowAnchor:stackView.bottomAnchor multiplier:10],
    [nextButton.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-40]
    ]];
}


- (void)nextButtonTaped {
    
    NSString *sex =  [self.sexSegmentControl titleForSegmentAtIndex:self.sexSegmentControl.selectedSegmentIndex];
    
    //get values from textFields
    NSInteger age = 20;
    NSInteger weight = 55;
    
    [[DataManager sharedManager] configureUserWithAge:age sex:sex weight:weight];
    
    [self.navigationController pushViewController:[GeneralInformationViewController new] animated:YES];
 


    
    
}

#pragma mark - HideKeyBoard

 -(void)hideWhenTappedAround {
     UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
     
     [self.view addGestureRecognizer:gesture];
 }
-(void)hide{
    [self.view endEditing:YES];
    
}

@end


@implementation GreetingViewController

- (void)configureButtonText {
    [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
}

@end


@implementation PreferencesViewController

- (void)configureButtonText {
    [self.nextButton setTitle:@"Update" forState:UIControlStateNormal];
}

@end
