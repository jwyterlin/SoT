//
//  TweetCell.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericTableViewCell.h"

// Model
#import "TweetModel.h"

// Pods
#import "SWTableViewCell.h"

@protocol TweetCellDelegate;

@interface TweetCell : SWTableViewCell

@property(nonatomic,weak) id<TweetCellDelegate> delegateTweetCell;

-(TweetCell *)tweetCellAtIndexPath:(NSIndexPath *)indexPath
                         tableView:(UITableView *)tableView
                             tweet:(TweetModel *)tweet
                          delegate:(id<TweetCellDelegate>)delegate;

-(void)configureTweetCell:(TweetCell *)cell
              atIndexPath:(NSIndexPath *)indexPath
                tableView:(UITableView *)tableView
                    tweet:(TweetModel *)tweet
                 delegate:(id<TweetCellDelegate>)delegate;

@end

@protocol TweetCellDelegate <NSObject>

-(UIViewController *)tc_viewControllerToShare;

@end