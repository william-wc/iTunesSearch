//
//  MainTableViewController.m
//  iTunesSearch
//
//  Created by William Hong Jun Cho on 3/14/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "MainTableViewController.h"
#import "SearchData.h"
#import "iTunesManager.h"
#import "TableViewCell.h"


@interface MainTableViewController ()

@end

@implementation MainTableViewController {
    iTunesManager *itunes;
    SearchData *midiaData;
    
    NSArray *MIDIA_TYPES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MIDIA_TYPES = [NSArray arrayWithObjects:@"all",@"movie",@"ebook",@"song",@"podcast", nil];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    itunes = [iTunesManager sharedInstance];
    
    [_btnSearch setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
    [_txtSearch setDelegate:self];
    [_tableView setDelegate:self];
    
    [_scControl addTarget:self action:@selector(onSCValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_scControl removeAllSegments];
    for (int i = 0; i < MIDIA_TYPES.count; i++) {
        [_scControl insertSegmentWithTitle:NSLocalizedString(MIDIA_TYPES[i], nil) atIndex:i animated:NO];
    }
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return MIDIA_TYPES.count - 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return MIDIA_TYPES[section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //todo optimize
    return [midiaData getArrayByKind:MIDIA_TYPES[section]].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    [cell.name setText:@"name"];
    [cell.kind setText:@"kind"];
    
    return cell;
}

#pragma mark - UI events
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9a-zA-Z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger matches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
    return (matches > 0);
}

- (IBAction)onBtnSearch:(id)sender {
    NSString *value = _txtSearch.text;
    if(value && value.length > 0) {
        midiaData = [itunes buscarMidias:value];
        [_scControl setSelectedSegmentIndex:0];
        //[_tableView reloadData];
    }
}

-(void)onSCValueChanged:(UISegmentedControl *)segment {
    
}



@end
