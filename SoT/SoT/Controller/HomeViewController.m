//
//  HomeViewController.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 25/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "HomeViewController.h"

// Custom UI Components
#import "RecentSearchButton.h"
#import "TrendingNowButton.h"
#import "UIView+Helper.h"

// Service Layer
#import "DeviceInfo.h"

@interface HomeViewController()

// UI
@property(nonatomic,strong) UIImageView *twitterLogo;
@property(nonatomic,strong) UIView *lineRecentSearches;
@property(nonatomic,strong) UIView *lineTrendingNow;
@property(nonatomic,strong) UITextField *searchTextField;
@property(nonatomic,strong) UIImageView *searchLogo;
@property(nonatomic,strong) UIView *searchBackground;

@property(nonatomic,strong) NSArray *recentSearchButtons;
@property(nonatomic,strong) NSArray *trendingNowButtons;

@end

const int RECENT_SEARCH_BUTTONS_LIMIT = 5;
const int TRENDING_NOW_BUTTONS_LIMIT = 5;

@implementation HomeViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private methods

-(void)showRecentSearches {
}

-(void)removeRecentSearches {
}

-(void)showTrendingNow {
}

-(void)removeTrendingNow {
}

-(RecentSearchButton *)createRecentSearchButton {
    
    RecentSearchButton *button = [[RecentSearchButton alloc] init];
    
    return button;
    
}

-(TrendingNowButton *)createTrendingNowButton {
    
    TrendingNowButton *button = [[TrendingNowButton alloc] init];
    
    return button;
    
}

#pragma mark - Creating components

-(UIImageView *)twitterLogo {
    
    if ( ! _twitterLogo ) {
        
        CGFloat width = 165;
        CGFloat height = 135;
        CGFloat x = [DeviceInfo width]/2 - width/2;
        CGFloat y = 165;
        
        _twitterLogo = [[UIImageView alloc] initWithFrame:CGRectMake( x, y, width, height )];
        _twitterLogo.image = [UIImage imageNamed:@"Twitter_logo_blue"];
        
    }
    
    return _twitterLogo;
    
}

-(UIView *)lineRecentSearches {
    
    if ( ! _lineRecentSearches ) {
        
        CGFloat width = 231;
        CGFloat height = 4;
        CGFloat x = [DeviceInfo width]/2 - width - 38.5;
        CGFloat y = self.twitterLogo.y + self.twitterLogo.height + 89;
        
        _lineRecentSearches = [[UIView alloc] initWithFrame:CGRectMake( x, y, width, height )];
        
    }
    
    return _lineRecentSearches;
    
}

-(UIView *)lineTrendingNow {
    
    if ( ! _lineTrendingNow ) {
        
        CGFloat width = 231;
        CGFloat height = 4;
        CGFloat x = self.lineRecentSearches.x + self.lineRecentSearches.width + 77;
        CGFloat y = self.twitterLogo.y+self.twitterLogo.height+89;
        
        _lineTrendingNow = [[UIView alloc] initWithFrame:CGRectMake( x, y, width, height )];
        
    }
    
    return _lineTrendingNow;
    
}

-(UITextField *)searchTextField {
    
    if ( ! _searchTextField ) {
        _searchTextField = [[UITextField alloc] init];
    }
    
    return _searchTextField;
    
}

-(UIImageView *)searchLogo {
    
    if ( ! _searchLogo ) {
        _searchLogo = [[UIImageView alloc] init];
    }
    
    return _searchLogo;
    
}

-(UIView *)searchBackground {
    
    if ( ! _searchBackground ) {
        _searchBackground = [[UIView alloc] init];
    }
    
    return _searchBackground;
    
}

@end
