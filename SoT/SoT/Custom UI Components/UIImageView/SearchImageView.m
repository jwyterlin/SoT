//
//  SearchImageView.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "SearchImageView.h"

@implementation SearchImageView

-(void)setup {
    
    [super setup];
    
    self.x = [DeviceInfo isIpad]?55:16;
    self.y = [DeviceInfo isIpad]?18:10;
    self.width = [DeviceInfo isIpad]?74:21;
    self.height = [DeviceInfo isIpad]?74:21;
    self.image = [UIImage imageNamed:@"Icon_search_big"];
    
}

@end
