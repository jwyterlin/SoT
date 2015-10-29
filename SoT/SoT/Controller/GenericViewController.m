//
//  GenericViewController.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericViewController.h"

@interface GenericViewController()

@property(nonatomic,strong) UITapGestureRecognizer *tapToDismissKeyboard;
@property(nonatomic,strong) NSNumber *keyHeight;
@property(nonatomic,strong) NSNumber *screenHasMoved;
@property(nonatomic,strong) NSNumber *screenMoveValue;

@end

@implementation GenericViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self registerObserversForKeyboard];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Public methods

-(void)registerObserversForKeyboard {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)animateTextField:(UITextField *)textField up:(BOOL)up {
    
    if ( ! self.keyHeight )
        self.keyHeight = [NSNumber numberWithFloat:216.0];
    if ( ! self.screenHasMoved )
        self.screenHasMoved = [NSNumber numberWithBool:NO];
    if ( ! self.screenMoveValue )
        self.screenMoveValue = [NSNumber numberWithInt:0];
    
    CGFloat textSize = [textField.superview convertPoint:textField.frame.origin toView:nil].y + textField.frame.size.height;
    
    if ( up ) {
        
        if ( [DeviceInfo height] - textSize < [self.keyHeight floatValue] ) {
            
            // tweak as needed
            self.screenMoveValue = [NSNumber numberWithInt:[self.keyHeight floatValue] - ( [DeviceInfo height] - textSize ) + 16];
            const float movementDuration = 0.3f; // tweak as needed
            
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            self.view.frame = CGRectOffset( self.view.frame, 0, -[self.screenMoveValue intValue] );
            [UIView commitAnimations];
            self.screenHasMoved = [NSNumber numberWithBool:YES];
            
        }
        
    } else if ( [self.screenHasMoved boolValue] ) {
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: 0.3f];
        self.view.frame = CGRectOffset( self.view.frame, 0, [self.screenMoveValue intValue] );
        [UIView commitAnimations];
        self.screenHasMoved = [NSNumber numberWithBool:NO];
        
    }
    
}

#pragma mark - Private methods

-(void)keyboardWasShown:(NSNotification*)aNotification {
    
    // Add tap to dismiss keyboard
    if ( ! self.tapToDismissKeyboard )
        [self setTapToDismissKeyboard: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)]];
    
    [self.view addGestureRecognizer:self.tapToDismissKeyboard];
    
    // Get the height of keyboard
    NSDictionary* keyboardInfo = [aNotification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    self.keyHeight = [NSNumber numberWithFloat: keyboardFrameBeginRect.size.height];
    
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [self.view removeGestureRecognizer:self.tapToDismissKeyboard];
}

-(void)dismissKeyboard:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

@end
