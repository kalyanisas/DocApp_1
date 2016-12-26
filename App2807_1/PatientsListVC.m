//
//  PatientsListViewController.m
//  App2807_1
//
//  Created by Kalyani on 28/07/16.
//  Copyright © 2016 Olivo. All rights reserved.
//

#import "PatientsListVC.h"

@interface PatientsListVC () <NewPatientVCDelegate>

@property (strong, nonatomic) NSMutableArray *patientNamesList;
@property (strong, nonatomic) NSMutableArray *patientPhoneList;


@end

@implementation PatientsListVC






-(NSMutableArray *) patientNamesList
{
    if(!_patientNamesList)
    {
        _patientNamesList = [[NSMutableArray alloc]init];
    }
    return _patientNamesList;
}

-(NSMutableArray *) patientPhoneList
{
    if(!_patientPhoneList)
    {
        _patientPhoneList = [[NSMutableArray alloc]init];
    }
    return _patientPhoneList;
}

- (void)viewDidLoad {
    
      self.patientNamesList = [NSMutableArray arrayWithObjects: @"Sakhi Mishra",@"Sourav Menon",@"Amar Nath",@"Dhamini Srikar",@"Swathi Kiran",@"Rakhi Mishra", nil];
    self.patientPhoneList = [NSMutableArray arrayWithObjects:@"9000999731", @"9000999732", @"7207627801", @"9032853439", @"9032853438", @"9000999736", nil];
    
    [super viewDidLoad];

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
     NSLog(@"segue %@ ", [segue identifier]);
    
    if ([[segue identifier] isEqualToString:@"visitsSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
      //  NSString *selectedPatient =[[[self.tableView cellForRowAtIndexPath:indexPath] textLabel] text];
        VisitsTVC *plvc = [segue destinationViewController];
       
        plvc.rowVar = indexPath.row;
        NSLog(@"Patient selected %ld ", (long)indexPath.row);
       
        
    }
    if([[segue identifier ]isEqualToString:@"patientsListSegue"])
    {
        [(NewPatientVC *)segue.destinationViewController setDelegate:self];
    }
}
    /*else if ([[segue identifier] isEqualToString:@"msg2Segue"]) {
        msg2ViewController *m2vc = [segue destinationViewController];
        m2vc.msg2 = @"msg2";
        NSLog(@"Msg2");
    }
    */

-(void) dismissAddContactVC
{
    NSLog(@"in func dismissAdd");
    [self dismissViewControllerAnimated:YES completion:nil ];
}

-(void) addPatientName:(NSString *)name phone:(NSString *)phone
{
    NSLog(@"in func addPatient");
    [self.patientNamesList addObject:name];
    [self.patientPhoneList addObject:phone];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil ];
    
    
}

#pragma mark - Table view data source
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.patientNamesList.count;
}
    
    
    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
    (NSIndexPath *)indexPath {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                                forIndexPath:indexPath];
        
        if( cell == nil)
        {
            cell = [[UITableViewCell alloc]init];
        }
        cell.textLabel.text = [self.patientNamesList objectAtIndex:indexPath.row];
        cell.detailTextLabel.text =  [self.patientPhoneList objectAtIndex:indexPath.row];
        

        //  UIImage *img = [UIImage imageNamed:@"first.png"];
        // cell.imageView.image = img;
        // UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,logoCell.frame.size.width,80)];
        return cell;
    }
    
    -(IBAction)unWindToMain:(UIStoryboardSegue *)segue
    
    {
        
    }
    
    -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
       // rowTemp = indexPath.row;
        NSLog(@"selected row : %ld", indexPath.row);
        
    }



@end
