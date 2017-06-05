//
//  SBTNetworkData.h
//  iTunesSearch
//
//  Created by Admin on 22.05.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBTSongData.h"

@interface SBTNetworkSongData : NSObject<SBTSongDataSource, NSURLSessionDelegate>

- (SBTSongList *)getSongs:(NSString *)artist withUpdate:(SBTSongList *)songs;

@end
