//
//  GHBaseTableView.m
//  GHTest
//
//  Created by Liliya Sayfutdinova on 10/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "GHBaseTableView.h"

@interface GHBaseTableView () <UITableViewDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, assign) BOOL isLoading;

@end

@implementation GHBaseTableView

- (void)initTablePaging
{
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.frame = CGRectMake(0, 0, 44, 44);
    self.tableFooterView = self.activityIndicator;
    
    self.contentInset = UIEdgeInsetsMake(0, 0, -44, 0);
    self.isLoading = NO;
}

- (void)stopLoading
{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.contentInset = UIEdgeInsetsMake(0, 0, -44, 0);
                     }
                     completion:nil];
    self.isLoading = NO;
    [self.activityIndicator stopAnimating];
}

- (void)tableViewWillDisplayForRowAtIndexPath:(NSIndexPath *)indexPath
                                   itemsCount:(NSInteger)itemsCount
                         lastLoadedItemsCount:(NSInteger)lastLoadedItemsCount
                                 itemsPerPage:(NSInteger)itemsPerPage
{
    if (itemsCount - indexPath.row <= 5 && !self.isLoading && lastLoadedItemsCount == itemsPerPage) {
        [self loadNextPage];
    }
}

- (void)loadNextPage
{
    weakify(self);
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         strongify(self);
                         self.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
                     }
                     completion:nil];
    [self.activityIndicator startAnimating];
    if ([self.pagingDelegate respondsToSelector:@selector(loadNextPage)]) {
        self.isLoading = YES;
        [self.pagingDelegate loadNextPage];
    }
}

@end
