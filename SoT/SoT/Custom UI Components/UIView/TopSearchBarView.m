//
//  TopSearchBarView.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 29/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "TopSearchBarView.h"

@interface TopSearchBarView()

@property(nonatomic,strong) UIImageView *searchLogo;
@property(nonatomic,strong) UILabel *searchedTerm;
@property(nonatomic,strong) UIButton *closeButton;

@end

@implementation TopSearchBarView

#pragma mark - Overriding super methods

-(void)setup {
    
    [super setup];
    
    self.width = [DeviceInfo width];
    self.height = 88;
    self.backgroundColor = [UIColor colorWithRed:94.0/256.0 green:159.0/256.0 blue:202.0/256.0 alpha:1.0];
    
}

-(void)didMoveToSuperview {
    
    if ( self.superview ) {
        
        [self addSubview:self.searchLogo];
        [self addSubview:self.searchedTerm];
        [self addSubview:self.closeButton];
        
    }
    
}

#pragma mark - Public methods

-(void)updateWidth:(CGFloat)width {
    
    self.width = width;
    self.closeButton.x = width - self.closeButton.width - 32;
    self.searchedTerm.width = width - self.searchedTerm.x - ( width - self.closeButton.x + 8 );
    
}

-(void)updateTitle:(NSString *)title {
    
    self.searchedTerm.text = title;
    
}

#pragma mark - IBAction methods

-(IBAction)closeButtonPressed:(id)sender {
    
    [self.delegateTopSearchBarView tsbv_didPressCloseButton];
    
}

#pragma mark - Creating components

-(UIImageView *)searchLogo {

    if ( ! _searchLogo ) {
        
        CGFloat width = 38;
        CGFloat height = 38;
        CGFloat x = 31;
        CGFloat y = self.height/2 - height/2 + 10;
        
        _searchLogo = [[UIImageView alloc] initWithFrame:CGRectMake( x, y, width, height )];
        _searchLogo.backgroundColor = [UIColor blackColor];
        
    }
    
    return _searchLogo;
    
}

-(UILabel *)searchedTerm {
    
    if ( ! _searchedTerm ) {
        
        CGFloat x = self.searchLogo.x + self.searchLogo.width + 8;
        CGFloat width = [DeviceInfo width] - x - ( [DeviceInfo width] - self.closeButton.x + 8 );
        CGFloat height = 34;
        CGFloat y = self.height/2 - height/2 + 10;
        
        _searchedTerm = [[UILabel alloc] initWithFrame:CGRectMake( x, y, width, height ) ];
        _searchedTerm.text = @"";
        _searchedTerm.textAlignment = NSTextAlignmentCenter;
        _searchedTerm.textColor = [UIColor whiteColor];
        _searchedTerm.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:27.0f];
        
    }
    
    return _searchedTerm;
    
}

-(UIButton *)closeButton {
    
    if ( ! _closeButton ) {
        
        CGFloat width = 34;
        CGFloat height = 34;
        CGFloat x = [DeviceInfo width] - width - 32;
        CGFloat y = self.height/2 - height/2 + 10;
        
        _closeButton = [[UIButton alloc] initWithFrame: CGRectMake( x, y, width, height ) ];
        [_closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setTitle:@"X" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _closeButton.backgroundColor = [UIColor clearColor];
        _closeButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:27.0f];
        
    }
    
    return _closeButton;
    
}

@end
