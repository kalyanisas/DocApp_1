//
//  ChatTVC.m
//  App2807_1
//
//  Created by Kalyani on 19/12/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "ChatTVC.h"

@interface ChatTVC ()

@end

@implementation ChatTVC

- (void)viewDidLoad {
    [super viewDidLoad];
        
}



#pragma mark - Table view data source

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

@end
