//
//  Routes.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "Routes.h"

@implementation Routes

+(NSString *)BASE_URL {
    return @"https://api.twitter.com.br";
}

+(NSString *)BASE_URL_API {
    return [NSString stringWithFormat:@"%@/1.1/",[Routes BASE_URL]];
}

+(NSString *)WS_TRENDS {
    return @"trends/place.json";
}

@end
