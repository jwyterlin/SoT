//
//  UITableView+Helper.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "UITableView+Helper.h"

@implementation UITableView (Helper)

-(void)registerNibForCellReuseIdentifier:(NSString *)identifier {
    
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:identifier];
    
}

@end
