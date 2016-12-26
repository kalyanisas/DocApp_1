//
//  serverDelegate.h
//  App2807_1
//
//  Created by Kalyani on 23/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface serverDelegate : NSObject

@class serverDelegate;
@protocol serverDelegate

-(void)dismissAddContactVC;
-(void )addPatientName:(NSString *)name phone:(NSString *)phone;

@end


@end
