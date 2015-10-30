//
//  Constants.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Constants : NSObject

// UITableViewCell Nib Names
extern NSString *const kNibNameTweetCell;

extern const int RECENT_SEARCH_BUTTONS_LIMIT;
extern const int TRENDING_NOW_BUTTONS_LIMIT;
extern const int SEARC_TERMS_LIMIT;

extern const CGFloat WIDTH_SUBCOLUMNS_MAIN_VIEW_FOR_IPAD;
extern const CGFloat WIDTH_SUBCOLUMNS_MAIN_VIEW_FOR_IPHONE;

// Trending
extern NSString *const kTrendingName;
extern NSString *const kTrendingPromotedContent;
extern NSString *const kTrendingQuery;
extern NSString *const kTrendingUrl;

// Tweet
extern NSString *const kTweetIdentifier;
extern NSString *const kTweetUser;
extern NSString *const kTweetUserName;
extern NSString *const kTweetUserProfileImageUrl;
extern NSString *const kTweetText;

@end
