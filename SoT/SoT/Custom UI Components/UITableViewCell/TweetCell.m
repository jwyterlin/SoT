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

@interface TweetCell()<SWTableViewCellDelegate>

/*!
 * @brief UIImageView to show the photo of the user
 */
@property(nonatomic,strong) IBOutlet UIImageView *userPhoto;

/*!
 * @brief Label to show the username
 */
@property(nonatomic,strong) IBOutlet UILabel *userName;

/*!
 * @brief Label to show the content of the tweet
 */
@property(nonatomic,strong) IBOutlet CellLabel *tweetContent;

// Constraints

/*!
 * @brief Constraint that determines the width of tweetContent
 */
@property(nonatomic,strong) IBOutlet NSLayoutConstraint *tweetContentWidth;

/*!
 * @brief Constraint that determines the space between the userPhoto and the left bound
 */
@property(nonatomic,strong) IBOutlet NSLayoutConstraint *userPhotoLeading;

/*!
 * @brief Constraint that determines the space between the username and the right bound
 */
@property(nonatomic,strong) IBOutlet NSLayoutConstraint *userNameTrailing;

@end

@implementation TweetCell

#pragma mark - Public methods

-(TweetCell *)tweetCellAtIndexPath:(NSIndexPath *)indexPath
                         tableView:(UITableView *)tableView
                             tweet:(TweetModel *)tweet
                          delegate:(id<TweetCellDelegate>)delegate {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:kNibNameTweetCell forIndexPath:indexPath];
    [self configureTweetCell:cell atIndexPath:indexPath tableView:tableView tweet:tweet delegate:delegate];
    
    return cell;
    
}

-(void)configureTweetCell:(TweetCell *)cell
              atIndexPath:(NSIndexPath *)indexPath
                tableView:(UITableView *)tableView
                    tweet:(TweetModel *)tweet
                 delegate:(id<TweetCellDelegate>)delegate {
    
    if ( tweet == nil ) {
        
        cell.userName.text = @"";
        cell.tweetContent.text = @"";
        
        return;
        
    }
    
    cell.delegateTweetCell = delegate;
    
    if ( [DeviceInfo isIphone] ) {
        cell.userName.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];
        cell.tweetContent.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
    }
    
    cell.userPhoto.layer.cornerRadius = cell.userPhoto.width/2;
    cell.userPhoto.layer.masksToBounds = YES;
    cell.userPhoto.backgroundColor = [UIColor blackColor];
    
    cell.userName.text = tweet.userName;
    cell.tweetContent.text = tweet.detail;
    
    if ( [DeviceInfo isIphone] ) {
        cell.userPhotoLeading.constant = 16;
        [cell.userPhoto setNeedsUpdateConstraints];
    }
    
    int rightWidth = tableView.width - cell.tweetContent.x - ( [DeviceInfo isIpad]?66:16 );
    
    if ( cell.tweetContentWidth.constant != rightWidth ) {
        cell.tweetContentWidth.constant = rightWidth;
        cell.userNameTrailing.constant = rightWidth;
    }
    
    [cell.tweetContent setNeedsUpdateConstraints];
    [cell.userName     setNeedsUpdateConstraints];
    
    [cell defineUserPhotoWithTweet:tweet tableView:tableView indexPath:indexPath tweetCell:cell];
    
    cell.leftUtilityButtons = [cell leftButtons];
    cell.delegate = cell;
    
}

#pragma mark - Private methods

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

-(NSArray *)leftButtons {
    
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:90.0/256.0 green:160.0/256.0 blue:198.0/256.0 alpha:1.0f]
                                                icon:[UIImage imageNamed:@"share.png"]];
    
    return leftUtilityButtons;
    
}

-(void)shareContent {
    
    NSString *message = self.tweetContent.text;
    UIImage *image = [UIImage imageNamed:@"botao_generico_on"];
    NSArray *shareItems = @[message, image];
    
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    UIViewController *vc = [self.delegateTweetCell tc_viewControllerToShare];
    
    [vc presentViewController:avc animated:YES completion:nil];
    
}

#pragma mark - SWTableViewDelegate methods

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    
    switch (index) {
            
        case 0: {
            [self shareContent];
            break;
        } default:
            break;
    }
    
}

-(BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    
    // allow just one cell's utility button to be open at once
    return YES;
    
}

-(BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state {
    
    switch (state) {
        case kCellStateLeft:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case kCellStateRight:
            // set to NO to disable all right utility buttons appearing
            return NO;
            break;
        default:
            break;
    }
    
    return YES;
    
}

@end
