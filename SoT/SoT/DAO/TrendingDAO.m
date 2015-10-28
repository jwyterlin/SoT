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

-(void)trendingNowWithCompletion:(void(^)(NSArray *trendingNowList, BOOL hasNoConnection, NSError *error))completion {
    
    [self trendingNowWithCompletion:^(NSArray *trendingNowList, BOOL hasNoConnection, NSError *error) {
        if ( completion ) {
            completion( trendingNowList, hasNoConnection, error );
        }
    } test:^(id responseData, NSError *error) {
        // Do nothing
    }];
    
}

-(void)trendingNowWithCompletion:(void(^)(NSArray *trendingNowList, BOOL hasNoConnection, NSError *error))completion
             test:(void(^)(id responseData, NSError *error))test {
    
    NSArray *trendingNowList =  @[
                              @"Sub Celeb Yada Yada",
                              @"Quentin Tarantino Thurman",
                              @"Fuck South Corea in the arse",
                              @"Copa Libertadores",
                              @"Boobs = Love"
                              ];
    
    if (completion) {
        completion( trendingNowList, NO, NULL );
        return;
    }
    
}

@end
