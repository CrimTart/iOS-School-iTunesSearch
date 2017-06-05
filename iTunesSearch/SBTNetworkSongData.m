//
//  SBTNetworkData.m
//  iTunesSearch
//
//  Created by Admin on 22.05.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "SBTNetworkSongData.h"
#import "SBTSongList.h"

@implementation SBTNetworkSongData

- (SBTSongList *)getSongs:(NSString *)artist withUpdate:(SBTSongList *)songs {
    if (artist == nil )
        artist = @"";
    __block NSMutableArray *searchResult = [NSMutableArray new];
    
    NSString *stringWithoutArtist = @"https://itunes.apple.com/search?term=";
    NSString *stringWithArtist = [stringWithoutArtist stringByAppendingString:artist];
    NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:stringWithArtist]];
    
    __block NSData *responseData = [NSURLConnection sendSynchronousRequest:nsurlRequest returningResponse:nil error:nil];
    
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration
                                          delegate:self
                                          delegateQueue:[NSOperationQueue mainQueue]];
    
    [[session dataTaskWithRequest:nsurlRequest
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    responseData = data;
                }] resume];

    NSDictionary *JSONObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    
    SBTSong* (^createSong)(NSString *, NSString *, NSString *, NSString *, NSString *);
    createSong = ^SBTSong*(NSString *songName,
                           NSString *artist,
                           NSString *album,
                           NSString *pictureURL,
                           NSString *price) {
        SBTSong *song = [SBTSong new];
        song.songName = songName;
        song.artist = artist;
        song.album = album;
        song.pictureURL = pictureURL;
        song.price = price;
        return song;
    };
    
    NSDictionary *songsDict = [JSONObject objectForKey:@"results"];
    
    for (NSDictionary * object in songsDict ) {
        NSString *songName = [object objectForKey:@"trackName"];
        NSString *artist = [object objectForKey:@"artistName"];
        NSString *album = [object objectForKey:@"collectionName"];
        NSString *pictureURL = [object objectForKey:@"artworkUrl60"];
        NSString *price = [object objectForKey:@"trackPrice"];
        
        [searchResult addObject:createSong(songName, artist, album, pictureURL, price)];
    }
    
    return [[SBTSongList alloc] initWithArray:searchResult];
}

@end
