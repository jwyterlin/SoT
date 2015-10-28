//
//  TrendingDAO.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "TrendingDAO.h"

@implementation TrendingDAO

// Trending Now

-(void)trendingNowWithCompletion:(void(^)(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error))completion {
    
    [self trendingNowWithCompletion:^(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error) {
        if ( completion ) {
            completion( tweetsFound, hasNoConnection, error );
        }
    } test:^(id responseData, NSError *error) {
        // Do nothing
    }];
    
}

-(void)trendingNowWithCompletion:(void(^)(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error))completion
             test:(void(^)(id responseData, NSError *error))test {
    
    NSArray *tweetsFound =  @[
                              @"Sub Celeb Yada Yada",
                              @"Quentin Tarantino Thurman",
                              @"Fuck South Corea in the arse",
                              @"Copa Libertadores",
                              @"Boobs = Love"
                              ];
    
    if (completion) {
        completion( tweetsFound, NO, NULL );
        return;
    }
    
}

@end
