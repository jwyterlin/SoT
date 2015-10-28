//
//  SearchDAO.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "SearchDAO.h"

@implementation SearchDAO

// SearchTerm

-(void)searchTerm:(NSString *)term completion:(void(^)(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error))completion {
    
    [self searchTerm:term completion:^(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error) {
        if (completion) {
            completion(tweetsFound, hasNoConnection, error);
        }
    } test:^(id responseData, NSError *error) {
        
    }];
    
}

-(void)searchTerm:(NSString *)term completion:(void(^)(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error))completion
             test:(void(^)(id responseData, NSError *error))test {
    
    NSArray *tweetsFound =  @[
                             @"Important question",
                             @"Amazing Gadget",
                             @"Hyped Social Networking",
                             @"Developer bitchin about",
                             @"Hot new actress doig nothing"
                            ];
    
    if (completion) {
        completion( tweetsFound, NO, NULL );
        return;
    }
    
}

// Recent Searches

-(void)recentSearchesWithCompletion:(void(^)(NSArray *recentSearches, BOOL hasNoConnection, NSError *error))completion {
    
    [self recentSearchesWithCompletion:^(NSArray *recentSearches, BOOL hasNoConnection, NSError *error) {
        if (completion) {
            completion(recentSearches,hasNoConnection,error);
        }
    } test:^(id responseData, NSError *error) {
        // Do nothing
    }];
    
}

-(void)recentSearchesWithCompletion:(void(^)(NSArray *recentSearches, BOOL hasNoConnection, NSError *error))completion
             test:(void(^)(id responseData, NSError *error))test {
    
    NSArray *recentSearches =  @[
                              @"Important question",
                              @"Amazing Gadget",
                              @"Hyped Social Networking",
                              @"Developer bitchin about",
                              @"Hot new actress doig nothing"
                              ];
    
    if (completion) {
        completion( recentSearches, NO, NULL );
        return;
    }
    
}

@end
