//
//  TrendingModel.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 30/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericModel.h"

@interface TrendingModel : GenericModel

/*!
 * @brief Main description about the trending topic
 */
@property(nonatomic,strong) NSString *name;

/*!
 * @brief Promoted content
 */
@property(nonatomic,strong) NSString *promotedContent;

/*!
 * @brief The description as query
 */
@property(nonatomic,strong) NSString *query;

/*!
 * @brief URL to the trending topic
 */
@property(nonatomic,strong) NSString *url;

@end
