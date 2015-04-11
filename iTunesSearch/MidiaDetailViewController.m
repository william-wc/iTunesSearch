//
//  MidiaDetailViewController.m
//  iTunesSearch
//
//  Created by William Hong Jun Cho on 4/11/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "MidiaDetailViewController.h"
#import "Midia.h"

@implementation MidiaDetailViewController {
    Midia *midia;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.textTitle.text = NSLocalizedString(midia.trackName, nil);
    self.textWall.text = [NSString stringWithFormat:@"%@\n%@\n%@ %@",
                          midia.primaryGenreName,
                          midia.artistName,
                          midia.currency, midia.trackPrice];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:midia.artworkUrl]];
        if(data) {
            UIImage *img = [UIImage imageWithData:data];
            if(img) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.imgPreview setImage:img];
                });
            }
        }
    });
}

-(void) setMidia:(Midia *)m {
    midia = m;
}

@end
