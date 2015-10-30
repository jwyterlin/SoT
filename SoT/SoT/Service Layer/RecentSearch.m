//
//  RecentSearch.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 30/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "RecentSearch.h"
#import "Constants.h"

@implementation RecentSearch

static RecentSearch *sharedInstance;

#pragma mark - Lifecycle

-(id)init {
    
    self = [super init];
    
    if ( self != nil ) {
        
        _recentSearches = [NSMutableArray new];
        
        NSArray *data = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredRecentSearches];
        
        if ( data )
            [_recentSearches addObjectsFromArray:data];

    }
    
    return self;
    
}

#pragma mark - Public methods

+(instancetype)sharedInstance {
    
    if ( ! sharedInstance )
        sharedInstance = [RecentSearch new];
    
    return sharedInstance;
    
}

-(void)addRecentSearch:(NSString *)recentSearch {
    
    if ( ! recentSearch )
        return;
    
    if ( ! [recentSearch isEqualToString:@""] )
        return;
    
    if ( _recentSearches.count == RECENT_SEARCH_BUTTONS_LIMIT )
        [_recentSearches removeObjectAtIndex:0];
    
    [_recentSearches insertObject:recentSearch atIndex:0];
    
    [self store];
    
}

#pragma mark - Private methods

-(void)store {
    
    [[NSUserDefaults standardUserDefaults] setObject:_recentSearches forKey:kStoredRecentSearches];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
