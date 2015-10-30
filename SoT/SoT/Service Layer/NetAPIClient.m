//
//  NetAPIClient.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "NetAPIClient.h"

#import "Routes.h"

@implementation NetAPIClient

+ (instancetype)sharedClient {

    static NetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[Routes BASE_URL_API]]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        _sharedClient.securityPolicy.allowInvalidCertificates = YES;
    });
    
    return _sharedClient;
    
}

@end
