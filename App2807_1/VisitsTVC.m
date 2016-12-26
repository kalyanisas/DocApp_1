//
//  VisitsTableViewController.m
//  App2807_1
//
//  Created by Kalyani on 29/07/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "VisitsTVC.h"
#import "AFNetworking.h"

static NSString * const BaseURLString = @"http://www.konnect.olivo.in//api/treatment/v1.0/doctor_visits/";

@interface VisitsTVC ()

@end

@implementation VisitsTVC
@synthesize rowVar, visitsDetail,patientID;


- (void)viewDidLoad {

    [self getServerData:BaseURLString];
    [super viewDidLoad];
}

- (NSMutableArray *)visitsList
{
    if(!_visitsList)
    {
        _visitsList = [[NSMutableArray alloc]init];
    }
    return _visitsList;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.visitsList.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"visitsCell"
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = [self.visitsList objectAtIndex:indexPath.row];
    //  UIImage *img = [UIImage imageNamed:@"first.png"];
    // cell.imageView.image = img;
    // UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,logoCell.frame.size.width,80)];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Patient Name " @"dfdv";
}


-(IBAction)unWindToMain:(UIStoryboardSegue *)segue

{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // rowTemp = indexPath.row;
    NSLog(@"selected row : %ld", indexPath.row);
    
}


-(void ) getServerData: (NSString *) url
{
    //1
    
    NSString *string = [NSString stringWithFormat:@"%@%@/",url, patientID];

    NSLog(@"Visits URL %@",string );
    
    NSURL *urlString = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlString];
    // 2
    
    //set auth header
    [request addValue:[NSString stringWithFormat:@"Basic ZF9vbmNvQG9uY28uY29tOjEyMw==" ] forHTTPHeaderField:@"Authorization"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         visitsDetail= (NSDictionary *)responseObject;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"calling Visits List : getSerVerData method");
            // NSLog(@"data -->>%@", responseObject);
            
            [self receiveServerData];
            
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Patients List"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
    
    
    
}

-(void) receiveServerData
{
    NSLog(@"Visits Details  receiveServerDataDelegate method %@ >>>", self.visitsDetail );
    NSArray *vList  = [self.visitsDetail valueForKey:@"visit_date"];
    NSLog(@"Visits List  ===>>>> %@", vList);
    
    for (int i=0; i < [self.visitsDetail count] ; i++) {
        
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
        
        //    [dateFormat setDateFormat:@"hh:mm a"];
        
        [dateFormat setDateFormat:@"EEE, MMM d, yyyy - h:mm a"];
        [self.visitsList addObject:[dateFormat stringFromDate:date]];
        
    }
    [self.tableView reloadData];
}

@end



