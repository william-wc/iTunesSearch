//
//  SearchViewController.m
//  iTunesSearch
//
//  Created by William Hong Jun Cho on 3/10/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onBtnSearch:(id)sender {
    NSString *value = _txtSearchValue.text;
    
    SearchData *data = [[SearchData alloc] init];
    data.value = value;
    
    [self.navigationController pushViewController:[[TableViewController alloc]init] animated:YES];
}

@end
