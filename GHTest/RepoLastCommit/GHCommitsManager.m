//
//  GHCommitsManager.m
//  GHTest
//
//  Created by Liliya Sayfutdinova on 11/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "GHCommitsManager.h"

#import "GHAPI.h"
#import "GHCommitCell.h"

@interface GHCommitsManager ()

@property (nonatomic, strong) NSArray <GHCommit *>*commits;

@end

@implementation GHCommitsManager

- (instancetype)init
{
    if (self = [super init]) {
        self.commits = [NSMutableArray new];
    }
    return self;
}

- (void)reloadData
{
    if (!self.repository) {
        return;
    }
    
    showWaitView();
    weakify(self);
    [self commitsManagerWillLoadItems:self
                               reload:YES
                           completion:^(BOOL refreshControlShown) {
                               strongify(self);
                               weakify(self);
                               [GHAPI getCommitsForRepository:self.repository
                                                      success:^(NSArray<GHCommit *> * _Nonnull commits) {
                                                          hideWaitView();
                                                          strongify(self);
                                                          self.commits = commits;
                                                          [self commitsManagerDidLoadItems:self
                                                                                    reload:YES
                                                                                completion:nil];
                                                      }
                                                      failure:^(NSError * _Nonnull error) {
                                                          hideWaitView();
                                                          showWarningAlert(error.localizedDescription);
                                                          [self commitsManagerDidLoadItems:self
                                                                                    reload:YES
                                                                                completion:nil];
                                                      }];
                           }];
}

- (NSInteger)commitsCount
{
    return self.commits.count;
}

#pragma mark - GHCommitsManagerDelegate

- (void)commitsManagerWillLoadItems:(GHCommitsManager *)commitsManager
                             reload:(BOOL)reload
                         completion:(void (^)(BOOL refreshControlShown))completion
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(commitsManagerWillLoadItems:reload:completion:)]) {
            weakify(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                strongify(self);
                [self.delegate commitsManagerWillLoadItems:commitsManager
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

- (void)commitsManagerDidLoadItems:(GHCommitsManager *)commitsManager
                            reload:(BOOL)reload
                        completion:(void (^)(BOOL refreshControlHidden))completion
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(commitsManagerDidLoadItems:reload:completion:)]) {
            weakify(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                strongify(self);
                [self.delegate commitsManagerDidLoadItems:commitsManager
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
    return [self commitsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHCommitCell *cell = [tableView dequeueReusableCellWithIdentifier:[GHCommitCell cellID]
                                                         forIndexPath:indexPath];
    GHCommit *commit = nil;
    if (indexPath.row < self.commits.count) {
        commit = self.commits[indexPath.row];
    }
    if (commit) {
        [cell fillWithData:commit];
    }
    return cell;
}

@end
