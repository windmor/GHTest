//
//  GHRepositoriesList.m
//  GHTest
//
//  Created by Liliya Sayfutdinova on 10/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "GHRepositoriesList.h"

#import "GHBaseTableView.h"

#import "GHRepositoriesManager.h"

#import "GHRepositoriesListCell.h"

#import "ABRouter.h"

@interface GHRepositoriesList () <GHBaseTableViewDelegate, GHRepositoriesManagerDelegate, UITableViewDelegate>

@property (nonatomic, strong) GHBaseTableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) GHRepositoriesManager *repositoriesManager;

@end

@implementation GHRepositoriesList

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initTableView];
    
    [self.repositoriesManager reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Repositories";
}

- (void)viewDidLayoutSubviews
{
    self.tableView.frame = self.view.bounds;
}

#pragma mark - Table view

- (void)initTableView
{
    if (!self.tableView) {
        self.tableView = [GHBaseTableView new];
        self.tableView.frame = self.view.bounds;
        [self.view addSubview:self.tableView];
        
        [self.tableView initTablePaging];
        self.tableView.pagingDelegate = self;
        self.tableView.delegate = self;

        self.repositoriesManager = [GHRepositoriesManager new];
        self.repositoriesManager.delegate = self;
        self.tableView.dataSource = self.repositoriesManager;

        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self.repositoriesManager
                                action:@selector(reloadData)
                      forControlEvents:UIControlEventValueChanged];
        
        if ([self.tableView respondsToSelector:@selector(setRefreshControl:)]) {
            self.tableView.refreshControl = self.refreshControl;
        } else {
            [self.tableView addSubview:self.refreshControl];
        }
        
        /// Register cell
        [self.tableView registerNib:[UINib nibWithNibName:[GHRepositoriesListCell cellID] bundle:nil]
             forCellReuseIdentifier:[GHRepositoriesListCell cellID]];
    }
}

#pragma mark - GHBaseTableViewDelegate

- (void)loadNextPage
{
    [self.repositoriesManager loadNextPage];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView tableViewWillDisplayForRowAtIndexPath:indexPath
                                               itemsCount:[self.repositoriesManager repositoriesCount]
                                     lastLoadedItemsCount:self.repositoriesManager.lastLoadedItemsCount
                                             itemsPerPage:[self.repositoriesManager countPerPage]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHRepository *repository = [self.repositoriesManager repositoryAtIndexPath:indexPath];
    if (repository) {
        [ABRouter showLastCommitForRepository:repository inNavigationCtrl:self.navigationController];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - GHRepositoriesManagerDelegate

- (void)repositoriesManagerDidLoadItems:(GHRepositoriesManager *)repositoriesManager
                                 reload:(BOOL)reload
                             completion:(void (^)(BOOL refreshControlHidden))completion
{
    [self.refreshControl endRefreshing];
    [self.tableView stopLoading];
    [self.tableView reloadData];
    
    if (completion)
        completion(YES);
}

@end
