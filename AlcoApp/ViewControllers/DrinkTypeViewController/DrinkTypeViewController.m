//
//  DrinkTypeViewController.m
//  AlcoApp
//
//  Created by Karina on 8/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

#import "DrinkTypeViewController.h"
#import "UIColor+ProjectColors.h"
#import "DataManager.h"
@interface DrinkTypeViewController ()
@property(strong,nonatomic) UIButton *drinkTypeButton;
@property(strong,nonatomic) UIButton *alchoContainerButton;
@property(strong,nonatomic) UIButton *okButton;

@property(strong,nonatomic) UILabel *enterDrinksLabel;

@property(strong,nonatomic) NSString *nameOfDrink;
@property(assign,nonatomic) NSInteger *volume;
@property(assign,nonatomic) NSInteger *persent;

@end

@implementation DrinkTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor primaryColor];
    
    self.enterDrinksLabel=[self setUpEnterLabel];
    [self.view addSubview:self.enterDrinksLabel];
    
    self.drinkTypeButton=[self setUpTypeButton];
    [self.view addSubview:self.drinkTypeButton];
    
    self.okButton=[self setUpOkButton];
    [self.view addSubview:self.okButton];
    
    self.alchoContainerButton=[self setUpContainerButton];
    [self.view addSubview:self.alchoContainerButton];
    
    [self setUpConstraints];
    

    
}

-(UIButton*) setUpTypeButton{
    UIButton *button=[UIButton new];
    [button setTitle:@"Choose drink" forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints=NO;
    [button.widthAnchor constraintEqualToConstant:250].active=YES;
    [button.heightAnchor constraintEqualToConstant:50].active=YES;
    button.backgroundColor = [UIColor accentColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 15;
    [button addTarget:self action:@selector(addTypeAlert) forControlEvents:(UIControlEventTouchUpInside)];
    
    return button;
    
}

- (UIButton*)setUpOkButton{
    UIButton *button=[UIButton new];
    [button setTitle:@"OK" forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints=NO;
    [button.widthAnchor constraintEqualToConstant:60].active=YES;
    [button.heightAnchor constraintEqualToConstant:60].active=YES;
    button.backgroundColor = [UIColor accentColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 30;
    [button addTarget:self action:@selector(addTypeAlert) forControlEvents:(UIControlEventTouchUpInside)];
    
    return button;
    
}

-(UIButton *) setUpContainerButton{
    UIButton *button=[UIButton new];
    [button setTitle:@"Choose amount" forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints=NO;
    [button.widthAnchor constraintEqualToConstant:250].active=YES;
    [button.heightAnchor constraintEqualToConstant:50].active=YES;
    button.backgroundColor = [UIColor accentColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 15;
    [button addTarget:self action:@selector(addContainerAlert) forControlEvents:(UIControlEventTouchUpInside)];
    
    return button;
}

-(UILabel *) setUpEnterLabel{
    UILabel *label=[UILabel new];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth=screenRect.size.width;
    
    label.textAlignment=NSTextAlignmentCenter;
    label.text=@"What did you drink?";
    label.translatesAutoresizingMaskIntoConstraints=NO;
    [NSLayoutConstraint activateConstraints:@[
    [label.widthAnchor constraintEqualToConstant:screenWidth],
    [label.heightAnchor constraintEqualToConstant:90]
    ]];
    return label;
}

-(void) addContainerAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Containers" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
         NSLog(@"Cancel");
     }];
     UIAlertAction *shotAction = [UIAlertAction actionWithTitle:@"Shot(40ml)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         
         
         

  
     }];
     UIAlertAction *glassOfVodkaAction = [UIAlertAction actionWithTitle:@"Class(250ml)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
       
     }];
     
     UIAlertAction *glassOfBeerAction = [UIAlertAction actionWithTitle:@"Glass(500ml)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
     }];
     UIAlertAction *pintAction = [UIAlertAction actionWithTitle:@"Pint(568ml)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
       
     }];
     
     UIAlertAction *largeGlassAction = [UIAlertAction actionWithTitle:@"Glass(1000ml)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
     }];
     UIAlertAction *redWineClassAction = [UIAlertAction actionWithTitle:@"Glass for red wine(160ml)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         [self.alchoContainerButton setTitle:@"Glass for red wine(160ml)" forState:UIControlStateNormal];
     }];
     
     UIAlertAction *whiteWineGlassAction = [UIAlertAction actionWithTitle:@"Glass for white wine(120ml)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         
     }];
     UIAlertAction *cognacGlassAction = [UIAlertAction actionWithTitle:@"Glass for cognac(260ml)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         
     }];
     UIAlertAction *whiskeyGlassAction = [UIAlertAction actionWithTitle:@"Glass for whiskey(250ml)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
       
     }];
    [alertController addAction:cancelAction];
    [alertController addAction:shotAction];
    
    [alertController addAction:glassOfVodkaAction];
    [alertController addAction:glassOfBeerAction];
    [alertController addAction:pintAction];
    [alertController addAction:largeGlassAction];
    [alertController addAction:redWineClassAction];
    [alertController addAction:whiteWineGlassAction];
    [alertController addAction:cognacGlassAction];
    [alertController addAction:whiskeyGlassAction];
    
    [self presentViewController:alertController animated: YES completion: nil];
}

-(void)addTypeAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Drinks" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
         NSLog(@"Cancel");
     }];
     UIAlertAction *ethanolAction = [UIAlertAction actionWithTitle:@"Ethanol(99%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         
     }];
     UIAlertAction *moonshineAction = [UIAlertAction actionWithTitle:@"Moonshine(90%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
       
     }];
     
     UIAlertAction *vodkaAction = [UIAlertAction actionWithTitle:@"Vodka(40%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
     }];
     UIAlertAction *whiskey42Action = [UIAlertAction actionWithTitle:@"Whiskey(42%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         
     }];
     
     UIAlertAction *whiskey40Action = [UIAlertAction actionWithTitle:@"Whiskey(40%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
     }];
     UIAlertAction *cognacAction = [UIAlertAction actionWithTitle:@"Cognac(40%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         
     }];
     
     UIAlertAction *liquorAction = [UIAlertAction actionWithTitle:@"Liquour(20%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         
     }];
     UIAlertAction *redWineAction = [UIAlertAction actionWithTitle:@"Red Wine(21%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         
     }];
     UIAlertAction *fruitWineAction = [UIAlertAction actionWithTitle:@"Fruit Wine(20%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
       
     }];
     UIAlertAction *whiteWineAction = [UIAlertAction actionWithTitle:@"White Wine(12%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         
     }];
    UIAlertAction *redWine11Action = [UIAlertAction actionWithTitle:@"Red Wine(11%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
    }];
     UIAlertAction *champagneAction = [UIAlertAction actionWithTitle:@"Red Wine(12%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
     }];
     UIAlertAction *jinnTonikAction = [UIAlertAction actionWithTitle:@"Jinn Tonik(8%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
     }];
     
     UIAlertAction *whiteWine8Action = [UIAlertAction actionWithTitle:@"White Wine(8%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
     }];
     UIAlertAction *darkBeerAction = [UIAlertAction actionWithTitle:@"Dark Beer(8%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         
     }];
     UIAlertAction *beerAction = [UIAlertAction actionWithTitle:@"Beer(6%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
     }];
     UIAlertAction *darkBeer5Action = [UIAlertAction actionWithTitle:@"Dark Beer(5%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
       
     }];
     UIAlertAction *beer4Action = [UIAlertAction actionWithTitle:@"Beer(4%)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         
     }];
     
     [alertController addAction:cancelAction];
     [alertController addAction:ethanolAction];
     [alertController addAction:moonshineAction];
     [alertController addAction:vodkaAction];
     [alertController addAction:whiskey42Action];
     [alertController addAction:whiskey40Action];
     [alertController addAction:cognacAction];
     [alertController addAction:liquorAction];
     [alertController addAction:redWine11Action];
     [alertController addAction:fruitWineAction];
     [alertController addAction:whiteWineAction];
     [alertController addAction:redWineAction];
     
     [alertController addAction:champagneAction];
     [alertController addAction:jinnTonikAction];
     [alertController addAction:whiteWine8Action];
     [alertController addAction:darkBeerAction];
     [alertController addAction:beerAction];
     [alertController addAction:darkBeer5Action];
     [alertController addAction:beer4Action];
     
     [self presentViewController:alertController animated: YES completion: nil];
}

-(void) setUpConstraints{
    self.drinkTypeButton.translatesAutoresizingMaskIntoConstraints=NO;
    self.alchoContainerButton.translatesAutoresizingMaskIntoConstraints=NO;
    
    [NSLayoutConstraint activateConstraints:@[
    [self.enterDrinksLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100],
    [self.enterDrinksLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor ],
    [self.drinkTypeButton.topAnchor constraintEqualToAnchor:self.enterDrinksLabel.bottomAnchor constant:100],
    
    [self.drinkTypeButton.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor constant:0],
    [self.alchoContainerButton.topAnchor constraintEqualToAnchor:self.drinkTypeButton.bottomAnchor constant:100],
    [self.alchoContainerButton.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor constant:0],
    [self.okButton.centerXAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.trailingAnchor constant:-60],
    [self.okButton.centerYAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.bottomAnchor constant:-60]
    ]];
    
}

@end
