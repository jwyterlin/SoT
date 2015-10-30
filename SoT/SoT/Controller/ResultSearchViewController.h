//
//  ResultSearchViewController.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericViewController.h"

@interface ResultSearchViewController : GenericViewController

-(id)initWithTweetsFound:(NSArray *)tweetsFound termSearched:(NSString *)termSearched;

@end
