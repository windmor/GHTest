//
//  GHRepositoriesListCell.h
//  GHTest
//
//  Created by Liliya Sayfutdinova on 10/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GHListCellInterface.h"

NS_ASSUME_NONNULL_BEGIN

@class GHRepository;

@interface GHRepositoriesListCell : UITableViewCell <GHListCellInterface>

- (void)fillWithData:(GHRepository *)repository;

@end

NS_ASSUME_NONNULL_END
