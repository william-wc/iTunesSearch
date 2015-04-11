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
#import "MidiaDetailViewController.h"


@interface MainTableViewController ()

@end

@implementation MainTableViewController {
    iTunesManager *itunes;
    SearchData *midiaData;
    NSArray *currentMidiaList;
    NSUserDefaults *uData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    itunes = [iTunesManager sharedInstance];
    uData = [NSUserDefaults standardUserDefaults];
    
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    [_btnSearch setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
    [_txtSearch setDelegate:self];
    [_tableView setDelegate:self];

    [_scControl removeAllSegments];
    [_scControl addTarget:self action:@selector(onSCValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    NSString *lastSearch = [uData stringForKey:@"lastSearch"];
    if(lastSearch && lastSearch.length > 0) {
        [_txtSearch setText:lastSearch];
        [self searchFor:lastSearch];
    }
}

-(void)searchFor:(NSString *)value {
    midiaData = [itunes buscarMidias:value];
    
    [_scControl removeAllSegments];
    for (int i = 0; i < midiaData.midiaTypes.count; i++) {
        [_scControl insertSegmentWithTitle:NSLocalizedString(midiaData.midiaTypes[i], nil) atIndex:i animated:YES];
    }
    [_scControl setSelectedSegmentIndex:0];
    [self onSCValueChanged:_scControl];
    
    [uData setValue:value forKey:@"lastSearch"];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(midiaData.midiaTypes[section], nil);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return currentMidiaList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"celulaPadrao"];

    Midia *midia = currentMidiaList[indexPath.row];
    
    [cell.name setText:midia.trackName];
    [cell.kind setText:NSLocalizedString(midia.kind, nil)];
    [cell.genero setText:midia.primaryGenreName];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:midia.artworkUrl]];
        if(data) {
            UIImage *img = [UIImage imageWithData:data];
            if(img) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell.imgPreview setImage:img];
                });
            }
        }
    });
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MidiaDetailViewController *vc = [[MidiaDetailViewController alloc] init];
    [vc setMidia:currentMidiaList[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
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
        [self searchFor:value];
    }
}

-(void)onSCValueChanged:(UISegmentedControl *)segment {
    currentMidiaList = [midiaData getArrayByKind:midiaData.midiaTypes[_scControl.selectedSegmentIndex]];
    [_tableView reloadData];
}



@end
