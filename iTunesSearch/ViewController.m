//
//  ViewController.m
//  iTunesSearch
//
//  Created by Admin on 22.05.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "ViewController.h"
#import "SBTSongList.h"
#import "SBTNetworkSongData.h"
#import "SBTSong.h"
#import "SBTCell.h"
#import "Masonry.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate,
                              UISearchResultsUpdating, UISearchBarDelegate> 

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SBTSongList *songs;
@property (nonatomic, strong) id<SBTSongDataSource> songManager;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.searchController = [UISearchController new];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"Search Here";
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(30);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.songManager = [SBTNetworkSongData new];
    NSString *text = self.searchController.searchBar.text;
    self.songs = [self.songManager getSongs:text withUpdate:self.songs];
    [self.tableView registerClass:[SBTCell class] forCellReuseIdentifier:SBTCellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.songs == nil) return 0;
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (SBTCell *)[tableView dequeueReusableCellWithIdentifier:SBTCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[SBTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SBTCellIdentifier];
    }
    SBTSong *song = [self.songs objectAtIndexedSubscript:indexPath.row];
    [(SBTCell *)cell addSong: song];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    self.songs=[self.songManager getSongs:searchString withUpdate:self.songs];
    [self.tableView reloadData];
}

@end
