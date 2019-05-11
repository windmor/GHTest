//
//  GHRepoLastCommit.h
//  GHTest
//
//  Created by Liliya Sayfutdinova on 11/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GHCommitsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHRepoLastCommit : UITableViewController

@property (nonatomic, strong) GHCommitsManager *commitsManager;

@end

NS_ASSUME_NONNULL_END
