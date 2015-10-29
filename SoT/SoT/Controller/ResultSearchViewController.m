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
#import "TweetCell.h"

@interface ResultSearchViewController()<UITableViewDataSource,UITableViewDelegate>

// UI
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *tweetsFound;

@end

@implementation ResultSearchViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 + self.tweetsFound.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetModel *tweetModel = self.tweetsFound[indexPath.row];
    return [[TweetCell new] tweetCellAtIndexPath:indexPath tableView:tableView tweet:tweetModel];
    
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

#pragma mark - Creating components

-(UITableView *)tableView {
    
    if ( ! _tableView ) {
        
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerNibForCellReuseIdentifier:kNibNameTweetCell];
        
    }
    
    return _tableView;
    
}

@end
