//
//  TopSearchBarView.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericView.h"

@protocol TopSearchBarViewDelegate;

@interface TopSearchBarView : GenericView

@property(nonatomic,weak) id<TopSearchBarViewDelegate> delegateTopSearchBarView;

-(void)updateWidth:(CGFloat)width;
-(void)updateTitle:(NSString *)title;

@end

@protocol TopSearchBarViewDelegate <NSObject>

-(void)tsbv_didPressCloseButton;

@end
