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

@property(nonatomic,strong) IBOutlet UIImageView *userPhoto;
@property(nonatomic,strong) IBOutlet UILabel *userName;
@property(nonatomic,strong) IBOutlet CellLabel *tweetContent;

// Constraints
@property(nonatomic,strong) IBOutlet NSLayoutConstraint *tweetContentWidth;
@property(nonatomic,strong) IBOutlet NSLayoutConstraint *userPhotoLeading;

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
    }
    
    [cell.tweetContent setNeedsUpdateConstraints];
    
    [cell defineUserPhotoWithTweet:tweet tableView:tableView indexPath:indexPath tweetCell:cell];
    
    cell.leftUtilityButtons = [cell leftButtons];
    cell.delegate = cell;
    
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

-(NSArray *)leftButtons {
    
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:90.0/256.0 green:160.0/256.0 blue:198.0/256.0 alpha:1.0f]
                                          normalIcon:[UIImage imageNamed:@"botao_generico_off"]
                                        selectedIcon:[UIImage imageNamed:@"botao_generico_on"]];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:90.0/256.0 green:160.0/256.0 blue:198.0/256.0 alpha:1.0f]
                                          normalIcon:[UIImage imageNamed:@"botao_generico_off"]
                                        selectedIcon:[UIImage imageNamed:@"botao_generico_on"]];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:90.0/256.0 green:160.0/256.0 blue:198.0/256.0 alpha:1.0f]
                                          normalIcon:[UIImage imageNamed:@"botao_generico_off"]
                                        selectedIcon:[UIImage imageNamed:@"botao_generico_on"]];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:90.0/256.0 green:160.0/256.0 blue:198.0/256.0 alpha:1.0f]
                                          normalIcon:[UIImage imageNamed:@"botao_generico_off"]
                                        selectedIcon:[UIImage imageNamed:@"botao_generico_on"]];
    
    return leftUtilityButtons;
    
}

#pragma mark - SWTableViewDelegate methods

-(void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state {
    
    switch (state) {
        case kCellStateCenter:
            NSLog( @"utility buttons closed" );
            break;
        case kCellStateLeft:
            NSLog( @"left utility buttons open" );
            break;
        case kCellStateRight:
            NSLog( @"right utility buttons open" );
            break;
        default:
            break;
    }
    
}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    
    switch (index) {
            
        case 0: {
            NSLog(@"Pressed 0");
            break;
        } case 1: {
            NSLog(@"Pressed 1");
            break;
        } case 2: {
            NSLog(@"Pressed 2");
            break;
        } case 3: {
            NSLog(@"Pressed 3");
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
