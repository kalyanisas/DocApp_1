//
//  LogoutViewController.m
//  App2807_1
//
//  Created by Kalyani on 30/07/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "LogoutVC.h"
#import "PatientsListVC.h"

@interface LogoutVC ()

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@end

@implementation LogoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    

    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Signout"
                                 message:@"Are you Sure?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self dontLogout];
                                   //Handle your yes please button action here
                               }];
    UIAlertAction* yesButton = [UIAlertAction
                               actionWithTitle:@"Yes"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self logout];
                                   //Handle your yes please button action here
                               }];

    [alert addAction:noButton];
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    

 }


-(void)dontLogout{

    self.tabBarController.selectedIndex = 0;

    
}


-(void)logout{
    
   [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pass"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tokenId"];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(IBAction)unWindToMain:(UIStoryboardSegue *)segue

{
    
}


@end
