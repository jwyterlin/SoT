//
//  TwitterImageView.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "TwitterImageView.h"

// Service Layer
#import "DeviceInfo.h"

@implementation TwitterImageView

-(void)setup {
    
    [super setup];
    
    self.width = 165;
    self.height = 135;
    self.x = [DeviceInfo width]/2 - self.width/2;
    self.y = 165;
    self.image = [UIImage imageNamed:@"Twitter_logo_blue"];
    
}

@end
