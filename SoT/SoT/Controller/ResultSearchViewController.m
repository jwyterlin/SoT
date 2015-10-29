//
//  ResultSearchViewController.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ResultSearchViewController.h"

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
    
    return [UITableViewCell new];
    
}

#pragma mark - UITableViewDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

@end
