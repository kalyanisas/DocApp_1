//
//  ChatMessagesVC.m
//  App2807_1
//
//  Created by Kalyani on 21/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "ChatMessagesVC.h"
#import "AFNetworking.h"
#import "MNCChatMessage.h"
#import "MNCChatMessageCell.h"

#import "AutoSizeCell.h"
#import "URLConstants.h"
#import "serverData.h"



@interface ChatMessagesVC () <serverDataDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UITextField *messageEditField;

@property (strong, nonatomic) IBOutlet UITableView *historicalMessagesTableView;
@property (strong, nonatomic) NSMutableArray *roleList;
@property (strong, nonatomic) NSMutableArray *timestampList;

@property (strong,nonatomic ) NSArray *msgArr1;

@property (strong, nonatomic) NSMutableArray *theTokenLocal;

@end

float wt,ht;

@implementation ChatMessagesVC


-(NSDictionary *) resData
{
    if(!_resData)
    {
        _resData = [[NSDictionary alloc]init];
    }
    return _resData;
}

-(NSMutableArray *) msgArr
{
    if(!_msgArr)
    {
        _msgArr = [[NSMutableArray alloc]init];
    }
    return _msgArr;
}
-(NSMutableArray *) timestampList
{
    if(!_timestampList)
    {
        _timestampList = [[NSMutableArray alloc]init];
    }
    return _timestampList;
}
-(NSMutableArray *) roleList
{
    if(!_roleList)
    {
        _roleList = [[NSMutableArray alloc]init];
    }
    return _roleList;
}

-(NSMutableArray *) theTokenLocal
{
    if(!_theTokenLocal)
    {
        _theTokenLocal = [[NSMutableArray alloc]init];
    }
    return _theTokenLocal;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.chatMateId;
    self.patientsName.text = self.selectedRowName;
    self.msgArr1 = [[NSArray alloc]initWithObjects:@"one two three four five six seven eight nine ten eleven twelve",
                 @"This is some long text that should wrap. It is multiple long sentences that may or may not have down vote I was also having this problem but what I found was the the order in which you set the UILabel's properties and methods matters! spelling and grammatical errors. Yep it should wrap quite nicely and serve as a nice example this class is not key value",
                  @"aaaaaaaaa kmmmmmm eeeeeeee kkkkkkk mmmmmmmm kkkkkkkkk kkkkkkkk kkkkkkkkk kkkkkk jjjjjjj dfgdggg yyyyyy eeeee gggggg eeeeee",
                  @"Hi",
                  @"How are U?",
                  @"I am fine thank you.....how is your day ...all is well",
                  @"hello",
                  @"welcome to objective c",nil];

    NSString *urlStr = [NSString  stringWithFormat:@"%@%@/", READ_MSGS, self.selectedThreadId];
    
    serverData *serverO= [serverData new];
    [self.theTokenLocal addObjectsFromArray: [serverO getToken]];
    self.theTokenLocal[USER] =  @"d_onco@onco.com";
    
    serverO.delegate = self;
    [serverO getServerData : @"GET" urlString: urlStr userName:self.theTokenLocal[USER] password: self.theTokenLocal[PASS] params:nil ];

    CGSize itemSize = CGSizeMake(self.patientImageView.bounds.size.width, self.patientImageView.bounds.size.height);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [self.patientImageView.image drawInRect:imageRect];
    self.patientImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.patientImageView setImage:[UIImage imageNamed: [NSString stringWithFormat:@"prescription_black.png"] ]];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.selectedPatientsImage stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet] ]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            self.patientImageView.image = image;
        });
    });
//    self.tabBarController.tabBar.hidden = YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.msgArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MNCChatMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:messageCell forIndexPath:indexPath];
   return messageCell;
}


#pragma mark Method to configure the appearance of a message list prototype cell

- (void)configureCell:(MNCChatMessageCell *)messageCell forIndexPath:(NSIndexPath *)indexPath {
    
    CGRect frame = messageCell.myMessageLabel.frame;
    CGRect frame1 = messageCell.elseMessageLabel.frame;

    frame.size.width = wt;
    frame.size.height = ht;
    frame1.size.width = wt;
    frame1.size.height = ht;
    
    messageCell.myMessageLabel.numberOfLines = 0;
    messageCell.elseMessageLabel.numberOfLines = 0;

    UIFont *font1 = [UIFont fontWithName:@"helvetica neue" size:15];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
    
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[self.msgArr objectAtIndex:indexPath.row] attributes: arialDict];
    
    UIFont *font2 = [UIFont fontWithName:@"verdana" size:8];
    NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[self.timestampList objectAtIndex:indexPath.row] attributes: arialDict2];
    
    messageCell.myMessageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageCell.elseMessageLabel.attributedText = NSLineBreakByWordWrapping;
    
    [aAttrString1 appendAttributedString:aAttrString2];

    if ([[self.roleList objectAtIndex:indexPath.row] isEqualToString:@"DOCTOR"] ){
        NSLog(@"+++++sd %f", frame1.size.height);

        messageCell.myMessageLabel.frame = CGRectMake(self.tableView.frame.size.width-frame.size.width-10,
                                                      frame.origin.y,
                                                      frame.size.width,
                                                      frame.size.height);
        [messageCell.elseMessageLabel setHidden:YES];
        messageCell.myMessageLabel.textAlignment = NSTextAlignmentRight;
        messageCell.myMessageLabel.attributedText = aAttrString1;
    }
    else {
        NSLog(@"****sd %f", frame1.size.height);
        messageCell.elseMessageLabel.frame = CGRectMake(frame1.origin.x,
                                                      frame1.origin.y,
                                                      frame1.size.width,
                                                      frame1.size.height);
 
        [messageCell.myMessageLabel setHidden:YES];
        messageCell.elseMessageLabel.textAlignment = NSTextAlignmentLeft;
        messageCell.elseMessageLabel.attributedText = aAttrString1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoSizeCell *cell = [[AutoSizeCell alloc] init];
    NSString *str = [ [NSString alloc] initWithFormat:@"%@\n%@",[self.msgArr objectAtIndex:indexPath.row], [self.timestampList objectAtIndex:indexPath.row] ];
    cell.textLabel.text = str;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    wt = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width;
   
     ht = height;
    return height;
    
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

    self.resData = data;

    NSArray *objString = [self.resData objectForKey:@"messages"];
    int t = (int)(objString.count -1);
    
    for (int i =t ; i >= 0 ; i--) {
        
        NSString *txt = [objString[i] objectForKey:@"text"];
        NSString *timestamp = [objString[i] objectForKey:@"timestamp"];

        NSDictionary *sourceDic = [objString[i] objectForKey:@"source"];
        NSString *role = [sourceDic objectForKey:@"role"];
        [self.msgArr addObject: txt];

        NSString *str = [[NSString alloc] initWithFormat:@"\n\n%@",[self convertDate:timestamp ] ];
        [self.timestampList addObject:str];
        
        [self.roleList addObject:role];
    }
    [self.tableView reloadData];
}

-(NSString *) convertDate : (NSString*) timeAndDate{
    
    NSString *dateStr = [NSString stringWithFormat:@"%@",timeAndDate];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    dateStr = [NSString stringWithFormat:@"%@",timeAndDate];
    [dateFormat setCalendar:gregorianCalendar];
    [dateFormat setTimeZone:timeZone];
    [dateFormat setLocale:locale];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    [dateFormat setTimeZone:timeZone];
    
    [dateFormat setDateFormat:@"MMM d, h:mm a"];
    
    return [dateFormat stringFromDate:date];
}


@end
