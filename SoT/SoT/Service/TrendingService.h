//
//  TrendingService.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericService.h"

@interface TrendingService : GenericService

// Trending Now

-(void)trendingNowWithCompletion:(void(^)(NSArray *trendingNowList, BOOL hasNoConnection, NSError *error))completion;

-(void)trendingNowWithCompletion:(void(^)(NSArray *trendingNowList, BOOL hasNoConnection, NSError *error))completion
                            test:(void(^)(id responseData, NSError *error))test;

@end
