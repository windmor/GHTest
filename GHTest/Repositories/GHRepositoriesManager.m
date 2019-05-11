//
//  GHRepositoriesManager.m
//  GHTest
//
//  Created by Liliya Sayfutdinova on 10/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "GHRepositoriesManager.h"

#import "GHRepositoriesListCell.h"

#import "GHAPI.h"

@interface GHRepositoriesManager ()

@property (nonatomic, strong) NSMutableArray <GHRepository *>*repositories;

@property (nonatomic, assign) BOOL isLoading;

@end

@implementation GHRepositoriesManager

- (instancetype)init
{
    if (self = [super init]) {
        self.repositories = [NSMutableArray new];
        self.lastLoadedItemsCount = self.countPerPage;
    }
    return self;
}

- (NSInteger)repositoriesCount
{
    return self.repositories.count;
}

- (NSInteger)countPerPage
{
    return 20;
}

#pragma mark - Load data

- (void)reloadData
{
    [self.repositories removeAllObjects];
    self.lastLoadedItemsCount = self.countPerPage;
    [self loadNextPage];
}

- (void)loadNextPage
{
    @synchronized (self) {
        if (self.isLoading) {
            return;
        }
        self.isLoading = YES;
        
        BOOL reload = NO;
        if (self.repositories.count == 0) {
            showWaitView();
            reload = YES;
        }
        weakify(self);
        [self repositoriesManagerWillLoadItems:self
                                        reload:reload
                                   completion:^(BOOL refreshControlShown) {
                                       strongify(self);
                                       weakify(self);
                                       [GHAPI getRepositoriesByString:@"swift"
                                                           pageNumber:self.repositories.count/self.countPerPage + 1
                                                         itemsPerPage:self.countPerPage
                                                              success:^(NSArray<GHRepository *> * _Nonnull repositories) {
                                                                  strongify(self);
                                                                  hideWaitView();
                                                                  self.isLoading = NO;
                                                                  self.lastLoadedItemsCount = repositories.count;
                                                                  if (self.repositories.count == 0) {
                                                                      [self.repositories setArray:repositories];
                                                                  } else {
                                                                      [self.repositories addObjectsFromArray:repositories];
                                                                  }
                                                                  [self repositoriesManagerDidLoadItems:self
                                                                                                 reload:reload
                                                                                             completion:nil];
                                                              }
                                                              failure:^(NSError * _Nonnull error) {
                                                                  strongify(self);
                                                                  hideWaitView();
                                                                  self.isLoading = NO;
                                                                  showWarningAlert(error.localizedDescription);
                                                                  [self repositoriesManagerDidLoadItems:self
                                                                                                 reload:reload
                                                                                             completion:nil];
                                                              }];
                                   }];
    }
}

- (GHRepository *)repositoryAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.repositories.count) {
        return self.repositories[indexPath.row];
    }
    
    return nil;
}
         
#pragma mark - GHRepositoriesManagerDelegate

- (void)repositoriesManagerWillLoadItems:(GHRepositoriesManager *)repositoriesManager
                                 reload:(BOOL)reload
                             completion:(void (^)(BOOL refreshControlShown))completion
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(repositoriesManagerWillLoadItems:reload:completion:)]) {
            weakify(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                strongify(self);
                [self.delegate repositoriesManagerWillLoadItems:repositoriesManager
                                                        reload:reload
                                                    completion:completion];
            });
        } else {
            if (completion) completion(NO);
        }
    } else {
        if (completion) completion(NO);
    }
}

- (void)repositoriesManagerDidLoadItems:(GHRepositoriesManager *)repositoriesManager
                                reload:(BOOL)reload
                            completion:(void (^)(BOOL refreshControlHidden))completion
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(repositoriesManagerDidLoadItems:reload:completion:)]) {
            weakify(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                strongify(self);
                [self.delegate repositoriesManagerDidLoadItems:repositoriesManager
                                                       reload:reload
                                                   completion:completion];
            });
        } else {
            if (completion) completion(YES);
        }
    } else {
        if (completion) completion(YES);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self repositoriesCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHRepositoriesListCell *cell = [tableView dequeueReusableCellWithIdentifier:[GHRepositoriesListCell cellID]
                                                                   forIndexPath:indexPath];
    GHRepository *repository = nil;
    if (indexPath.row < self.repositories.count) {
        repository = self.repositories[indexPath.row];
    }
    if (repository) {
        [cell fillWithData:repository];
    }
    return cell;
}

@end
