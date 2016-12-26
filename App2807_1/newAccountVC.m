//
//  newAccountVC.m
//  App2807_1
//
//  Created by Kalyani on 18/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "newAccountVC.h"

@interface newAccountVC () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong,nonatomic) NSArray *theData;
@end

@implementation newAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
/*    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    self.pickerTextfield.inputView = picker;
    self.theData = @[@"General Physician",@"Oncology"];
*/
 }
/*
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.theData.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.theData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.pickerTextfield.text = self.theData[row];
    [self.pickerTextfield resignFirstResponder];
    [self.picker setHidden:YES];
}

*/
@end
