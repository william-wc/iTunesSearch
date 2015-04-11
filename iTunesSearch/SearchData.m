//
//  SearchData.m
//  iTunesSearch
//
//  Created by William Hong Jun Cho on 3/10/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "SearchData.h"

@implementation SearchData {
}

@synthesize data, midiaTypes;

-(id)init {
    self = [super init];
    if(self) {
        midiaTypes = [[NSMutableArray alloc]init];
        data = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(id)initWithResults:(NSArray *)results {
    self = [super init];
    if(self) {
        midiaTypes = [[NSMutableArray alloc]init];
        data = [[NSMutableDictionary alloc] init];
        
        for (NSDictionary *item in results) {
            NSString *itemKind = [item objectForKey:@"kind"];
            
            Midia *midia = nil;
            
            //todo add regex
            if([itemKind isEqualToString:@"feature-movie"]) {
                Filme *filme = [[Filme alloc] init];
                [filme setDuration:[item objectForKey:@"trackTimeMillis"]];
                midia = filme;
            } else if([itemKind isEqualToString:@"song"]) {
                Musica *musica = [[Musica alloc] init];
                
                midia = musica;
            } else if([itemKind isEqualToString:@"podcast"]) {
                Podcast *podcast = [[Podcast alloc] init];
                
                midia = podcast;
            } else if([itemKind isEqualToString:@"ebook"]) {
                EBook *ebook = [[EBook alloc]init];
                
                midia = ebook;
            }
            
            if(midia) {
                NSString *kind = [item objectForKey:@"kind"];
                
                [midia setKind          :[item objectForKey:@"kind"]];
                [midia setTrackName     :[item objectForKey:@"trackName"]];
                [midia setTrackId       :[item objectForKey:@"trackId"]];
                [midia setTrackPrice    :[item objectForKey:@"trackPrice"]];
                [midia setArtistName    :[item objectForKey:@"artistName"]];
                [midia setPrimaryGenreName:[item objectForKey:@"primaryGenreName"]];
                [midia setCountry       :[item objectForKey:@"country"]];
                [midia setCurrency      :[item objectForKey:@"currency"]];
                [midia setArtworkUrl    :[item objectForKey:@"artworkUrl100"]];
                
                if(![midiaTypes containsObject:kind])
                    [midiaTypes addObject:kind];
                
                NSMutableArray *array = [data objectForKey:kind];
                if(!array) {
                    array = [[NSMutableArray alloc] init];
                    [data setObject:array forKey:kind];
                }
                [array addObject:midia];
            }
        }
    }
    return self;
}

-(void)addData:(Midia *)midia {
    
}

-(NSArray *)getArrayByKind:(NSString *)kind {
    return [data objectForKey:kind];
}

@end
