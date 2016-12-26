//
//  NewAccountPageVC.m
//  App2807_1
//
//  Created by Kalyani on 18/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//
#define SPECIALIZATION_PICKER 0
#define REGISTRATION_DATE_PICKER 1

#import "NewAccountPageVC.h"

@interface NewAccountPageVC () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong,nonatomic) NSArray *docSpecialization;

@end

@implementation NewAccountPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.specializationPicker setHidden:YES];
    [self.registrationDatePicker setHidden:YES];
    [self.myDatePickerView setHidden:YES];

    [self.spcializationLabel setTitle:@"Choose Specialization" forState:UIControlStateNormal];

   self.docSpecialization = @[@"General Physician",@"Oncology"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)specializationButtonPressed:(id)sender {
    
    [self.view endEditing:YES];
    [self.registrationDatePicker setHidden:YES];
    self.specializationPicker.backgroundColor = [UIColor lightGrayColor];
    [self.specializationPicker setHidden:NO];
    
    

}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView.tag ==  SPECIALIZATION_PICKER )
        return self.docSpecialization.count;
    return 2;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if(pickerView.tag ==  SPECIALIZATION_PICKER )
        return  1;
    return 1;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if(pickerView.tag ==  SPECIALIZATION_PICKER )
        return self.docSpecialization[row];
    return 0;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if(pickerView.tag ==  SPECIALIZATION_PICKER ) {
        [self.spcializationLabel setTitle:self.docSpecialization[row] forState:UIControlStateNormal];
        [self.spcializationLabel resignFirstResponder];
        [self.specializationPicker setHidden:YES];
    }
    if(pickerView.tag ==  REGISTRATION_DATE_PICKER ) {
      
        [self.registrationDateLabel resignFirstResponder];
        [self.registrationDatePicker setHidden:YES];
    }

}

- (IBAction)registrationDateButtonPressed:(id)sender{
    
    [self.view endEditing:YES];
    [self.registrationDatePicker addTarget:self action:@selector(dateChanged:)
                          forControlEvents:UIControlEventValueChanged];
    
    self.registrationDatePicker.backgroundColor = [UIColor lightGrayColor];
    [self.myDatePickerView setHidden:NO];

    [self.registrationDatePicker setHidden:NO];


}



- (void) dateChanged:(id)sender{
    
    NSDate *regDt = self.registrationDatePicker.date;
    NSDateFormatter *dtFormatter = [[NSDateFormatter alloc]init];
    [dtFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [dtFormatter stringFromDate:regDt];
    [self.registrationDateLabel setTitle:stringFromDate forState:UIControlStateNormal];
    
    [self.registrationDateLabel resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self.registrationDatePicker setHidden:YES];

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];

    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
   [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}


- (UIInterfaceOrientationMask )supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
