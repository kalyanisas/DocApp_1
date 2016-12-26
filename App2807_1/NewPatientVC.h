//
//  NewPatientViewController.h
//  App2807_1
//
//  Created by Kalyani on 28/07/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewPatientVC;
@protocol NewPatientVCDelegate

-(void)dismissAddContactVC;
-(void )addPatientName:(NSString *)name phone:(NSString *)phone;

@end


@interface NewPatientVC : UIViewController

@property (nonatomic, weak) id <NewPatientVCDelegate> delegate;
- (IBAction)addNewPatientButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;


@end
