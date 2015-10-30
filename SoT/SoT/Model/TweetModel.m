//
//  TweetModel.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "TweetModel.h"

@implementation TweetModel

-(TweetModel *)setupWithJson:(NSDictionary *)j {
    
    if ( ! [Validator validateObject:j] )
        return nil;
    
    TweetModel *t = [TweetModel new];
    
    NSDictionary *user = j[kTweetUser];
    
    t.identifier = [NSNumber numberWithLongLong:[j[kTweetIdentifier] longLongValue]];
    t.userName = user[kTweetUserName];
    t.imageUrl = user[kTweetUserProfileImageUrl];
    t.detail = j[kTweetText];
    
    return t;
    
}

@end
