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
    
    self.x = 165;
    self.y = 18;
    self.width = [DeviceInfo width] - self.x - 21;
    self.height = 74;
    self.placeholder = @"Search it";
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
