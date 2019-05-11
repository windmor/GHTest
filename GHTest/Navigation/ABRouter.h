//
//  ABRouter.h
//   
//
//  Created by Liliya Sayfutdinova on 1/29/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GHRepository;

@interface ABRouter : NSObject

+ (void)showRepositoriesListInNavigationCtrl:(UINavigationController *)rootNavigationCtrl;

+ (void)showLastCommitForRepository:(GHRepository *)repository
                   inNavigationCtrl:(UINavigationController *)rootNavigationCtrl;

@end

NS_ASSUME_NONNULL_END
