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

@interface TweetCell : GenericTableViewCell

-(TweetCell *)tweetCellAtIndexPath:(NSIndexPath *)indexPath
                         tableView:(UITableView *)tableView
                             tweet:(TweetModel *)tweet;

-(void)configureTweetCell:(TweetCell *)cell
              atIndexPath:(NSIndexPath *)indexPath
                tableView:(UITableView *)tableView
                    tweet:(TweetModel *)tweet;

@end
