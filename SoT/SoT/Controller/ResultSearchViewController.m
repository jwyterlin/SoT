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

@interface ResultSearchViewController()<UITableViewDataSource,UITableViewDelegate,CellHelperDelegate,TopSearchBarViewDelegate,TweetCellDelegate>

// UI
@property(nonatomic,strong) TopSearchBarView *topView;
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray *tweetsFound;
@property(nonatomic,strong) NSString *termSearched;

@end

@implementation ResultSearchViewController

#pragma mark - View Lifecycle

-(id)initWithTweetsFound:(NSArray *)tweetsFound termSearched:(NSString *)termSearched {
    
    self = [super init];
    
    if ( self ) {
        self.tweetsFound = tweetsFound;
        self.termSearched = [NSString stringWithFormat:@"\"%@\"",termSearched];
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

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // Adjust components
    [self.topView updateWidth:size.width];
    self.tableView.width = size.width;
    self.tableView.height = size.height - self.topView.height;
    
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetsFound.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetModel *tweetModel = self.tweetsFound[indexPath.row];
    return [[TweetCell new] tweetCellAtIndexPath:indexPath tableView:tableView tweet:tweetModel delegate:self];
    
}

#pragma mark - UITableViewDelegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = [[CellHelper new] heightForCellAtIndexPath:indexPath tableView:tableView cellIdentifier:kNibNameTweetCell delegate:self];
    
    return height;
    
}

#pragma mark - CellHelperDelegate Methods

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *customCell = (TweetCell *)cell;
    
    TweetModel *tweetModel = self.tweetsFound[indexPath.row];
    
    [customCell configureTweetCell:customCell atIndexPath:indexPath tableView:self.tableView tweet:tweetModel delegate:self];
    
}

#pragma mark - TopSearchBarViewDelegate methods

-(void)tsbv_didPressCloseButton {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - TweetCellDelegate methods

-(UIViewController *)tc_viewControllerToShare {
    return self;
}

#pragma mark - Creating components

-(TopSearchBarView *)topView {
    
    if ( ! _topView ) {
        _topView = [TopSearchBarView new];
        _topView.delegateTopSearchBarView = self;
        [_topView updateTitle:self.termSearched];
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
