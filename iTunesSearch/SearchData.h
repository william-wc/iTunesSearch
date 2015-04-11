//
//  SearchData.h
//  iTunesSearch
//
//  Created by William Hong Jun Cho on 3/10/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Midia.h"
#import "Filme.h"
#import "EBook.h"
#import "Musica.h"
#import "Podcast.h"

@interface SearchData : NSObject

-(id)initWithResults:(NSArray *)results;
-(void)addData:(Midia *)midia;
-(NSArray *)getArrayByKind:(NSString *)kind;

@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonatomic, strong) NSMutableArray *midiaTypes;

@end
