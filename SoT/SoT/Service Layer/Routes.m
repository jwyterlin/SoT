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
    return @"https://api.twitter.com.br/";
}

+(NSString *)BASEAPI_URL {
    return [NSString stringWithFormat:@"%@",[Routes BASE_URL]];
}

+(NSString *)WS_TEST {
    return @"test";
}

@end
