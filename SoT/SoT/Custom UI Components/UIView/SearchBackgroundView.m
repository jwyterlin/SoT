//
//  SearchBackgroundView.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "SearchBackgroundView.h"

@implementation SearchBackgroundView

-(void)setup {
    
    [super setup];
    
    self.x = 0;
    self.y = 0;
    self.width = [DeviceInfo width];
    self.height = 110;
    
    self.backgroundColor = [UIColor whiteColor];
    
}

@end
