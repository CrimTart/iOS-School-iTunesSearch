//
//  SBTCell.h
//  iTunesSearch
//
//  Created by Admin on 22.05.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
#import "SBTSong.h"
@import UIKit;

extern NSString *const SBTCellIdentifier;

@interface SBTCell : UITableViewCell

- (void)addSong:(SBTSong *)song;

@end
