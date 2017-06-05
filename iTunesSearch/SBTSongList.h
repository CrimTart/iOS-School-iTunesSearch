//
//  SBTSongList.h
//  iTunesSearch
//
//  Created by Admin on 22.05.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBTSong.h"

@interface SBTSongList : NSObject

@property(nonatomic, copy, readwrite) NSArray *songs;

- (instancetype)initWithArray:(NSArray<SBTSong *> *)songs;
- (NSUInteger)count;
- (SBTSong*)objectAtIndexedSubscript:(NSUInteger)index;

@end
