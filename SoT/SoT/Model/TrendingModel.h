//
//  TrendingModel.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 30/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericModel.h"

@interface TrendingModel : GenericModel

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *promotedContent;
@property(nonatomic,strong) NSString *query;
@property(nonatomic,strong) NSString *url;

@end
