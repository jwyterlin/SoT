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
@property(nonatomic) BOOL isFirstUpdateAnimateTextField;
@property(nonatomic,strong) UITextField *activeTextField;

@end

@implementation GenericViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self registerObserversForKeyboard];
    
    self.isFirstUpdateAnimateTextField = YES;
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    self.keyHeight = nil;
    self.isFirstUpdateAnimateTextField = YES;
    
    if ( [self.screenHasMoved boolValue] == YES ) {
        
        self.view.frame = CGRectOffset( self.view.frame, 0, [self.screenMoveValue floatValue] );
        [self animateTextField:self.activeTextField up:YES];
        
    }
    
}

#pragma mark - Public methods

-(void)registerObserversForKeyboard {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)animateTextField:(UITextField *)textField up:(BOOL)up {
    
    if ( ! self.keyHeight )
        return;
    if ( ! self.screenHasMoved )
        self.screenHasMoved = [NSNumber numberWithBool:NO];
    if ( ! self.screenMoveValue )
        self.screenMoveValue = [NSNumber numberWithInt:0];
    
    CGFloat textSize = textField.superview.y + textField.superview.frame.size.height;
    
    if ( up ) {
        
        if ( self.view.height - textSize < [self.keyHeight floatValue] ) {
            
            // tweak as needed
            self.screenMoveValue = [NSNumber numberWithInt:[self.keyHeight floatValue] - ( self.view.height - textSize )];
            
            const float movementDuration = 0.3f; // tweak as needed
            
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            self.view.frame = CGRectOffset( self.view.frame, 0, -[self.screenMoveValue intValue] );
            [UIView commitAnimations];
            self.screenHasMoved = [NSNumber numberWithBool:YES];
            self.activeTextField = textField;
            
        }
        
    } else if ( [self.screenHasMoved boolValue] ) {
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: 0.3f];
        self.view.frame = CGRectOffset( self.view.frame, 0, [self.screenMoveValue intValue] );
        [UIView commitAnimations];
        self.screenHasMoved = [NSNumber numberWithBool:NO];
        self.activeTextField = nil;
        
    }
    
}

-(void)updateAnimateTextField {}

#pragma mark - Private methods

-(void)keyboardWillShow:(NSNotification *)aNotification {
    
    // Add tap to dismiss keyboard
    if ( ! self.tapToDismissKeyboard )
        [self setTapToDismissKeyboard: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)]];
    
    [self.view addGestureRecognizer:self.tapToDismissKeyboard];
    
    // Get the height of keyboard
    if ( [self.keyHeight floatValue] == 0.0 ) {
        
        NSDictionary *keyboardInfo = [aNotification userInfo];
        NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
        CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
        self.keyHeight = [NSNumber numberWithFloat: keyboardFrameBeginRect.size.height];
        
        if ( self.isFirstUpdateAnimateTextField ) {
            self.isFirstUpdateAnimateTextField = NO;
            [self updateAnimateTextField];
        }

    }
    
}

-(void)keyboardWillBeHidden:(NSNotification *)aNotification {
    [self.view removeGestureRecognizer:self.tapToDismissKeyboard];
}

-(void)dismissKeyboard:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

@end
