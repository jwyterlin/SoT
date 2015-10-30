//
//  Constants.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "Constants.h"

#import "DeviceInfo.h"

@implementation Constants

// UITableViewCell Nib Names
NSString *const kNibNameTweetCell = @"TweetCell";

const int RECENT_SEARCH_BUTTONS_LIMIT = 5;
const int TRENDING_NOW_BUTTONS_LIMIT = 5;
const int SEARC_TERMS_LIMIT = 15;

const CGFloat WIDTH_SUBCOLUMNS_MAIN_VIEW_FOR_IPAD = 231;
const CGFloat WIDTH_SUBCOLUMNS_MAIN_VIEW_FOR_IPHONE = 180;

// Trending
NSString *const kTrendingName = @"name";
NSString *const kTrendingPromotedContent = @"promoted_content";
NSString *const kTrendingQuery = @"query";
NSString *const kTrendingUrl = @"url";

// Tweet
NSString *const kTweetIdentifier = @"id";
NSString *const kTweetUser = @"user";
NSString *const kTweetUserName = @"name";
NSString *const kTweetUserProfileImageUrl = @"profile_image_url_https";
NSString *const kTweetText = @"text";

@end
