//
//  GHRepositoriesManager.h
//  GHTest
//
//  Created by Liliya Sayfutdinova on 10/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - GHRepositoriesManagerDelegate

@class GHRepositoriesManager;

@protocol GHRepositoriesManagerDelegate <NSObject>

@optional
- (void)repositoriesManagerWillLoadItems:(GHRepositoriesManager *)repositoriesManager
                                  reload:(BOOL)reload
                              completion:(void (^)(BOOL refreshControlShown))completion;

@optional
- (void)repositoriesManagerDidLoadItems:(GHRepositoriesManager *)repositoriesManager
                                 reload:(BOOL)reload
                             completion:(void (^)(BOOL refreshControlHidden))completion;

@end

#pragma mark - GHRepositoriesManager

@class GHRepository;

@interface GHRepositoriesManager : NSObject <UITableViewDataSource>

@property (nonatomic, assign) NSInteger lastLoadedItemsCount;

@property (weak) id <GHRepositoriesManagerDelegate> delegate;

- (void)reloadData;
- (void)loadNextPage;

- (NSInteger)repositoriesCount;
- (NSInteger)countPerPage;
- (GHRepository *)repositoryAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
