//
//  ChatMessagesVC.h
//  App2807_1
//
//  Created by Kalyani on 21/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNCChatMessageCell.h"


@interface ChatMessagesVC : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) NSString *chatMateId;     /* add this line */

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *patientsName;
@property (weak, nonatomic) IBOutlet UIImageView *patientImageView;

@property (strong, nonatomic) NSString *selectedRowName;
@property (strong, nonatomic) NSString *selectedPatientsImage;
@property (strong, nonatomic) NSString *selectedThreadId;

@property (strong, nonatomic) NSMutableArray *msgArr;
@property (strong, nonatomic) NSDictionary *resData;

@end
