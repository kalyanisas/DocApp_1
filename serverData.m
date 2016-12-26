//
//  serverData.m
//  App2807_1
//
//  Created by Kalyani on 23/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "serverData.h"
#import "AFNetworking.h"


@implementation serverData


-(NSMutableDictionary *) resData
{
    if(!_resData)
    {
        _resData = [[NSMutableDictionary alloc]init];
    }
    return _resData;
}

-(NSMutableArray *) tokenArr
{
    if(!_tokenArr)
    {
        _tokenArr = [[NSMutableArray alloc]init];
    }
    return _tokenArr;
}

@synthesize delegate;

-(void )getServerData:(NSString *)requestType urlString: (NSString *)url userName : (NSString *) user password : (NSString *) pass params :(NSMutableDictionary *)params;
{
    NSLog(@" calling serverData ........");
    
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:user password:pass];
        
    if ([requestType isEqualToString:@"GET"])
    {
    
        [manager  GET: url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
             self.resData = (NSMutableDictionary *)responseObject;
             dispatch_async(dispatch_get_main_queue(), ^{
                 NSLog(@"calling receiveData GET call");
                 [self.delegate receiveServerData: self.resData ];
             });
             
             
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             [self.delegate closeView];

             NSLog(@"data fail");
         }];
    }
    if([requestType isEqualToString:@"POST"])
        {
            [manager  POST: url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                self.resData = (NSMutableDictionary *)responseObject;
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"calling receiveData POST call");

                    [self.delegate receiveServerData: self.resData ];
                });
                
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"calling receiveData call");
//                [self.resData setObject:@"222" forKey: @"tokenId"];

////                [ self.resData  setObject:@"111" forKey: @"token"];
//                NSLog(@"Token ID %@", self.resData);
//                [self.delegate receiveServerData: self.resData ];
                [self.delegate closeView];
                NSLog(@"data fail");
            }];
        }
}

-(NSMutableArray *) getToken{
        
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    if ([userDef stringForKey:@"user"])
        [ self.tokenArr addObject :[userDef stringForKey:@"user"]];
    if ([userDef stringForKey:@"pass"])
        [ self.tokenArr addObject:[userDef stringForKey:@"pass"]];
    if ([userDef stringForKey:@"tokenId"])
        [ self.tokenArr addObject:[userDef stringForKey:@"tokenId"]];
    
    if(![userDef stringForKey:@"user"].length) {
        [ self.tokenArr addObject:@""];
    }
    if(![userDef stringForKey:@"pass"].length) {
        [ self.tokenArr addObject:@""];
    }
    if(![userDef stringForKey:@"tokenId"].length) {
        [ self.tokenArr addObject:@""];
    }
    
    
    return self.tokenArr;
}


@end
