//
//  ChatsVC.h
//  App2807_1
//
//  Created by Kalyani on 19/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatsVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *patientsName;
@property (weak, nonatomic) IBOutlet UIImageView *patientsImage;
@property (strong, nonatomic) NSString *selectedRowName;
@property (strong, nonatomic) NSString *selectedPatientsImage;

-(void ) getServerData: (NSString *) url;
@property (strong, nonatomic) NSArray *resData;
-(void) receiveServerData;



@end
