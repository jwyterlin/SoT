//
//  HomeViewController.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 25/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "HomeViewController.h"

// Custom UI Components
#import "LineView.h"
#import "RecentSearchButton.h"
#import "SearchBackgroundView.h"
#import "SearchImageView.h"
#import "SearchTextField.h"
#import "TrendingNowButton.h"
#import "TwitterImageView.h"
#import "UIView+Helper.h"

// Service Layer
#import "DeviceInfo.h"

@interface HomeViewController()

// UI
@property(nonatomic,strong) TwitterImageView *twitterLogo;
@property(nonatomic,strong) LineView *lineRecentSearches;
@property(nonatomic,strong) LineView *lineTrendingNow;
@property(nonatomic,strong) SearchTextField *searchTextField;
@property(nonatomic,strong) SearchImageView *searchLogo;
@property(nonatomic,strong) SearchBackgroundView *searchBackground;

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

-(TwitterImageView *)twitterLogo {
    
    if ( ! _twitterLogo ) {
        _twitterLogo = [TwitterImageView new];
    }
    
    return _twitterLogo;
    
}

-(LineView *)lineRecentSearches {
    
    if ( ! _lineRecentSearches ) {
        
        _lineRecentSearches = [LineView new];
        _lineRecentSearches.x = [DeviceInfo width]/2 - _lineRecentSearches.width - 38.5;
        _lineRecentSearches.y = self.twitterLogo.y + self.twitterLogo.height + 89;
        
    }
    
    return _lineRecentSearches;
    
}

-(LineView *)lineTrendingNow {
    
    if ( ! _lineTrendingNow ) {
        
        _lineTrendingNow = [LineView new];
        _lineTrendingNow.x = self.lineRecentSearches.x + self.lineRecentSearches.width + 77;
        _lineTrendingNow.y = self.twitterLogo.y + self.twitterLogo.height + 89;
        
    }
    
    return _lineTrendingNow;
    
}

-(SearchTextField *)searchTextField {
    
    if ( ! _searchTextField ) {
        _searchTextField = [SearchTextField new];
    }
    
    return _searchTextField;
    
}

-(SearchImageView *)searchLogo {
    
    if ( ! _searchLogo ) {
        _searchLogo = [SearchImageView new];
    }
    
    return _searchLogo;
    
}

-(SearchBackgroundView *)searchBackground {
    
    if ( ! _searchBackground ) {
        _searchBackground = [SearchBackgroundView new];
    }
    
    return _searchBackground;
    
}

@end
