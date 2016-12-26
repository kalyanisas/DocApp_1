//
//  URLConstants.m
//  App2807_1
//
//  Created by Kalyani on 23/10/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "URLConstants.h"

@implementation URLConstants

NSString * const MY_PATIENTS = @"http://www.konnect.olivo.in//api/account/v1.0/mypatients/";
NSString * const ADD_PATIENT = @"http://www.konnect.olivo.in//api/add_patient/";
NSString * const LOGIN = @"http://konnect.olivo.in/api/account/v1.0/login_test";
NSString * const READ_MSGS = @"http://www.konnect.olivo.in//api/treatment/v1.0/questions/";
NSString * const PROFILE_DATA = @"http://www.konnect.olivo.in//api/account/v1.0/personal/";
NSString * const DOCTOR_VISITS = @"http://www.konnect.olivo.in//api/treatment/v1.0/doctor_visits/";

int  const USER = 0;
int  const PASS = 1;
int const TOKEN = 2;

@end
