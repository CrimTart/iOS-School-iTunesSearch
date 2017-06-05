//
//  SBTSongList.m
//  iTunesSearch
//
//  Created by Admin on 22.05.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "SBTSongList.h"

@implementation SBTSongList

- (instancetype)initWithArray:(NSArray<SBTSong *> *)songs {
    self = [super init];
    if (self) {
        _songs = songs;
    }
    return self;
}

- (NSUInteger)count {
    return self.songs.count;
}

- (SBTSong *)objectAtIndexedSubscript:(NSUInteger)index {
    return self.songs[index];
}

@end
