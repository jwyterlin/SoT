//
//  TweetModel.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericModel.h"

@interface TweetModel : GenericModel

/*!
 * @brief Number of unique identification
 */
@property(nonatomic,strong) NSNumber *identifier;

/*!
 * @brief Binary content for the image of the user that posted the tweet
 */
@property(nonatomic,strong) NSData *image;

/*!
 * @brief URL to get the image of the user that posted the tweet
 */
@property(nonatomic,strong) NSString *imageUrl;

/*!
 * @brief Name of the user that posted the tweet
 */
@property(nonatomic,strong) NSString *userName;

/*!
 * @brief Content of the tweet
 */
@property(nonatomic,strong) NSString *detail;

@end
