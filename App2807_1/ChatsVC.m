//
//  ChatsVC.m
//  App2807_1
//
//  Created by Kalyani on 19/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "ChatsVC.h"
#import "AFNetworking.h"

static NSString * const BaseURLString = @"http://www.konnect.olivo.in//api/treatment/v1.0/questions/";

@interface ChatsVC () <UITableViewDelegate, UITableViewDataSource>

@end



@implementation ChatsVC

@synthesize resData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.patientsName.text = self.selectedRowName;
    
    
    CGSize itemSize = CGSizeMake(_patientsImage.bounds.size.width, _patientsImage.bounds.size.height);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [_patientsImage.image drawInRect:imageRect];
    _patientsImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [_patientsImage setImage:[UIImage imageNamed: [NSString stringWithFormat:@"person_black.png"] ]];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.selectedPatientsImage stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet] ]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            self.patientsImage.image = image;
        });
    });

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    return cell;
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
        
        resData = (NSDictionary *)responseObject;
        
        dispatch_async(dispatch_get_main_queue(), ^{
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
    //      NSArray *objString = [self.resData objectForKey:@"readLogs"];
//    NSArray *objString = [self.resData objectForKey:@"messages"];
    
    NSLog(@"***************------------------------------------------------***************");
    
    //    NSMutableArray *txtArray =[[NSMutableArray alloc]init];
    
    for (int i =0 ; i < self.resData.count ; i++) {
        
        NSDictionary *txt = [self.resData[i] objectForKey:@"user"];
        //       NSLog(@"messages %@ ------------------------------------------------", objString[1]);
        NSLog(@"Text ++++++ %@ +++++++", txt);
        
    }
//    [self.tableView reloadData];
}



@end
