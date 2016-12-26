//
//  HomepageVC.h
//  App2807_1
//
//  Created by Kalyani on 02/10/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomepageVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)loginButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *createNewUserLabel;

@property (weak, nonatomic) IBOutlet UIButton *createNewUserButonLabel;

//- (IBAction)createNewUserButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *loginView;


@end
