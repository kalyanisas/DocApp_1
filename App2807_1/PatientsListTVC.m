//
//  PatientsListViewController.m
//  App2807_1
//
//  Created by Kalyani on 28/07/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "PatientsListTVC.h"
#import "serverData.h"
#import "URLConstants.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"


@interface PatientsListTVC () <NewPatientVCDelegate, serverDataDelegate>

@property (strong, nonatomic) NSMutableArray *patientNamesList;
@property (strong, nonatomic) NSMutableArray *patientPhoneList;
@property (strong, nonatomic) NSMutableArray *patientIdList;
@property (strong, nonatomic) NSMutableArray *imageUrlList;
@property (strong, nonatomic) NSMutableArray *theTokenLocal;

@property (readonly, nonatomic) NSInteger rowSel;

@end

@implementation PatientsListTVC

@synthesize resData, rowSel;


-(NSMutableArray *) patientNamesList
{
    if(!_patientNamesList)
    {
        _patientNamesList = [[NSMutableArray alloc]init];
    }
    return _patientNamesList;
}

-(NSMutableArray *) patientPhoneList
{
    if(!_patientPhoneList)
    {
        _patientPhoneList = [[NSMutableArray alloc]init];
    }
    return _patientPhoneList;
}


-(NSMutableArray *) patientIdList
{
    if(!_patientIdList)
    {
        _patientIdList = [[NSMutableArray alloc]init];
    }
    return _patientIdList;
}
-(NSMutableArray *) imageUrlList
{
    if(!_imageUrlList)
    {
        _imageUrlList = [[NSMutableArray alloc]init];
    }
    return _imageUrlList;
}

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
    serverData *serverO= [serverData new];
    [self.theTokenLocal addObjectsFromArray: [serverO getToken]];
    self.theTokenLocal[USER] =  @"d_onco@onco.com";

    serverO.delegate = self;
    [serverO getServerData : @"GET" urlString: MY_PATIENTS userName:self.theTokenLocal[USER] password: self.theTokenLocal[PASS] params:nil ];
}

-(void)receiveServerData : (NSDictionary *) data{
    NSString  *error = [data valueForKey:@"error"];
    if(error.length)
        [self alertMsgWithButtons:@"Error" AndMsg:[data valueForKey:@"error"]];
    else {
    self.resData = data;
    NSMutableArray *objString = [self.resData objectForKey:@"patients"];
    [self.patientNamesList addObjectsFromArray:[objString valueForKey:@"displayName"]];
    
    objString = [self.resData objectForKey:@"patients"];
    self.patientIdList = [objString valueForKey:@"id"];
    
    int count=0;
    for (NSDictionary *dict in [self.resData objectForKey:@"patients"]) {
        NSString *temp = [dict valueForKey:@"phone_number"];
        [self.patientPhoneList addObject:temp];
        temp = [dict valueForKey:@"profilePicUrl"];
        if ([temp isEqualToString:@"/static/app/img/default_patient_pic.png"])
            temp = @"http://konnect.olivo.in/static/app/img/default_patient_pic.png";
        [self.imageUrlList addObject:temp];
        count++;
    }
    }
    [self.tableView reloadData];
}


-(void)viewWillAppear:(BOOL)animated{
    serverData *serverO = [serverData new];
    [self.theTokenLocal addObjectsFromArray: [serverO getToken]];
    self.theTokenLocal[USER] =  @"d_onco@onco.com";
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"VisitsSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        VisitsVC *plvc = [segue destinationViewController];
        NSArray *arr = [self.resData objectForKey:@"patients"];
        NSString *dictionaryKey = @"id";
        NSString *prdicateString = [[NSString alloc]init];
        prdicateString = [self.patientIdList objectAtIndex:indexPath.row];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@", dictionaryKey, prdicateString];
        plvc.selectedPatientRecord =  (NSDictionary *) [arr filteredArrayUsingPredicate:predicate] ;
        plvc.rowSelected = indexPath.row;
    }
    if([[segue identifier ]isEqualToString:@"NewPatientSegue"])
    {
        [(NewPatientVC *)segue.destinationViewController setDelegate:self];
    }
}

-(void) dismissAddContactVC
{
    [self dismissViewControllerAnimated:YES completion:nil ];
}

-(void) addPatientName:(NSString *)name phone:(NSString *)phone
{
    [self.patientNamesList addObject:name];
    [self.patientPhoneList addObject:phone];
    [self.imageUrlList addObject:@"/static/app/img/default_patient_pic.png"];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:name forKey:@"name"];
    [params setObject:phone forKey:@"phone_number"];
    [params setObject:@"PATIENT" forKey:@"role"];
    [params setObject:@"/static/app/img/default_patient_pic.png" forKey:@"profilePicUrl"];

    serverData *serverO= [serverData new];
    [serverO getToken];
    serverO.delegate = self;
    [serverO getServerData : @"POST" urlString: ADD_PATIENT userName:self.theTokenLocal[USER] password: self.theTokenLocal[PASS] params:params ];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.patientNamesList.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if( cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.patientNamesList objectAtIndex:indexPath.row];
    cell.detailTextLabel.text =  [self.patientPhoneList objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,cell.contentView.bounds.size.height ,tableView.bounds.size.width+1, 3)] ;
    lineView.backgroundColor =  [UIColor blackColor];
    [cell.contentView addSubview:lineView];
    
    CGSize itemSize = CGSizeMake(20, 20);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width-10, itemSize.height-10);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *placeholderImage = [UIImage imageNamed:@"Contacts.png"];
    __weak UITableViewCell *weakCell = cell;
 
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    arr = self.imageUrlList;
    
    [cell.imageView setImageWithURLRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString: [self.imageUrlList objectAtIndex:indexPath.row]]]
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.imageView.image = image;
                                       [weakCell setNeedsLayout];
                                   } failure:nil];
    
    lineView.backgroundColor =  [UIColor blackColor];
    [cell.contentView addSubview:lineView];

    return cell;
}

-(IBAction)unWindToMain:(UIStoryboardSegue *)segue
{
    
}

-(void) alertMsg : (NSString *)msg andTime : (float ) timeInterval {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alertController dismissViewControllerAnimated:YES completion:^{
        }];
        
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



@end
