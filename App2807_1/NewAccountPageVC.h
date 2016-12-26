//
//  NewAccountPageVC.h
//  App2807_1
//
//  Created by Kalyani on 18/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAccountPageVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *spcializationLabel;
- (IBAction)specializationButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *specializationPicker;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *registrationNoField;
//- (IBAction)createAccountButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registrationDateLabel;
- (IBAction)registrationDateButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *registrationDatePicker;
@property (weak, nonatomic) IBOutlet UIView *myDatePickerView;

@end
