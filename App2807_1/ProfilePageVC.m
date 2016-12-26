//
//  ProfilePageVC.m
//  App2807_1
//
//  Created by Kalyani on 02/10/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "ProfilePageVC.h"
#import "URLConstants.h"
#import "serverData.h"

#import "AFNetworking.h"


@interface ProfilePageVC () <serverDataDelegate>

@property (strong, nonatomic) NSMutableArray *theTokenLocal;

@end

@implementation ProfilePageVC 

-(NSMutableArray *) theTokenLocal
{
    if(!_theTokenLocal)
    {
        _theTokenLocal = [[NSMutableArray alloc]init];
    }
    return _theTokenLocal;
}

-(NSDictionary *) resData
{
    if(!_resData)
    {
        _resData = [[NSDictionary alloc]init];
    }
    return _resData;
}

- (void)viewDidLoad {
    
    serverData *serverO= [serverData new];
    [self.theTokenLocal addObjectsFromArray: [serverO getToken]];
    self.theTokenLocal[USER] =  @"d_onco@onco.com";
    serverO.delegate = self;
    [serverO getServerData : @"GET" urlString: PROFILE_DATA userName:self.theTokenLocal[USER] password: self.theTokenLocal[PASS] params:nil ];


    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated
{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (UIInterfaceOrientationMask )supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(void) alertMsgWithButtons : (NSString *)title AndMsg : (NSString *) message {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* OkButton = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self.navigationController popToRootViewControllerAnimated:YES];
                               }];
    
    [alert addAction:OkButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void) closeView {
    
    [self alertMsgWithButtons : @"Server Connection Fail" AndMsg : @"" ];
    
}


-(void)receiveServerData : (NSDictionary *) data{
    
    self.resData = data;
    NSLog(@"profile %@", data);
    self.docNm.text = [self.resData valueForKey:@"displayName"];
    self.mobileNo.text = [self.resData valueForKey:@"phone_number"];
    self.dob.text = [self.resData valueForKey:@"dob"];
    self.sex.text = [self.resData valueForKey:@"sex"];
   

    [self.docImage setImage:[UIImage imageNamed: [NSString stringWithFormat:@"person_black.png"] ]];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.resData valueForKey:@"profilePicUrl"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet] ]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            self.docImage.image = image;
        });
    });
   
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
