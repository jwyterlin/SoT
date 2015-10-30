//
//  NetAPIClient.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPSessionManager.h"

@interface NetAPIClient : AFHTTPSessionManager

+(instancetype)sharedClient;

@end
