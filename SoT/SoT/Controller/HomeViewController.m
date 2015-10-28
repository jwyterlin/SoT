//
//  HomeViewController.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 25/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "HomeViewController.h"

// Custom UI Components
#import "CATransformLayer+Helper.h"
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

@property(nonatomic,strong) NSMutableArray *recentSearchButtons;
@property(nonatomic,strong) NSMutableArray *trendingNowButtons;

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
    [self showSearchTextField];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction methods

-(IBAction)recentSearchButtonPressed:(UIButton *)sender {
}

-(IBAction)trendingNowButtonPressed:(UIButton *)sender {
}

#pragma mark - Private methods

-(void)showTwitterLogo {
    
    if ( ! [self.twitterLogo isDescendantOfView:self.view] )
        [self.view addSubview:self.twitterLogo];
    
}

-(void)showSearchTextField {
    
    if ( ! [self.searchBackground isDescendantOfView:self.view] )
        [self.view addSubview:self.searchBackground];
    
}

-(void)getRecentSearchList {
    
    [[SearchDAO new] recentSearchesWithCompletion:^(NSArray *recentSearches, BOOL hasNoConnection, NSError *error) {
        
        if ( hasNoConnection ) {
            /// TODO: Show has no connection
            return;
        }
        
        if ( error ) {
            /// TODO: Show connection error
            return;
        }
        
        self.recentSearchList = recentSearches;
        
        if ( self.recentSearchList.count > 0 )
            [self showRecentSearches];
        else
            [self removeRecentSearches];
        
    }];

}

-(void)getTrendingNowList {
    
    [[TrendingDAO new] trendingNowWithCompletion:^(NSArray *trendingNowList, BOOL hasNoConnection, NSError *error) {
       
        if ( hasNoConnection ) {
            /// TODO: Show has no connection
            return;
        }
        
        if ( error ) {
            /// TODO: Show connection error
            return;
        }
        
        self.trendingNowList = trendingNowList;
        
        if ( self.trendingNowList.count > 0 )
            [self showTrendingNow];
        else
            [self removeTrendingNow];
        
    }];
    
}

-(void)showRecentSearches {
    
    if ( self.recentSearchList.count > 0 ) {
        
        [self.view addSubview:self.lineRecentSearches];
        [self.view addSubview:self.recentSearchLabel];
        
        /// TODO: Show list of recent searches buttons
        for ( NSString *text in self.recentSearchList ) {
            RecentSearchButton *recentSearchButton = [self createRecentSearchButtonWithText:text];
            [self.recentSearchButtons addObject:recentSearchButton];
            [self.view addSubview:recentSearchButton];
        }
        
    }
    
}

-(void)removeRecentSearches {
    
    if ( self.recentSearchList.count == 0 ) {
        
        [self.lineRecentSearches removeFromSuperview];
        [self.recentSearchLabel removeFromSuperview];
        [self removeButtonsInList:self.recentSearchButtons];
        
    }
    
}

-(void)showTrendingNow {
    
    if ( self.trendingNowList.count > 0 ) {
        
        [self.view addSubview:self.lineTrendingNow];
        [self.view addSubview:self.trendingNowLabel];
        
        /// TODO: Show list of trending now buttons
        for ( NSString *text in self.trendingNowList ) {
            TrendingNowButton *trendingNowButton = [self createTrendingNowButtonWithText:text];
            [self.trendingNowButtons addObject:trendingNowButton];
            [self.view addSubview:trendingNowButton];
        }
        
    }
    
}

-(void)removeTrendingNow {
    
    if ( self.trendingNowList.count == 0 ) {
        
        [self.lineTrendingNow removeFromSuperview];
        [self.trendingNowLabel removeFromSuperview];
        [self removeButtonsInList:self.trendingNowButtons];
        
    }
    
}

-(void)removeButtonsInList:(NSMutableArray *)list {
    
    for ( UIButton *b in list )
        [b removeFromSuperview];
    
    [list removeAllObjects];
    
}

-(RecentSearchButton *)createRecentSearchButtonWithText:(NSString *)text {
    
    RecentSearchButton *button = [RecentSearchButton new];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:self action:@selector(recentSearchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

-(TrendingNowButton *)createTrendingNowButtonWithText:(NSString *)text {
    
    TrendingNowButton *button = [TrendingNowButton new];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:self action:@selector(trendingNowButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
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

        if ( [self.lineRecentSearches isDescendantOfView:self.view] ) {
            UIButton *button = [self.recentSearchButtons lastObject];
            _searchBackground.y = button.y + button.height + 55;
        } else {
            _searchBackground.y = self.twitterLogo.y + self.twitterLogo.height + 55;
        }
        
        [_searchBackground addSubview:self.searchLogo];
        [_searchBackground addSubview:self.searchTextField];
        
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

-(NSMutableArray *)recentSearchButtons {
    
    if ( ! _recentSearchButtons ) {
        _recentSearchButtons = [NSMutableArray new];
    }
    
    return _recentSearchButtons;
    
}

-(NSMutableArray *)trendingNowButtons {
    
    if ( ! _trendingNowButtons ) {
        _trendingNowButtons = [NSMutableArray new];
    }
    
    return _trendingNowButtons;
    
}

@end
