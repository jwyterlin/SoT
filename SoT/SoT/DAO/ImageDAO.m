//
//  ImageDAO.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 30/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "ImageDAO.h"

@implementation ImageDAO

-(void)imageByUrl:(NSString *)url completion:(void(^)(UIImage *image))completion {
    
    NSURL *imageURL = [NSURL URLWithString:url];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        if (completion) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
            
        }
        
    });
    
}

@end
