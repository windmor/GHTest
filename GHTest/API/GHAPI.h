//
//  GHAPI.h
//   
//
//  Created by Liliya Sayfutdinova on 1/28/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GHRepository, GHCommit;

@interface GHAPI : NSObject

+ (void)getRepositoriesByString:(NSString *)searchString
                     pageNumber:(NSInteger)pageNumber
                   itemsPerPage:(NSInteger)itemsPerPage
                        success:(void (^)(NSArray <GHRepository *>* repositories))success
                        failure:(void (^)(NSError *error))failure;

+ (void)getCommitsForRepository:(GHRepository *)repository
                        success:(void (^)(NSArray <GHCommit *>* commits))success
                        failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
