//
//  GHBaseTableView.h
//  GHTest
//
//  Created by Liliya Sayfutdinova on 10/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GHBaseTableViewDelegate <NSObject>

@optional
- (void)loadNextPage;

@end

@interface GHBaseTableView : UITableView

@property (nonatomic, weak) id <GHBaseTableViewDelegate> pagingDelegate;

- (void)initTablePaging;

- (void)stopLoading;

- (void)tableViewWillDisplayForRowAtIndexPath:(NSIndexPath *)indexPath
                                   itemsCount:(NSInteger)itemsCount
                         lastLoadedItemsCount:(NSInteger)lastLoadedItemsCount
                                 itemsPerPage:(NSInteger)itemsPerPage;

@end

NS_ASSUME_NONNULL_END
