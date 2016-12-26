//
//  AFNetworkClass.h
//  App2807_1
//
//  Created by Kalyani on 28/09/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"



@class AFNetworkClass;
@protocol AFNetworkClassDelegate
-(void) receiveServerDataDelegate:(NSDictionary*)resData;

@end


@interface AFNetworkClass : NSObject
@property (nonatomic,retain) id <AFNetworkClassDelegate> delegate;

@property (strong, nonatomic) NSDictionary *resData;

-(void ) getServerData: (NSString *) url;

@end


