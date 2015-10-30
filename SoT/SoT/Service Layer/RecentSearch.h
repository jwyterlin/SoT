//
//  RecentSearch.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 30/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentSearch : NSObject

+(instancetype)sharedInstance;

@property(nonatomic,getter=recentSearches,readonly) NSMutableArray *recentSearches;

-(void)addRecentSearch:(NSString *)recentSearch;

@end
