//
//  TwitterImageView.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "TwitterImageView.h"

@implementation TwitterImageView

-(void)setup {
    
    [super setup];
    
    self.width = [DeviceInfo isIpad]?165:165*0.3;
    self.height = [DeviceInfo isIpad]?135:135*0.3;
    self.x = [DeviceInfo width]/2 - self.width/2;
    self.y = [DeviceInfo isIpad]?165:30;
    self.image = [UIImage imageNamed:@"Twitter_logo_blue"];
    
}

@end
