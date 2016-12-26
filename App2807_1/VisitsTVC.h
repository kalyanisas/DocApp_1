//
//  VisitsTableViewController.h
//  App2807_1
//
//  Created by Kalyani on 29/07/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitsTVC : UITableViewController

@property NSInteger rowVar;
@property (strong, nonatomic) NSString *patientID;

@property (strong, nonatomic) NSMutableArray *visitsList;
@property (strong, nonatomic) NSDictionary *visitsDetail;


-(void ) getServerData: (NSString *) url;
-(void) receiveServerData;



@end
