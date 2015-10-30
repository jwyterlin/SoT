//
//  SearchTextField.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "SearchTextField.h"

@interface SearchTextField()<UITextFieldDelegate>

@end

@implementation SearchTextField

#pragma mark - Override super methods

-(void)setup {
    
    [super setup];
    
    self.x = [DeviceInfo isIpad]?165:66;
    self.y = [DeviceInfo isIpad]?18:2;
    self.width = [DeviceInfo width] - self.x - 21;
    self.height = [DeviceInfo isIpad]?74:34;
    self.placeholder = NSLocalizedString( @"SEARCH_IT", nil );
    self.returnKeyType = UIReturnKeySearch;
    self.delegate = self;
    
}

#pragma mark - UITextFieldDelegate methods

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.delegateSearchTextField stfd_didBeginEditing];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegateSearchTextField stfd_didEndEditing];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.delegateSearchTextField stfd_search];
    
    return NO;
    
}

@end
