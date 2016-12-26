//
//  ProfilePageVC.h
//  App2807_1
//
//  Created by Kalyani on 02/10/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilePageVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *docImage;


@property (weak, nonatomic) IBOutlet UITextField *docNm;
@property (weak, nonatomic) IBOutlet UITextField *mobileNo;
@property (weak, nonatomic) IBOutlet UITextField *dob;
@property (weak, nonatomic) IBOutlet UITextField *sex;

@property (strong, nonatomic) NSDictionary *resData;


@end
