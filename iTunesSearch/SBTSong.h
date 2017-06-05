//
//  SBTSong.h
//  iTunesSearch
//
//  Created by Admin on 22.05.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBTSong : NSObject

@property (nonatomic, strong) NSString *songName;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *album;
@property (nonatomic, strong) NSString *pictureURL;
@property (nonatomic, strong) NSString *price;

@end
