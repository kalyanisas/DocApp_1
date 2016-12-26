//
//  HomepageVC.m
//  App2807_1
//
//  Created by Kalyani on 02/10/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "HomepageVC.h"
#import "AFNetworking.h"
#import "URLConstants.h"
#import "serverData.h"

#import "UIImageView+AFNetworking.h"



@interface HomepageVC () <serverDataDelegate>

@property (strong, nonatomic) NSMutableArray *theTokenLocal;
@property (strong, nonatomic) NSString *serverToken;

@end

@implementation HomepageVC


-(NSMutableArray *) theTokenLocal
{
    if(!_theTokenLocal)
    {
        _theTokenLocal = [[NSMutableArray alloc]init];
    }
    return _theTokenLocal;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    self.usernameField.text = @"";
    self.passwordField.text = @"";
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.usernameField.text = @"";
    self.passwordField.text = @"";
    
   
    serverData *serverO = [serverData new];
    [self.theTokenLocal addObjectsFromArray: [serverO getToken]];
 
    if ( self.theTokenLocal) {
     
        [self.loginView setHidden:NO];
    }
    else {
        
        [self.loginView setHidden:YES];
        [self performSelector:@selector(showMainMenu) withObject:nil afterDelay:1.0];
    }
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    [super viewWillAppear:animated];
    
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    

}
- (UIInterfaceOrientationMask )supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


-(void) viewWillDisappear:(BOOL)animated{
    
    NSString *userNameText = self.usernameField.text;
    NSString *passwordText = self.passwordField.text;
    
    if([self.serverToken isEqualToString:@"dummy"] || [self isValidToken]) {
 
        [[NSUserDefaults standardUserDefaults] setObject:userNameText forKey: @"user"];
        [[NSUserDefaults standardUserDefaults] setObject:passwordText forKey: @"pass"];
        [[NSUserDefaults standardUserDefaults] setObject:self.theTokenLocal[TOKEN] forKey: @"tokenId"];
    }
    
}


- (void)showMainMenu {
    [self performSegueWithIdentifier:@"ShowHomepageSegue" sender:self];
}

- (IBAction)loginButton:(id)sender {
    
    if( [self isEmpty:self.usernameField.text]) {
        [self alertMsgWithButtons : @"" AndMsg : @"Username can't be blank" ];

    }
    if( [self isEmpty:self.passwordField.text]) {
        [self alertMsgWithButtons : @"" AndMsg : @"Password can't be blank" ];
        
    }
 
    if( ![self isValidUser]) {
        [self alertMsgWithButtons : @"" AndMsg : @"Invalid Username" ];
        
    }
    if( ![self isValidPass]) {
        [self alertMsgWithButtons : @"" AndMsg : @"Invalid Password" ];
        
    }
    if( [self isValidUser] && [self isValidPass]  ) {
        [self callToken:self.theTokenLocal[USER] andPass:self.theTokenLocal[PASS]];
    }
}

-(void)receiveServerData : (NSDictionary *) data{
    NSLog(@"data collected  %@ %@", data, self.theTokenLocal[TOKEN] );
    
    self.serverToken = [data valueForKey:@"token"];
    
    
    if([self.theTokenLocal[TOKEN] isEqualToString:@"dummy"] || [self isValidToken] || [self isEmpty:self.serverToken]) {
        
        self.theTokenLocal [TOKEN]  = self.serverToken;
        [self performSelector:@selector(showMainMenu) withObject:nil afterDelay:1.0];

    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void) callToken : (NSString *) user andPass :(NSString *) pass {
    
    NSString *urlL = [ [NSString alloc ] initWithFormat:@"%@/?username=%@&password=%@&role=DOCTOR",
                      LOGIN,
                      user,
                      pass];
    
    serverData *serObj = [serverData new];
    serObj.delegate = self;
    [serObj getServerData : @"POST"
                 urlString: urlL
                  userName: nil
                  password: nil
                    params: nil];
 
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

-(BOOL)isEmpty:(NSString *)str
{
    if(str.length==0 ||
       [str isKindOfClass:[NSNull class]] ||
       [str isEqualToString:@""]||
       [str isEqualToString:@"(null)"]||
       str==nil ||
       [str isEqualToString:@"<null>"])
    {
        return YES;
    }
    return NO;
}

-(BOOL)isValidUser
{
    if([self isEmpty : self.theTokenLocal[USER]])
        return YES;
    if([self.usernameField.text isEqualToString:self.theTokenLocal[USER] ])
    {
        return YES;
    }
    return NO;
}

-(BOOL)isValidPass
{
    if([self isEmpty : self.theTokenLocal[PASS]])
        return YES;

    if([self.passwordField.text isEqualToString:self.theTokenLocal[PASS] ])
    {
        return YES;
    }
    return NO;
}

-(BOOL)isValidToken
{
    if([self isEmpty : self.theTokenLocal[TOKEN]])
        return YES;
  
    if([self.serverToken isEqualToString:self.theTokenLocal[TOKEN] ])
    {
        return YES;
    }
    return NO;
}

@end



