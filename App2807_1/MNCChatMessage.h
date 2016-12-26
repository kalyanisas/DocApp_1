//
//  MNCChatMessage.h
//  roundedLabels
//
//  Created by Kalyani on 21/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <Sinch/Sinch.h>

@interface MNCChatMessage : NSObject
@property (nonatomic, strong) NSString* messageId;

@property (nonatomic, strong) NSArray* recipientIds;

@property (nonatomic, strong) NSString* senderId;

@property (nonatomic, strong) NSString* text;

@property (nonatomic, strong) NSDictionary* headers;

@property (nonatomic, strong) NSDate* timestamp;



@end
