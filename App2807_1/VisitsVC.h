//
//  VisitsVC.h
//  App2807_1
//
//  Created by Kalyani on 18/10/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitsVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) NSDictionary *selectedPatientRecord;
@property (strong, nonatomic) NSString *patientID;
@property NSInteger rowSelected;



@property (strong, nonatomic) NSMutableArray *visitsList;
@property (strong, nonatomic) NSDictionary *visitsDetail;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSDictionary *resData;

-(void) loadImage;


@end
