//
//  iTunesManager.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchData.h"

@interface iTunesManager : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (iTunesManager*)sharedInstance;

- (SearchData *)buscarMidias:(NSString *)termo;

@end
