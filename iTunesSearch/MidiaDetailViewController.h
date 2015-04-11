//
//  MidiaDetailViewController.h
//  iTunesSearch
//
//  Created by William Hong Jun Cho on 4/11/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Midia.h"

@interface MidiaDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *textTitle;
@property (weak, nonatomic) IBOutlet UITextView *textWall;
@property (weak, nonatomic) IBOutlet UIImageView *imgPreview;

-(void)setMidia:(Midia *)m;

@end
