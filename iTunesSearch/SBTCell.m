//
//  SBTCell.m
//  iTunesSearch
//
//  Created by Admin on 22.05.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "SBTCell.h"
#import "SBTSong.h"
#import "Masonry.h"

NSString *const SBTCellIdentifier = @"SBTCellIdentifier";

@interface SBTCell ()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *artist;
@property (nonatomic, strong) UIImageView *songImage;
@property (nonatomic, strong) UILabel *price;

@end

@implementation SBTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self createSubviews];
    }
    return self;
}

- (void)addSong:(SBTSong *)song {
    self.name.text = song.songName;
    self.artist.text = song.artist;
    self.price.text = song.price.description;
    
    NSString *initUrl = song.pictureURL ? song.pictureURL : @"https://upload.wikimedia.org/wikipedia/en/9/98/Sandstorm_single.jpg";
    [self loadImage:initUrl];
}

- (void)loadImage:(NSString *)url {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSURL *imageURL = [NSURL URLWithString:url];
                       __block NSData *imageData;
                       
                       dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                                     ^{
                                         imageData = [NSData dataWithContentsOfURL:imageURL];
                                         dispatch_sync(dispatch_get_main_queue(), ^{
                                             __strong typeof(self) strongSelf = weakSelf;
                                             if (strongSelf) {
                                                 strongSelf.songImage.image = [UIImage imageWithData:imageData];
                                             }
                                         });
                                     });
                   });
}

- (void)createSubviews {
    self.name = [UILabel new];
    self.artist = [UILabel new];
    self.songImage = [UIImageView new];
    self.price = [UILabel new];
    
    self.songImage.layer.cornerRadius = self.frame.size.height / 2;
    self.songImage.clipsToBounds = YES;
    
    [self addSubview:self.name];
    [self addSubview:self.artist];
    [self addSubview:self.songImage];
    [self addSubview:self.price];
    
    [self.songImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.mas_top).with.offset(3);
        make.width.equalTo(@40);
        make.bottom.equalTo(self.mas_bottom).with.offset(-3);
        make.height.equalTo(@40);
    }];
    
    [self.name setTextAlignment:NSTextAlignmentCenter];
    [self.artist setTextAlignment:NSTextAlignmentCenter];
    [self.price setTextAlignment:NSTextAlignmentCenter];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.songImage.mas_right).with.offset(10);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.artist.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.greaterThanOrEqualTo(@100).with.priorityHigh();//?????
    }];
    
    [self.artist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(self.name.mas_width);
        make.top.equalTo(self.mas_top);
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.artist.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(@50);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right).with.offset(-10);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
