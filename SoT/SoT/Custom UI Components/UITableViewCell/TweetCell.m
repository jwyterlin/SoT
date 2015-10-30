//
//  TweetCell.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "TweetCell.h"
#import "CellLabel.h"

// DAO
#import "ImageDAO.h"

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
    [self configureTweetCell:cell atIndexPath:indexPath tableView:tableView tweet:tweet];
    
    return cell;
    
}

-(void)configureTweetCell:(TweetCell *)cell
              atIndexPath:(NSIndexPath *)indexPath
                tableView:(UITableView *)tableView
                    tweet:(TweetModel *)tweet {
    
    if ( tweet == nil ) {
        
        cell.userName.text = @"";
        cell.tweetContent.text = @"";
        
        return;
        
    }
    
    cell.userPhoto.layer.cornerRadius = cell.userPhoto.width/2;
    cell.userPhoto.layer.masksToBounds = YES;
    cell.userPhoto.backgroundColor = [UIColor blackColor];
    
    cell.userName.text = tweet.userName;
    cell.tweetContent.text = tweet.detail;
    
    int rightWidth = tableView.width - cell.tweetContent.x - 66;
    
    if ( cell.tweetContentWidth.constant != rightWidth ) {
        cell.tweetContentWidth.constant = rightWidth;
    }
    
    [cell.tweetContent setNeedsUpdateConstraints];
    
    [cell defineUserPhotoWithTweet:tweet tableView:tableView indexPath:indexPath tweetCell:cell];
    
}

-(void)defineUserPhotoWithTweet:(TweetModel *)tweetModel
                      tableView:(UITableView *)tableView
                      indexPath:(NSIndexPath *)indexPath
                      tweetCell:(TweetCell *)tweetCell {
    
    if ( tweetModel.image ) {
        
        tweetCell.userPhoto.image = [UIImage imageWithData:tweetModel.image];
        return ;
        
    }
    
    tweetCell.userPhoto.image = nil;
    
    [[ImageDAO new] imageByUrl:tweetModel.imageUrl completion:^(UIImage *image) {
        
        TweetCell *helperCell = (TweetCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if ( helperCell ) {
            
            if ( image ) {
                
                tweetModel.image = UIImageJPEGRepresentation(image, 1.0);
                helperCell.userPhoto.image = image;
                
            }
            
        }
        
    }];
    
}

@end
