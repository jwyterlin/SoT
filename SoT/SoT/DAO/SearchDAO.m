//
//  SearchDAO.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "SearchDAO.h"

// Model
#import "TweetModel.h"

@implementation SearchDAO

// SearchTerm

-(void)searchTerm:(NSString *)term completion:(void(^)(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error))completion {
    
    [self searchTerm:term completion:^(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error) {

        if ( completion )
            completion( tweetsFound, hasNoConnection, error );
        
    } test:^(id responseData, NSError *error) {
        
        // Do nothing
        
    }];
    
}

-(void)searchTerm:(NSString *)term completion:(void(^)(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error))completion
             test:(void(^)(id responseData, NSError *error))test {
    
    // Fake data
    TweetModel *t1 = [TweetModel new];
    t1.identifier = [NSNumber numberWithInt:1];
    t1.userName = @"Arthur Price";
    t1.detail = @"Hey @getblogo team! It was really really great to see you again earlier. Let's definitely get that coffee sometime next week...";
    
    TweetModel *t2 = [TweetModel new];
    t2.identifier = [NSNumber numberWithInt:2];
    t2.userName = @"Shirley Ramirez";
    t2.detail = @"Keytar McSweeney's Williamsburg, readymade leggings try-hard 90's street art letterpress hoodie occupy Wes Anderson Banksy. Asymmet.";
    
    TweetModel *t3 = [TweetModel new];
    t3.identifier = [NSNumber numberWithInt:3];
    t3.userName = @"Dennis Edwards";
    t3.detail = @"Banjo tote bag bicycle rights, High Life sartorial cray craft beer whatever street art fap. Hashtag typewriter banh mi, squid keffi.";
    
    TweetModel *t4 = [TweetModel new];
    t4.identifier = [NSNumber numberWithInt:4];
    t4.userName = @"Hannah Ramirez";
    t4.detail = @"Kogi Cosby sweater ethical squid irony disrupt, organic tote bag gluten-free XOXO wolf typewriter mixtape small batch. DIY pickled.";
    
    TweetModel *t5 = [TweetModel new];
    t5.identifier = [NSNumber numberWithInt:5];
    t5.userName = @"Dennis Edwards";
    t5.detail = @"Banjo tote bag bicycle rights, High Life sartorial cray craft beer whatever street art fap. Hashtag typewriter banh mi, squid keffi.";
    
    NSArray *tweetsFound = @[t1,t2,t3,t4,t5];
    
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
