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
    self.height = [DeviceInfo isIpad]?110:40;
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake( 0, self.height-0.5, self.width, 0.5 )];
    bottomLine.backgroundColor = [UIColor colorWithRed:210.0/256.0 green:210.0/256.0 blue:210.0/256.0 alpha:1.0];
    [self addSubview:bottomLine];
    
}

@end
