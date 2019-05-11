//
//  ABRouter.m
//   
//
//  Created by Liliya Sayfutdinova on 1/29/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "ABRouter.h"

#import "GHRepositoriesList.h"
#import "GHRepoLastCommit.h"

#import "GHRepository.h"

@implementation ABRouter

+ (void)showRepositoriesListInNavigationCtrl:(UINavigationController *)rootNavigationCtrl
{
    GHRepositoriesList *repositoriesList = [GHRepositoriesList new];
    [rootNavigationCtrl setViewControllers:@[repositoriesList]];
}

+ (void)showLastCommitForRepository:(GHRepository *)repository
                   inNavigationCtrl:(UINavigationController *)rootNavigationCtrl
{
    GHRepoLastCommit *lastCommitCtrl = [GHRepoLastCommit new];
    lastCommitCtrl.commitsManager = [GHCommitsManager new];
    lastCommitCtrl.commitsManager.repository = repository;
    [rootNavigationCtrl pushViewController:lastCommitCtrl animated:YES];
}

@end
