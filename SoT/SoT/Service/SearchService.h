//
//  SearchService.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericService.h"

@interface SearchService : GenericService

// SearchTerm

-(void)searchTerm:(NSString *)term completion:(void(^)(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error))completion;

-(void)searchTerm:(NSString *)term completion:(void(^)(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error))completion
             test:(void(^)(id responseData, NSError *error))test;

// Recent Searches

-(void)recentSearchesWithCompletion:(void(^)(NSArray *recentSearches, BOOL hasNoConnection, NSError *error))completion;

-(void)recentSearchesWithCompletion:(void(^)(NSArray *recentSearches, BOOL hasNoConnection, NSError *error))completion
                               test:(void(^)(id responseData, NSError *error))test;

@end
