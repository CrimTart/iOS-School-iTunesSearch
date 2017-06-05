//
//  SBTData.h
//  iTunesSearch
//
//  Created by Admin on 22.05.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SBTSongList;

@protocol SBTSongDataSource <NSObject>

@required

- (SBTSongList *)getSongs:(NSString *)artist withUpdate:(SBTSongList *)songs;

@end
