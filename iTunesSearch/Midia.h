//
//  Midia.h
//  iTunesSearch
//
//  Created by William Hong Jun Cho on 3/12/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Midia : NSObject

@property (nonatomic, strong) NSString *kind;
@property (nonatomic, strong) NSString *trackId;
@property (nonatomic, strong) NSString *trackName;
@property (nonatomic, strong) NSString *trackPrice;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *primaryGenreName;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *artworkUrl;


@end
