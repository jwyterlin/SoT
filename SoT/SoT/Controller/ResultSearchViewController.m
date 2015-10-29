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

-(id)initWithTweetsFound:(NSArray *)tweetsFound {
    
    self = [super init];
    
    if ( self ) {
        self.tweetsFound = tweetsFound;
    }
    
    return self;
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
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
    return 165.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

#pragma mark - Creating components

-(UITableView *)tableView {
    
    if ( ! _tableView ) {
        
        _tableView = [[UITableView alloc] initWithFrame: CGRectMake( 0, 0, [DeviceInfo width], [DeviceInfo height] ) ];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerNibForCellReuseIdentifier:kNibNameTweetCell];
        [_tableView removeSeparator];
        
    }
    
    return _tableView;
    
}

@end
