//
//  GHRepoLastCommit.m
//  GHTest
//
//  Created by Liliya Sayfutdinova on 11/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "GHRepoLastCommit.h"

#import "GHRepository.h"
#import "GHCommitCell.h"

@interface GHRepoLastCommit () <GHCommitsManagerDelegate>

@end

@implementation GHRepoLastCommit

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.commitsManager) {
        self.commitsManager.delegate = self;
    }
    
    self.tableView.dataSource = self.commitsManager;
    self.tableView.allowsSelection = NO;
    
    [self registerNibs];
    [self.commitsManager reloadData];
}

- (void)registerNibs
{
    [self.tableView registerNib:[UINib nibWithNibName:[GHCommitCell cellID] bundle:nil]
         forCellReuseIdentifier:[GHCommitCell cellID]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = self.commitsManager.repository.name;
    self.navigationController.navigationBar.topItem.title = @"Back";
}

#pragma mark - GHCommitsManagerDelegate

- (void)commitsManagerDidLoadItems:(GHCommitsManager *)commitsManager
                            reload:(BOOL)reload
                        completion:(void (^)(BOOL refreshControlHidden))completion
{
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
    
    if (completion)
        completion(YES);
}

@end
