//
//  GHCommitsManager.h
//  GHTest
//
//  Created by Liliya Sayfutdinova on 11/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - GHCommitsManagerDelegate

@class GHCommitsManager;

@protocol GHCommitsManagerDelegate <NSObject>

@optional
- (void)commitsManagerWillLoadItems:(GHCommitsManager *)commitsManager
                             reload:(BOOL)reload
                         completion:(void (^)(BOOL refreshControlShown))completion;

@optional
- (void)commitsManagerDidLoadItems:(GHCommitsManager *)commitsManager
                            reload:(BOOL)reload
                        completion:(void (^)(BOOL refreshControlHidden))completion;

@end

#pragma mark - GHCommitsManager

@class GHRepository, GHCommit;

@interface GHCommitsManager : NSObject <UITableViewDataSource>

@property (weak) id <GHCommitsManagerDelegate> delegate;

@property (nonatomic, strong) GHRepository *repository;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
