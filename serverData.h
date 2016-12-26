//
//  serverData.h
//  App2807_1
//
//  Created by Kalyani on 23/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <Foundation/Foundation.h>


@class serverData;
@protocol serverDataDelegate

-(void )receiveServerData : (NSDictionary * )data;
-(void) closeView;

@end

@interface serverData : NSObject
@property (nonatomic, weak) id <serverDataDelegate> delegate;
@property (strong, nonatomic) NSMutableDictionary *resData;
@property (strong, nonatomic) NSMutableArray *tokenArr;

-(void )getServerData:(NSString *)requestType urlString: (NSString *)url userName : (NSString *) user password : (NSString *) pass params :(NSMutableDictionary *)params;
-(NSMutableArray *) getToken;

@end
