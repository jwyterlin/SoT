//
//  LineView.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "LineView.h"

@implementation LineView

-(void)setup {
    
    [super setup];
    
    self.width = [DeviceInfo isIpad]?WIDTH_SUBCOLUMNS_MAIN_VIEW_FOR_IPAD:WIDTH_SUBCOLUMNS_MAIN_VIEW_FOR_IPHONE;
    self.height = 4;
    self.backgroundColor = [UIColor colorWithRed:90.0/256.0 green:160.0/256.0 blue:198.0/256.0 alpha:1.0];
    
}

@end
