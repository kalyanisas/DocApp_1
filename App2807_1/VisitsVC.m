//
//  VisitsVC.m
//  App2807_1
//
//  Created by Kalyani on 18/10/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "VisitsVC.h"
#import "URLConstants.h"
#import "serverData.h"
#import "AFNetworking.h"

@interface VisitsVC () <serverDataDelegate>

@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSMutableArray *theTokenLocal;

@end

@implementation VisitsVC
@synthesize visitsDetail, visitsList;
@synthesize resData;

@synthesize nameLabel, ageLabel,phoneLabel,selectedPatientRecord,patientID,rowSelected;


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
    NSArray *patientIDArr = [selectedPatientRecord valueForKey:@"id"];
    patientID = patientIDArr[0];
    
    NSLog(@"Patient ID getServerData %@ pat id %@",selectedPatientRecord, patientID);
    NSString *urlStr = [NSString stringWithFormat:@"%@%@/",DOCTOR_VISITS , patientID];

    serverData *serverO= [serverData new];
    [self.theTokenLocal addObjectsFromArray: [serverO getToken]];
    self.theTokenLocal[USER] =  @"d_onco@onco.com";

    serverO.delegate = self;
    [serverO getServerData : @"GET" urlString: urlStr userName:self.theTokenLocal[USER] password: self.theTokenLocal[PASS] params:nil ];
}


- (NSMutableArray *)visitsList
{
    if(!visitsList)
    {
        visitsList = [[NSMutableArray alloc]init];
    }
    return visitsList;
    
}

- (NSDictionary *)selectedPatientRecord
{
    if(!selectedPatientRecord)
    {
        selectedPatientRecord = [[NSDictionary alloc]init];
    }
    return selectedPatientRecord;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.visitsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.visitsList objectAtIndex:indexPath.row];
    rowSelected = indexPath.row;
    
   return cell;
}


-(void)viewWillAppear:(BOOL)animated{
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
    NSNull *null = [NSNull null];
    NSArray *vList  = [resData  valueForKey:@"visit_date"];
    NSArray *name = [selectedPatientRecord valueForKey:@"displayName"];
    self.nameLabel.text =  name[0];

    NSArray *phone = [selectedPatientRecord valueForKey:@"phone_number"];
    self.phoneLabel.text = phone[0];
    
    NSArray *emailId = [selectedPatientRecord valueForKey:@"email"];
    self.emailLabel.text =  emailId[0];
    
    NSArray *age = [selectedPatientRecord valueForKey:@"age"];
    if(age[0] != null)
        self.ageLabel.text = [NSString stringWithFormat:@"%@",age[0]];
    
    NSArray *gender = [selectedPatientRecord valueForKey:@"gender"];
    if(gender[0] != null)
        self.genderLabel.text = [NSString stringWithFormat:@" | %@",gender[0]];
    
    for (int i=0; i < [resData count] ; i++) {
        NSString *dateStr = [NSString stringWithFormat:@"%@",vList[i]];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        dateStr = [NSString stringWithFormat:@"%@",vList[i]];
        [dateFormat setCalendar:gregorianCalendar];
        [dateFormat setTimeZone:timeZone];
        [dateFormat setLocale:locale];
        
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        NSDate *date = [dateFormat dateFromString:dateStr];
        [dateFormat setTimeZone:timeZone];
        
        [dateFormat setDateFormat:@"EEE, MMM d, yyyy - h:mm a"];
        [self.visitsList addObject:[dateFormat stringFromDate:date]];
    }
    [self loadImage];
    [self.tableView reloadData];
}


-(void)loadImage
{
    CGSize itemSize = CGSizeMake(_imageLabel.bounds.size.width, _imageLabel.bounds.size.height);
    
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height-5);
    [_imageLabel.image drawInRect:imageRect];
    _imageLabel.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSArray *urlArr= [selectedPatientRecord valueForKey:@"profilePicUrl"];
   
    self.imageURL  = urlArr[0];
    if([self.imageURL isEqualToString : @"/static/app/img/default_patient_pic.png"])
        self.imageURL = @"http://konnect.olivo.in/static/app/img/default_patient_pic.png";
    
    [_imageLabel setImage:[UIImage imageNamed: [NSString stringWithFormat:@"prescription_black.png"] ]];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        
        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.imageURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet] ]]];
       dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            _imageLabel.image = image;
        });
    });

}



@end
