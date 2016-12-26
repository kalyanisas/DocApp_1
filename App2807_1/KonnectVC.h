//
//  KonnectViewController.h
//  App2807_1
//
//  Created by Kalyani on 29/07/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KonnectVC : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *konnectSerachBar;
@property (weak, nonatomic) IBOutlet UITableView *konnectTableView;
@property ( nonatomic) BOOL isFiltered;

@property(strong, nonatomic) NSMutableArray *filteredNameList;

@property (strong, nonatomic) NSArray *resData;

@property (weak, nonatomic) IBOutlet UISegmentedControl *chatSegment;

- (IBAction)chatSelectedSegment:(id)sender;

@end
