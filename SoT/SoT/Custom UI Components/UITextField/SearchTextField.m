//
//  SearchTextField.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "SearchTextField.h"

@implementation SearchTextField

-(void)setup {
    
    self.x = 165;
    self.y = 18;
    self.width = [DeviceInfo width] - self.x;
    self.height = 74;
    self.placeholder = @"Search it";
    
}

@end
