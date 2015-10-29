//
//  TweetCell.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "TweetCell.h"
#import "CellLabel.h"

@interface TweetCell()

@property(nonatomic,strong) IBOutlet UIImageView *userPhoto;
@property(nonatomic,strong) IBOutlet UILabel *userName;
@property(nonatomic,strong) IBOutlet CellLabel *tweetContent;

// Constraints
@property(nonatomic,strong) IBOutlet NSLayoutConstraint *tweetContentWidth;

@end

@implementation TweetCell

-(TweetCell *)tweetCellAtIndexPath:(NSIndexPath *)indexPath
                           tableView:(UITableView *)tableView
                               tweet:(TweetModel *)tweet {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:kNibNameTweetCell forIndexPath:indexPath];
    [self configureTweetCell:cell atIndexPath:indexPath tweet:tweet];
    
    return cell;
    
}

-(void)configureTweetCell:(TweetCell *)cell
              atIndexPath:(NSIndexPath *)indexPath
                    tweet:(TweetModel *)tweet {
    
    if ( tweet == nil ) {
        
        cell.userName.text = @"";
        cell.tweetContent.text = @"";
        
        return;
        
    }
    
    cell.userPhoto.layer.cornerRadius = cell.userPhoto.width/2;
    cell.userPhoto.backgroundColor = [UIColor blackColor];
    
    cell.userName.text = tweet.userName;
    cell.tweetContent.text = tweet.detail;
    
    int rightWidth = [DeviceInfo width] - cell.tweetContent.x - 66;
    
    if ( cell.tweetContentWidth.constant != rightWidth ) {
        cell.tweetContentWidth.constant = rightWidth;
    }
    
    [cell.tweetContent setNeedsUpdateConstraints];
    
}

@end
