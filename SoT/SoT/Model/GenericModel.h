//
//  GenericModel.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <Foundation/Foundation.h>

// Service Layer
#import "Constants.h"
#import "Validator.h"

@interface GenericModel : NSObject

-(NSArray *)setupListWithJson:(NSArray *)list;
-(id)setupWithJson:(NSDictionary *)json;

@end
