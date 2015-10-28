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
#import "RecentSearchLabel.h"
#import "SearchBackgroundView.h"
#import "SearchImageView.h"
#import "SearchTextField.h"
#import "TrendingNowButton.h"
#import "TrendingNowLabel.h"
#import "TwitterImageView.h"
#import "UIView+Helper.h"

// Service Layer
#import "DeviceInfo.h"

// DAO
#import "SearchDAO.h"
#import "TrendingDAO.h"

@interface HomeViewController()

// UI
@property(nonatomic,strong) TwitterImageView *twitterLogo;
@property(nonatomic,strong) LineView *lineRecentSearches;
@property(nonatomic,strong) LineView *lineTrendingNow;
@property(nonatomic,strong) SearchTextField *searchTextField;
@property(nonatomic,strong) SearchImageView *searchLogo;
@property(nonatomic,strong) SearchBackgroundView *searchBackground;
@property(nonatomic,strong) RecentSearchLabel *recentSearchLabel;
@property(nonatomic,strong) TrendingNowLabel *trendingNowLabel;

@property(nonatomic,strong) NSArray *recentSearchList;
@property(nonatomic,strong) NSArray *trendingNowList;

@property(nonatomic,strong) NSArray *recentSearchButtons;
@property(nonatomic,strong) NSArray *trendingNowButtons;

@end

const int RECENT_SEARCH_BUTTONS_LIMIT = 5;
const int TRENDING_NOW_BUTTONS_LIMIT = 5;

@implementation HomeViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self getRecentSearchList];
    [self getTrendingNowList];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self showTwitterLogo];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private methods

-(void)showTwitterLogo {
    
    if ( ! [self.twitterLogo isDescendantOfView:self.view] )
        [self.view addSubview:self.twitterLogo];
    
}

-(void)getRecentSearchList {
    
    [[SearchDAO new] searchTerm:self.searchTextField.text completion:^(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error) {
        
        if ( hasNoConnection ) {
            /// TODO: Show has no connection
            return;
        }
        
        if ( error ) {
            /// TODO: Show connection error
            return;
        }
        
        self.recentSearchList = tweetsFound;
        
    }];

}

-(void)getTrendingNowList {
    
    [[TrendingDAO new] trendingNowWithCompletion:^(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error) {
       
        if ( hasNoConnection ) {
            /// TODO: Show has no connection
            return;
        }
        
        if ( error ) {
            /// TODO: Show connection error
            return;
        }
        
        self.trendingNowList = tweetsFound;
        
    }];
    
}

-(void)showRecentSearches {
}

-(void)removeRecentSearches {
}

-(void)showTrendingNow {
}

-(void)removeTrendingNow {
}

-(RecentSearchButton *)createRecentSearchButton {
    
    RecentSearchButton *button = [RecentSearchButton new];
    
    return button;
    
}

-(TrendingNowButton *)createTrendingNowButton {
    
    TrendingNowButton *button = [TrendingNowButton new];
    
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

-(RecentSearchLabel *)recentSearchLabel {
    
    if ( ! _recentSearchLabel ) {
        _recentSearchLabel = [RecentSearchLabel new];
        _recentSearchLabel.y = self.lineRecentSearches.y + self.lineRecentSearches.height + 8;
    }
    
    return _recentSearchLabel;
    
}

-(TrendingNowLabel *)trendingNowLabel {
    
    if ( ! _trendingNowLabel ) {
        _trendingNowLabel = [TrendingNowLabel new];
        _trendingNowLabel.y = self.lineTrendingNow.y + self.lineTrendingNow.height + 8;
    }
    
    return _trendingNowLabel;
    
}

@end
