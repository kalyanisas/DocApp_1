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
#import "AFNetworking.h"

static NSString * const chatURLString = @"http://www.konnect.olivo.in//api/treatment/v1.0/questions/";
static NSString * const BaseURLString = @"http://www.konnect.olivo.in//api/account/v1.0/mypatients/";


@interface KonnectVC ()

@property (strong, nonatomic)NSString *selectedPatName;

@property (strong, nonatomic) NSMutableArray *patNameList;
@property (strong, nonatomic) NSMutableArray *threadIdList;
@property (strong, nonatomic) NSMutableArray *urlList;


@end

int chatTypeSelected;

@implementation KonnectVC

@synthesize konnectTableView, konnectSerachBar, isFiltered, filteredNameList;
@synthesize resData;

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
    
    [self getServerData:chatURLString];
    
    [konnectSerachBar setHidden:YES];
    [super viewDidLoad];
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
    switch (self.chatSegment.selectedSegmentIndex)
    {
        case 0:
            chatTypeSelected= 0;
            [konnectSerachBar setHidden:YES];
            [self getServerData:chatURLString];
            
            
            break;
        case 1:
            chatTypeSelected= 1;
            [konnectSerachBar setHidden:NO];
            [self getServerData:BaseURLString];
            
            
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

-(void ) getServerData: (NSString *) url
{
    //1
    NSString *string = url;
    NSURL *urlString = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlString];
    // 2
    //set auth header
    [request addValue:[NSString stringWithFormat:@"Basic ZF9vbmNvQG9uY28uY29tOjEyMw==" ] forHTTPHeaderField:@"Authorization"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        resData = (NSArray *)responseObject;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Resdata for chat %@", resData);

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
        NSLog(@"ikonnect selected");
        
    }
    [self.konnectTableView reloadData];
    
}



@end




