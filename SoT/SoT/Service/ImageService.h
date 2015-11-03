//
//  ImageService.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 30/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericService.h"

@interface ImageService : GenericService

-(void)imageByUrl:(NSString *)url completion:(void(^)(UIImage *image))completion;

@end
