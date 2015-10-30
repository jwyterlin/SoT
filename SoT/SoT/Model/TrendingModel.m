//
//  TrendingModel.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 30/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "TrendingModel.h"

@implementation TrendingModel

-(TrendingModel *)setupWithJson:(NSDictionary *)j {
    
    if ( ! [Validator validateObject:j] )
        return nil;
    
    TrendingModel *t = [TrendingModel new];
    
    t.name = j[kTrendingName];
    t.promotedContent = j[kTrendingPromotedContent];
    t.query = j[kTrendingQuery];
    t.url = j[kTrendingUrl];
    
    return t;
    
}

@end
