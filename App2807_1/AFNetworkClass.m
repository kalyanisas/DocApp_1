//
//  AFNetworkClass.m
//  PatientsListDjangoData2
//
//  Created by Kalyani on 23/09/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "AFNetworkClass.h"
#import "PatientsListTVC.h"

@implementation AFNetworkClass
@synthesize resData;




-(void ) getServerData: (NSString *) url
{
    //1
    
    NSString *string = url;
    NSURL *urlString = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlString];
    // 2
    
    //set auth header
    [request addValue:[NSString stringWithFormat:@"Basic b25jb0BvbmNvLmNvbToxMjM=" ] forHTTPHeaderField:@"Authorization"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.resData = (NSDictionary *)responseObject;
        
        dispatch_async(dispatch_get_main_queue(), ^{
           // NSLog(@"calling getSerVerData method %@", self.resData);
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


- (void) receiveServerData {
    NSLog(@"called ReceiveServerData %@ ===>>>>", self.resData);
    
    [self.delegate receiveServerDataDelegate:resData];
}

@end
