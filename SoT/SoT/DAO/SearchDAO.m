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
    
    TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
    NSString *statusesShowEndpoint = [NSString stringWithFormat:@"%@%@",[Routes BASE_URL_API], [Routes WS_SEARCH_TWEETS]];

    term = [term stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *query = [term stringByRemovingPercentEncoding];
    
    NSDictionary *params = @{
                             @"q":query,
                             @"count":[NSString stringWithFormat:@"%i",SEARC_TERMS_LIMIT]
                            };
    NSError *clientError;
    
    NSURLRequest *request = [client URLRequestWithMethod:@"GET" URL:statusesShowEndpoint parameters:params error:&clientError];
    
    if ( request ) {
        
        [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if ( data ) {
                
                NSError *jsonError;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                NSArray *statuses = json[@"statuses"];
                
                NSMutableArray *list = [NSMutableArray new];
                
                if ( statuses.count > 0 ) {
                    
                    for ( NSDictionary *obj in statuses ) {
                        
                        TweetModel *t = [[TweetModel new] setupWithJson:obj];
                        
                        [list addObject:t];
                        
                    }
                    
                }

                if ( completion ) {
                    completion( list, NO, nil );
                }
                
            } else {
                
                if (completion) {
                    completion( nil, NO, connectionError );
                }
                
            }
            
        }];
        
    } else {
        
        if (completion) {
            completion( nil, NO, clientError );
        }
        
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
