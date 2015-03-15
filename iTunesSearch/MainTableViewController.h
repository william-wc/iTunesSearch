//
//  MainTableViewController.h
//  iTunesSearch
//
//  Created by William Hong Jun Cho on 3/14/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
- (IBAction)onBtnSearch:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
