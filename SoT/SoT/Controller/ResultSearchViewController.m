//
//  ResultSearchViewController.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ResultSearchViewController.h"

// Custom UI Components
#import "UITableView+Helper.h"
#import "TopSearchBarView.h"
#import "TweetCell.h"

// Service Layer
#import "CellHelper.h"

@interface ResultSearchViewController()<UITableViewDataSource,UITableViewDelegate,CellHelperDelegate,TopSearchBarViewDelegate>

// UI
@property(nonatomic,strong) TopSearchBarView *topView;
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *tweetsFound;

@end

@implementation ResultSearchViewController

#pragma mark - View Lifecycle

-(id)initWithTweetsFound:(NSArray *)tweetsFound {
    
    self = [super init];
    
    if ( self ) {
        self.tweetsFound = tweetsFound;
    }
    
    return self;
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1 + self.tweetsFound.count;
    return self.tweetsFound.count; // Just to test tweets's list
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetModel *tweetModel = self.tweetsFound[indexPath.row];
    return [[TweetCell new] tweetCellAtIndexPath:indexPath tableView:tableView tweet:tweetModel];
    
}

#pragma mark - UITableViewDelegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = [[CellHelper new] heightForCellAtIndexPath:indexPath tableView:tableView cellIdentifier:kNibNameTweetCell delegate:self];
    
    return height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

#pragma mark - CellHelperDelegate Methods

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *customCell = (TweetCell *)cell;
    
    TweetModel *tweetModel = self.tweetsFound[indexPath.row];
    
    [customCell configureTweetCell:customCell atIndexPath:indexPath tweet:tweetModel];
    
}

#pragma mark - TopSearchBarViewDelegate methods

-(void)tsbv_didPressCloseButton {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Creating components

-(TopSearchBarView *)topView {
    
    if ( ! _topView ) {
        _topView = [TopSearchBarView new];
        _topView.delegateTopSearchBarView = self;
    }
    
    return _topView;
    
}

-(UITableView *)tableView {
    
    if ( ! _tableView ) {
        
        CGFloat y = self.topView.y+self.topView.height;
        
        _tableView = [[UITableView alloc] initWithFrame: CGRectMake( 0, y, [DeviceInfo width], [DeviceInfo height]-y ) ];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerNibForCellReuseIdentifier:kNibNameTweetCell];
        [_tableView removeSeparator];
        
    }
    
    return _tableView;
    
}

@end
