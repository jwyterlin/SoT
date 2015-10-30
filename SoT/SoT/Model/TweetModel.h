//
//  TweetModel.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericModel.h"

@interface TweetModel : GenericModel

@property(nonatomic,strong) NSNumber *identifier;
@property(nonatomic,strong) NSData *image;
@property(nonatomic,strong) NSString *imageUrl;
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *detail;

@end
