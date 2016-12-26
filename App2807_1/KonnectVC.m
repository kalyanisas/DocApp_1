//
//  KonnectViewController.m
//  App2807_1
//
//  Created by Kalyani on 29/07/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "KonnectVC.h"
#import "ChatsVC.h"
#import "ChatMessagesVC.h"
#import "URLConstants.h"
#import "serverData.h"
#import "AFNetworking.h"


@interface KonnectVC () <serverDataDelegate>

@property (strong, nonatomic)NSString *selectedPatName;

@property (strong, nonatomic) NSMutableArray *patNameList;
@property (strong, nonatomic) NSMutableArray *threadIdList;
@property (strong, nonatomic) NSMutableArray *urlList;
@property (strong, nonatomic) NSMutableArray *theTokenLocal;


@end

int chatTypeSelected;

@implementation KonnectVC

@synthesize konnectTableView, konnectSerachBar, isFiltered, filteredNameList;
@synthesize resData;

-(NSMutableArray *) theTokenLocal
{
    if(!_theTokenLocal)
    {
        _theTokenLocal = [[NSMutableArray alloc]init];
    }
    return _theTokenLocal;
}

-(NSMutableArray *) patNameList
{
    if(!_patNameList)
    {
        _patNameList = [[NSMutableArray alloc]init];
    }
    return _patNameList;
}

-(NSMutableArray *) urlList
{
    if(!_urlList)
    {
        _urlList = [[NSMutableArray alloc]init];
    }
    return _urlList;
}

-(NSMutableArray *) threadIdList
{
    if(!_threadIdList)
    {
        _threadIdList = [[NSMutableArray alloc]init];
    }
    return _threadIdList;
}




- (void)viewDidLoad {
    
    konnectTableView.delegate = self;
    konnectTableView.dataSource = self;
    konnectSerachBar.delegate = self;
    
    [konnectSerachBar setHidden:YES];
    [super viewDidLoad];
    
    serverData *serverO= [serverData new];
    [self.theTokenLocal addObjectsFromArray: [serverO getToken]];
    self.theTokenLocal[USER] =  @"d_onco@onco.com";
    self.chatSegment.selectedSegmentIndex = 0;
    serverO.delegate = self;

    [serverO getServerData : @"GET" urlString: READ_MSGS userName:self.theTokenLocal[USER] password: self.theTokenLocal[PASS] params:nil ];
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [konnectTableView resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        NSLog(@"search str %@ Len  %lu",searchText, (unsigned long)searchText.length);
        isFiltered = NO;
        [self.konnectTableView reloadData];
    }
    else
    {
        isFiltered = YES;
        filteredNameList = [[NSMutableArray alloc]init];
        
        int count = 0;
        for(NSString *str in self.patNameList)
        {
            NSRange stringRange = [str rangeOfString : searchText options:NSCaseInsensitiveSearch];
            if(stringRange.location != NSNotFound)
            {
                [filteredNameList addObject:str];
                //                NSLog(@"filtered List %@",str);
            }
            count++;
            [konnectTableView reloadData];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"ikonnect"]) {
        
        NSIndexPath *indexPath = [self.konnectTableView indexPathForSelectedRow];
        ChatMessagesVC *cvc = [segue destinationViewController];
        
        
        NSString *dictionaryKey = @"displayName";
        NSString *prdicateString = [[NSString alloc]init];
        
        
        prdicateString = [self.patNameList objectAtIndex:indexPath.row];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@", dictionaryKey, prdicateString];
        NSDictionary *selectedRow =[[NSDictionary alloc]init];
        
        
        selectedRow = (NSDictionary *)  [self.resData filteredArrayUsingPredicate:predicate] ;
        NSArray *imageurl = [selectedRow valueForKey:@"profilePicUrl"];
        
        cvc.selectedRowName = prdicateString;
        cvc.selectedPatientsImage = imageurl[0];
        cvc.selectedThreadId = [self.threadIdList objectAtIndex:indexPath.row];
    }
    
    if ([[segue identifier] isEqualToString:@"chatSegue"]) {
        NSIndexPath *indexPath = [self.konnectTableView indexPathForSelectedRow];
        ChatMessagesVC *cvc = [segue destinationViewController];
        
        cvc.selectedRowName =  [self.patNameList objectAtIndex:indexPath.row];
        cvc.selectedPatientsImage = [self.urlList objectAtIndex:indexPath.row];
        cvc.selectedThreadId = [self.threadIdList objectAtIndex:indexPath.row];;
    }
    
}


- (IBAction)chatSelectedSegment:(id)sender {
    
    [self.patNameList removeAllObjects];
    [self.threadIdList removeAllObjects];
    [self.urlList removeAllObjects];
    serverData *serverO= [serverData new];
   
    serverO.delegate = self;
    
    switch (self.chatSegment.selectedSegmentIndex)
    {
        case 0:
            chatTypeSelected= 0;
            [konnectSerachBar setHidden:YES];
            [serverO getServerData : @"GET" urlString: READ_MSGS userName:self.theTokenLocal[USER] password: self.theTokenLocal[PASS] params:nil ];
            break;
        case 1:
            chatTypeSelected= 1;
            [konnectSerachBar setHidden:NO];
            [serverO getServerData : @"GET" urlString: MY_PATIENTS userName:self.theTokenLocal[USER] password: self.theTokenLocal[PASS] params:nil ];
            break;
        default:
            break;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isFiltered)
    {
        NSLog(@"fil count %lu", (unsigned long)filteredNameList.count);
        return filteredNameList.count;
    }
    return self.patNameList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(!isFiltered)
    {
        cell.textLabel.text =[self.patNameList objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [filteredNameList objectAtIndex:indexPath.row];
    }
    self.selectedPatName = cell.textLabel.text;
    
    return cell;
}

-(IBAction)unWindToMain:(UIStoryboardSegue *)segue
{
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
    self.resData = (NSMutableArray *) data;
    
    if (chatTypeSelected == 0)
    {
        for (int i =0 ; i < self.resData.count ; i++) {
            NSDictionary *user = [self.resData[i] objectForKey:@"users"];
            NSString *threadid = [self.resData[i] objectForKey:@"id"];
            for(NSDictionary *uDic in user ){
                
                NSString *patName = [uDic objectForKey:@"displayName"];
                NSString *role = [uDic objectForKey:@"role"];
                NSString *patUrl = [uDic objectForKey:@"profilePicUrl"];
                if([ role isEqualToString:@"PATIENT"])
                {
                    [self.patNameList addObject:patName ];
                    [self.threadIdList addObject:threadid ];
                    [self.urlList addObject:patUrl];
                }
            }
        }
    }
    else
    {
        NSDictionary *resDict = (NSDictionary *) resData;
        NSMutableArray *objString = [resDict objectForKey:@"patients"];
        [self.patNameList addObjectsFromArray:[objString valueForKey:@"displayName"]];
        
        objString = [resDict objectForKey:@"patients"];
        
        int count=0;
        for (NSDictionary *dict in [resDict objectForKey:@"patients"]) {
            NSString *temp = [dict valueForKey:@"profilePicUrl"];
            if ([temp isEqualToString:@"/static/app/img/default_patient_pic.png"])
                temp = @"http://konnect.olivo.in/static/app/img/default_patient_pic.png";
            [self.urlList addObject:temp];
            count++;
        }
        
    }
    [self.konnectTableView reloadData];
}



@end




