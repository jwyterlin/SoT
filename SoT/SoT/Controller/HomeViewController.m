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

@interface HomeViewController()<SearchTextFieldDelegate>

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

#pragma mark - SearchTextFieldDelegate methods

-(void)stfd_didBeginEditing {
    [self animateTextField:self.searchTextField up:YES];
}

-(void)stfd_didEndEditing {
    [self animateTextField:self.searchTextField up:NO];
}

-(void)stfd_search {
    
    [[SearchDAO new] searchTerm:self.searchTextField.text completion:^(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error) {
        
        if ( hasNoConnection ) {
            /// TODO: Show has no connection
            return;
        }
        
        if ( error ) {
            /// TODO: Show connection error
            return;
        }
        
        // Success
        
    }];
    
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
        
        [self updateRecentSearchesUI];
        
    }];

}

-(void)updateRecentSearchesUI {
    
    if ( self.recentSearchList.count > 0 )
        [self showRecentSearches];
    else
        [self removeRecentSearches];
    
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
        
        [self updateTrendingNowUI];
        
    }];
    
}

-(void)updateTrendingNowUI {
    
    if ( self.trendingNowList.count > 0 )
        [self showTrendingNow];
    else
        [self removeTrendingNow];
    
}

-(void)showRecentSearches {
    
    if ( self.recentSearchList.count > 0 ) {
        
        [self.view addSubview:self.lineRecentSearches];
        [self.view addSubview:self.recentSearchLabel];
        
        /// TODO: Show list of recent searches buttons
        for ( NSString *text in self.recentSearchList ) {
            RecentSearchButton *recentSearchButton = [self createRecentSearchButtonWithText:text];
            [self.view addSubview:recentSearchButton];
        }
        
        self.searchBackground.y = [self positionToSearchBackground];
        
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
            [self.view addSubview:trendingNowButton];
        }
        
        self.searchBackground.y = [self positionToSearchBackground];
        
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
    
    [self setupButton:button
                 text:text
             selector:@selector(recentSearchButtonPressed:)
          listButtons:self.recentSearchButtons
       labelReference:self.recentSearchLabel];
    
    return button;
    
}

-(TrendingNowButton *)createTrendingNowButtonWithText:(NSString *)text {
    
    TrendingNowButton *button = [TrendingNowButton new];
    
    [self setupButton:button
                 text:text
             selector:@selector(trendingNowButtonPressed:)
          listButtons:self.trendingNowButtons
       labelReference:self.trendingNowLabel];
    
    return button;
    
}

-(void)setupButton:(UIButton *)button
              text:(NSString *)text
          selector:(SEL)selector
       listButtons:(NSMutableArray *)listButtons
    labelReference:(UILabel *)labelReference {
    
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [listButtons addObject:button];
    button.x = labelReference.x;
    button.y = labelReference.y + labelReference.height + ( listButtons.count * ( button.height + 8 ) ) - button.height;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
}

-(int)positionToSearchBackground {
    
    NSMutableArray *listButtons = [self listWithMoreButtons];
    
    if ( listButtons ) {
        UIButton *button = [listButtons lastObject];
        return button.y + button.height + 55;
    } else {
        return self.twitterLogo.y + self.twitterLogo.height + 55;
    }

}

-(NSMutableArray *)listWithMoreButtons {
    
    NSMutableArray *listButtons;
    
    NSUInteger quantityRecentSearchButtons = self.recentSearchButtons.count;
    NSUInteger quantityTrendingNowButtons = self.trendingNowButtons.count;
    
    if ( quantityRecentSearchButtons > quantityTrendingNowButtons ) {
        listButtons = self.recentSearchButtons;
    } else if ( quantityTrendingNowButtons > quantityRecentSearchButtons ) {
        listButtons = self.trendingNowButtons;
    } else {
        if ( quantityRecentSearchButtons > 0 )
            listButtons = self.recentSearchButtons;
    }
    
    return listButtons;
    
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

-(RecentSearchLabel *)recentSearchLabel {
    
    if ( ! _recentSearchLabel ) {
        
        _recentSearchLabel = [RecentSearchLabel new];
        _recentSearchLabel.x = self.lineRecentSearches.x;
        _recentSearchLabel.y = self.lineRecentSearches.y + self.lineRecentSearches.height + 8;
        
    }
    
    return _recentSearchLabel;
    
}

-(LineView *)lineTrendingNow {
    
    if ( ! _lineTrendingNow ) {
        
        _lineTrendingNow = [LineView new];
        _lineTrendingNow.x = self.lineRecentSearches.x + self.lineRecentSearches.width + 77;
        _lineTrendingNow.y = self.twitterLogo.y + self.twitterLogo.height + 89;
        
    }
    
    return _lineTrendingNow;
    
}

-(TrendingNowLabel *)trendingNowLabel {
    
    if ( ! _trendingNowLabel ) {
        
        _trendingNowLabel = [TrendingNowLabel new];
        _trendingNowLabel.x = self.lineTrendingNow.x;
        _trendingNowLabel.y = self.lineTrendingNow.y + self.lineTrendingNow.height + 8;
        
    }
    
    return _trendingNowLabel;
    
}

-(SearchTextField *)searchTextField {
    
    if ( ! _searchTextField ) {
        
        _searchTextField = [SearchTextField new];
        _searchTextField.delegateSearchTextField = self;
        
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
        _searchBackground.y = [self positionToSearchBackground];

        [_searchBackground addSubview:self.searchLogo];
        [_searchBackground addSubview:self.searchTextField];
        
    }
    
    return _searchBackground;
    
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
