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
    
    // Fake data
    TweetModel *t1 = [TweetModel new];
    t1.identifier = [NSNumber numberWithInt:1];
    t1.userName = @"Arthur Price";
    t1.detail = @"Hey @getblogo team! It was really really great to see you again earlier. Let's definitely get that coffee sometime next week...";
    
    TweetModel *t2 = [TweetModel new];
    t2.identifier = [NSNumber numberWithInt:2];
    t2.userName = @"Shirley Ramirez";
    t2.detail = @"Keytar McSweeney's Williamsburg, readymade leggings try-hard 90's street art letterpress hoodie occupy Wes Anderson Banksy. Asymmet.";
    
    TweetModel *t3 = [TweetModel new];
    t3.identifier = [NSNumber numberWithInt:3];
    t3.userName = @"Dennis Edwards";
    t3.detail = @"Banjo tote bag bicycle rights, High Life sartorial cray craft beer whatever street art fap. Hashtag typewriter banh mi, squid keffi.";
    
    TweetModel *t4 = [TweetModel new];
    t4.identifier = [NSNumber numberWithInt:4];
    t4.userName = @"Hannah Ramirez";
    t4.detail = @"Kogi Cosby sweater ethical squid irony disrupt, organic tote bag gluten-free XOXO wolf typewriter mixtape small batch. DIY pickled.";
    
    TweetModel *t5 = [TweetModel new];
    t5.identifier = [NSNumber numberWithInt:5];
    t5.userName = @"Dennis Edwards";
    t5.detail = @"Banjo tote bag bicycle rights, High Life sartorial cray craft beer whatever street art fap. Hashtag typewriter banh mi, squid keffi.";
    
    self.tweetsFound = @[t1,t2,t3,t4,t5];
    
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
        
        _tableView = [[UITableView alloc] initWithFrame: CGRectMake( 0, 0, [DeviceInfo width], [DeviceInfo height] ) ];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerNibForCellReuseIdentifier:kNibNameTweetCell];
        
    }
    
    return _tableView;
    
}

@end
