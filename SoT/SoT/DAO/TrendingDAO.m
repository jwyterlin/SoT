//
//  TrendingDAO.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "TrendingDAO.h"

#import <TwitterKit/TwitterKit.h>

#import "TrendingModel.h"

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
    
    TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
    NSString *statusesShowEndpoint = [NSString stringWithFormat:@"%@%@",[Routes BASE_URL_API], [Routes WS_TRENDS]];
    NSDictionary *params = @{@"id":@"1"};
    NSError *clientError;
    
    NSURLRequest *request = [client URLRequestWithMethod:@"GET" URL:statusesShowEndpoint parameters:params error:&clientError];
    
    if ( request ) {
        
        [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if ( data ) {
                
                NSError *jsonError;
                NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                NSMutableArray *list = [NSMutableArray new];
                
                if ( json.count > 0 ) {
                    
                    NSDictionary *firstObj = json[0];
                    
                    NSArray *trends = firstObj[@"trends"];
                    
                    int i = 0;
                    
                    for ( NSDictionary *obj in trends ) {
                        
                        if ( i < TRENDING_NOW_BUTTONS_LIMIT ) {
                            
                            TrendingModel *t = [[TrendingModel new] setupWithJson:obj];
                            
                            [list addObject:t];
                            
                            i++;
                            
                        } else {
                            break;
                        }
                        
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

@end
