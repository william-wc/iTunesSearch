//
//  SearchViewController.h
//  iTunesSearch
//
//  Created by William Hong Jun Cho on 3/10/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SearchData.h"
#import "TableViewController.h"

@interface SearchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtSearchValue;
- (IBAction)onBtnSearch:(id)sender;

@end
