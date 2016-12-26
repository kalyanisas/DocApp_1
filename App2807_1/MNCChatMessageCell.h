//
//  MNCChatMessageCell.h
//  roundedLabels
//
//  Created by Kalyani on 21/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNCChatMessageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *timeStampLabel;

@property (strong, nonatomic) IBOutlet UILabel *myMessageLabel;
@property (strong, nonatomic) IBOutlet UILabel *elseMessageLabel;

@end
