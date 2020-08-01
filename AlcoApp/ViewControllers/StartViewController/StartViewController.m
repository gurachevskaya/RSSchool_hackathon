//
//  StartViewController.m
//  AlcoApp
//
//  Created by Karina on 8/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "StartViewController.h"

static NSString *NAME_CONST=@"Alchometr";
static NSString *FONT_CONST=@"AmaticSC-Regular";
static CGFloat TEXT_FIELD_HEIGHT_CONST=(CGFloat)50;
static CGFloat TEXT_FIELD_WIDTH_CONST=(CGFloat)350;


@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemPinkColor];
    
    UILabel *helloLabel=[self setUpHelloLabel];
    [self.view addSubview:helloLabel];
    
    UIStackView *stackView=[self setUpStackView];
    [self.view addSubview:stackView];
    
    UIButton *nextButton=[self setUpNextButton];
    [self.view addSubview:nextButton];
    
    [self creatingConstraints:helloLabel andStackView:stackView andNextButton:nextButton];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}



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
    //[helloLabel.heightAnchor constraintEqualToConstant:90]
    ]];
    return helloLabel;
}

-(UIStackView *)setUpStackView{
    UIStackView *stackView=[UIStackView new];
    stackView.axis=UILayoutConstraintAxisVertical;
    stackView.alignment=UIStackViewAlignmentCenter;
    stackView.distribution=UIStackViewDistributionEqualSpacing;
    stackView.spacing=35;
    
    UITextField *ageTextField=[self setUpAgeTextField];
    UITextField *weightTextField=[self setUpWeightTextField];
    UISegmentedControl *sexSegmentControl=[self setUpSexSegmentControl];
    
    
    
    [stackView addArrangedSubview:ageTextField];
    [stackView addArrangedSubview:weightTextField];
    [stackView addArrangedSubview:sexSegmentControl];
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
-(UISegmentedControl *) setUpSexSegmentControl{
    
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"Male",@"Female"]];
    
    segmentControl.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
        [segmentControl.widthAnchor constraintEqualToConstant:TEXT_FIELD_WIDTH_CONST],
       [segmentControl.heightAnchor constraintEqualToConstant:TEXT_FIELD_HEIGHT_CONST]
    ]];
    segmentControl.layer.cornerRadius=70;
    
    segmentControl.selectedSegmentIndex=0;
    [segmentControl addTarget:self action:@selector(segmentControlValueChanded:) forControlEvents:UIControlEventValueChanged];
    return segmentControl;
}
-(void) segmentControlValueChanded:(UISegmentedControl *) segmentControl{
    if(segmentControl.selectedSegmentIndex==0){
        //then male
    }
    else{
        //female
    }
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
-(void)creatingConstraints:(UILabel *) helloLabel andStackView:(UIStackView *)stackView andNextButton: (UIButton *) nextButton{
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
    [nextButton.topAnchor constraintEqualToAnchor:stackView.bottomAnchor constant:200],
    [nextButton.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-40]
    ]];
}


@end

