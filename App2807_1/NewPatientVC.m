//
//  NewPatientViewController.m
//  App2807_1
//
//  Created by Kalyani on 28/07/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "NewPatientVC.h"

@interface NewPatientVC () <UITextFieldDelegate>


@end

@implementation NewPatientVC

- (void)viewDidLoad {
     [super viewDidLoad];
    
    [self.nameField setDelegate:self];
    [self.phoneField setDelegate:self];
}

-(void) viewWillAppear:(BOOL)animated{
    
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];

    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
}

- (UIInterfaceOrientationMask )supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (IBAction)addNewPatientButton:(UIButton *)sender {
    [self.delegate addPatientName:self.nameField.text phone:self.phoneField.text];

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}




@end
