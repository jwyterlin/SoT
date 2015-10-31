//
//  SearchTextField.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericTextField.h"

@protocol SearchTextFieldDelegate;

@interface SearchTextField : GenericTextField

/*!
 * @brief Object to be the delegate of the class SearchTextFieldDelegate
 */
@property(nonatomic,weak) id<SearchTextFieldDelegate> delegateSearchTextField;

@end

@protocol SearchTextFieldDelegate <NSObject>

-(void)stfd_didBeginEditing;
-(void)stfd_didEndEditing;
-(void)stfd_search;

@end
