//
//  GHCommitCell.h
//  GHTest
//
//  Created by Liliya Sayfutdinova on 12/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GHListCellInterface.h"

NS_ASSUME_NONNULL_BEGIN

@class GHCommit;

@interface GHCommitCell : UITableViewCell <GHListCellInterface>

- (void)fillWithData:(GHCommit *)commit;

@end

NS_ASSUME_NONNULL_END
