//
//  ImageDAO.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 30/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericDAO.h"

@interface ImageDAO : GenericDAO

-(void)imageByUrl:(NSString *)url completion:(void(^)(UIImage *image))completion;

@end
