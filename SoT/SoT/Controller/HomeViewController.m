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
#import "Indicator.h"
#import "RecentSearch.h"

// DAO
#import "SearchDAO.h"
#import "TrendingDAO.h"

// Controller
#import "ResultSearchViewController.h"

// Model
#import "TrendingModel.h"

@interface HomeViewController()<SearchTextFieldDelegate>

/*!
 * @brief Twitter logo that appears at the top of the view
 */
@property(nonatomic,strong) TwitterImageView *twitterLogo;

/*!
 * @brief Line that appears at the left of the view, to indicate the list of Recent Searches
 */
@property(nonatomic,strong) LineView *lineRecentSearches;

/*!
 * @brief Line that appears at the right of the view, to indicate the list of Trending Now
 */
@property(nonatomic,strong) LineView *lineTrendingNow;

/*!
 * @brief Textfield to the user type the term he wants to get tweet with it
 */
@property(nonatomic,strong) SearchTextField *searchTextField;

/*!
 * @brief A search logo to show beside the searchTextField
 */
@property(nonatomic,strong) SearchImageView *searchLogo;

/*!
 * @brief White background to searchTextField
 */
@property(nonatomic,strong) SearchBackgroundView *searchBackground;

/*!
 * @brief A label to indicate the Recent Search column
 */
@property(nonatomic,strong) RecentSearchLabel *recentSearchLabel;

/*!
 * @brief A label to indicate the Trending Now column
 */
@property(nonatomic,strong) TrendingNowLabel *trendingNowLabel;

/*!
 * @brief List with the last terms searched
 */
@property(nonatomic,strong) NSArray *recentSearchList;

/*!
 * @brief List with the trending now terms
 */
@property(nonatomic,strong) NSArray *trendingNowList;

/*!
 * @brief List with the buttons that represent the terms of the list of Recent Searches
 */
@property(nonatomic,strong) NSMutableArray *recentSearchButtons;

/*!
 * @brief List with the buttons that represent the terms of the list of Trending Now
 */
@property(nonatomic,strong) NSMutableArray *trendingNowButtons;

@end

@implementation HomeViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self getTrendingNowList];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self getRecentSearchList];
    
    [self showTwitterLogo];
    [self showSearchTextField];
    
    self.searchTextField.text = @"";
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // Adjust components
    [self horizontalAdjustToSize:size];
    
    if ( [self.searchTextField isFirstResponder] )
        [self updateAnimateTextField];
    
    [self verticalAdjustToSize:size];
    
}

#pragma mark - IBAction methods

-(IBAction)shortcutButtonPressed:(UIButton *)sender {

    self.searchTextField.text = sender.titleLabel.text;
    [self searchTerm:NO];
    
}

#pragma mark - SearchTextFieldDelegate methods

-(void)stfd_didBeginEditing {
    [self animateTextField:self.searchTextField up:YES];
}

-(void)stfd_didEndEditing {
    [self animateTextField:self.searchTextField up:NO];
}

-(void)stfd_search {
    
    [self searchTerm:YES];
    
}

#pragma mark - Overriding super methods

-(void)updateAnimateTextField {
    
    [super updateAnimateTextField];
    
    [self animateTextField:self.searchTextField up:YES];
    
}

#pragma mark - Private methods

-(void)searchTerm:(BOOL)wasTyped {
    
    [[Indicator shared] showIndicatorWithLabel:NSLocalizedString(@"LOADING", nil) viewController:self];

    [[SearchDAO new] searchTerm:self.searchTextField.text completion:^(NSArray *tweetsFound, BOOL hasNoConnection, NSError *error) {
        
        [[Indicator shared] stopIndicatorInViewController:self];
        
        if ( hasNoConnection ) {
            /// TODO: Show has no connection
            return;
        }
        
        if ( error ) {
            /// TODO: Show connection error
            return;
        }
        
        // Success
        if ( tweetsFound.count > 0 ) {
            
            if ( wasTyped ) {
                // Store this term in the recent search's history
                [[RecentSearch sharedInstance] addRecentSearch:self.searchTextField.text];
            }

            // Call view showing results of the search
            ResultSearchViewController *resultSearchVC = [[ResultSearchViewController alloc] initWithTweetsFound:tweetsFound
                                                                                                    termSearched:self.searchTextField.text];
            [self presentViewController:resultSearchVC animated:YES completion:nil];
            
        }
        
    }];
    
}

-(void)horizontalAdjustToSize:(CGSize)size {
    
    self.twitterLogo.x = size.width/2 - self.twitterLogo.width/2;
    self.lineRecentSearches.x = [self lineRecentSearchesAxisXWithWidth:size.width];
    self.lineTrendingNow.x = [self lineTrendingNowAxisX];
    self.recentSearchLabel.x = self.lineRecentSearches.x;
    self.trendingNowLabel.x = self.lineTrendingNow.x;
    
    self.searchBackground.width = size.width;
    self.searchTextField.width = size.width - self.searchTextField.x - 21;
    
}

-(void)verticalAdjustToSize:(CGSize)size {
    
    if ( self.searchBackground.y + self.searchBackground.height > size.height ) {
        
        self.lineRecentSearches.y = [self lineRecentSearchesAxisY];
        self.lineTrendingNow.y = self.lineRecentSearches.y;
        
        self.recentSearchLabel.y = [self recentSearchLabelAxisY];
        self.trendingNowLabel.y = [self trendingNowLabelAxisY];
        
        self.searchBackground.y = size.height - self.searchBackground.height;
        
    }
    
    int i = 1, yLastVisibleButton = 0;
    for ( UIButton *b in self.recentSearchButtons ) {
        b.x = self.lineRecentSearches.x;
        b.y = self.recentSearchLabel.y + self.recentSearchLabel.height + ( (8+b.height) * i++ ) - 30;
        b.hidden = ( b.y + b.height > size.height - self.searchBackground.height );
        yLastVisibleButton = (b.hidden?yLastVisibleButton:b.y+b.height+55);
    }
    
    i = 1;
    for ( UIButton *b in self.trendingNowButtons ) {
        b.x = self.lineTrendingNow.x;
        b.y = self.trendingNowLabel.y + self.trendingNowLabel.height + ( (8+b.height) * i++ ) - 30;
        b.hidden = ( b.y + b.height > size.height - self.searchBackground.height );
        yLastVisibleButton = (b.hidden && b.y+b.height+55>yLastVisibleButton?yLastVisibleButton:b.y+b.height+55);
    }
    
    if ( yLastVisibleButton + self.searchBackground.height < size.height )
        self.searchBackground.y = yLastVisibleButton;
    
}

-(void)showTwitterLogo {
    
    if ( ! [self.twitterLogo isDescendantOfView:self.view] )
        [self.view addSubview:self.twitterLogo];
    
}

-(void)showSearchTextField {
    
    if ( ! [self.searchBackground isDescendantOfView:self.view] )
        [self.view addSubview:self.searchBackground];
    
}

-(void)getRecentSearchList {
    
    self.recentSearchList = [[[RecentSearch sharedInstance] recentSearches] mutableCopy];
    [self updateRecentSearchesUI];

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
        
        [self cleanRecentSearchButtonsList];
        
        for ( NSString *text in self.recentSearchList )
            [self createRecentSearchButtonWithText:text];
        
        self.searchBackground.y = [self positionToSearchBackground];
        
    }
    
}

-(void)cleanRecentSearchButtonsList {
    
    if ( self.recentSearchButtons.count > 0 )
        for ( UIButton *b in self.recentSearchButtons )
            [b removeFromSuperview];
    
    [self.recentSearchButtons removeAllObjects];
    
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
        
        for ( TrendingModel *t in self.trendingNowList )
            [self createTrendingNowButtonWithText:t.name];
        
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
             selector:@selector(shortcutButtonPressed:)
          listButtons:self.recentSearchButtons
       labelReference:self.recentSearchLabel];
    
    return button;
    
}

-(TrendingNowButton *)createTrendingNowButtonWithText:(NSString *)text {
    
    TrendingNowButton *button = [TrendingNowButton new];
    
    [self setupButton:button
                 text:text
             selector:@selector(shortcutButtonPressed:)
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
    button.y = labelReference.y + labelReference.height + ( listButtons.count * ( button.height + 8 ) ) - 30;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self.view addSubview:button];
    
}

-(int)positionToSearchBackground {
    
    NSMutableArray *listButtons = [self listWithMoreButtons];
    
    if ( listButtons ) {
        
        UIButton *button = [listButtons lastObject];
        
        int position = button.y + button.height + 55;
        int positionCandidate = [DeviceInfo height] - self.searchBackground.height;
        
        if ( position > positionCandidate )
            position = positionCandidate;
        
        return position;
        
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

-(CGFloat)lineRecentSearchesAxisXWithWidth:(CGFloat)width {
    
    CGFloat distance = [DeviceInfo isIpad]?DISTANCE_BETWEEN_SUBCOLUMNS_MAIN_VIEW_FOR_IPAD:DISTANCE_BETWEEN_SUBCOLUMNS_MAIN_VIEW_FOR_IPHONE;
    
    return width/2 - self.lineRecentSearches.width - distance/2;

}

-(CGFloat)lineRecentSearchesAxisY {
    return self.twitterLogo.y + self.twitterLogo.height + ( [DeviceInfo isIpad]?89:34 );
}

-(CGFloat)lineTrendingNowAxisX {
    
    CGFloat axisX = self.lineRecentSearches.x + self.lineRecentSearches.width;
    
    if ( [DeviceInfo isIphone] )
        axisX += DISTANCE_BETWEEN_SUBCOLUMNS_MAIN_VIEW_FOR_IPHONE;
    else
        axisX += DISTANCE_BETWEEN_SUBCOLUMNS_MAIN_VIEW_FOR_IPAD;
    
    return axisX;
    
}

-(CGFloat)lineTrendingNowAxisY {
    return self.twitterLogo.y + self.twitterLogo.height + ( [DeviceInfo isIpad]?89:34 );
}

-(CGFloat)recentSearchLabelAxisY {
    return self.lineRecentSearches.y + self.lineRecentSearches.height + 8;
}

-(CGFloat)trendingNowLabelAxisY {
    return self.lineTrendingNow.y + self.lineTrendingNow.height + 8;
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
        _lineRecentSearches.x = [self lineRecentSearchesAxisXWithWidth:[DeviceInfo width]];
        _lineRecentSearches.y = [self lineRecentSearchesAxisY];
        
    }
    
    return _lineRecentSearches;
    
}

-(RecentSearchLabel *)recentSearchLabel {
    
    if ( ! _recentSearchLabel ) {
        
        _recentSearchLabel = [RecentSearchLabel new];
        _recentSearchLabel.x = self.lineRecentSearches.x;
        _recentSearchLabel.y = [self recentSearchLabelAxisY];
        
    }
    
    return _recentSearchLabel;
    
}

-(LineView *)lineTrendingNow {
    
    if ( ! _lineTrendingNow ) {
        
        _lineTrendingNow = [LineView new];
        _lineTrendingNow.x = [self lineTrendingNowAxisX];
        _lineTrendingNow.y = [self lineTrendingNowAxisY];
        
    }
    
    return _lineTrendingNow;
    
}

-(TrendingNowLabel *)trendingNowLabel {
    
    if ( ! _trendingNowLabel ) {
        
        _trendingNowLabel = [TrendingNowLabel new];
        _trendingNowLabel.x = self.lineTrendingNow.x;
        _trendingNowLabel.y = [self trendingNowLabelAxisY];
        
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
    
    if ( ! _recentSearchButtons )
        _recentSearchButtons = [NSMutableArray new];
    
    return _recentSearchButtons;
    
}

-(NSMutableArray *)trendingNowButtons {
    
    if ( ! _trendingNowButtons )
        _trendingNowButtons = [NSMutableArray new];
    
    return _trendingNowButtons;
    
}

@end
