//
//  GHAPI.m
//   
//
//  Created by Liliya Sayfutdinova on 1/28/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "GHAPI.h"

#import "ABNetwork.h"

#import "GHRepository.h"
#import "GHRepository+Parse.h"

#import "GHCommit.h"
#import "GHCommit+Parse.h"

#import "NSObject+ObjectConverter.h"

@implementation GHAPI

+ (void)getRepositoriesByString:(NSString *)searchString
                     pageNumber:(NSInteger)pageNumber
                   itemsPerPage:(NSInteger)itemsPerPage
                        success:(void (^)(NSArray <GHRepository *>* repositories))success
                        failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{
                                 @"q":searchString,
                                 @"page":[NSString stringWithFormat:@"%li", (long)pageNumber],
                                 @"per_page":[NSString stringWithFormat:@"%li", (long)itemsPerPage]
                                 };
    
    [ABNetwork sendGETRequestWithPath:@"search/repositories"
                           parameters:parameters
                              success:^(NSDictionary * _Nonnull response) {
                                  BOOL incompleteResults = [response[@"incomplete_results"] convertToBOOL];
                                  if (!incompleteResults) {
                                      NSArray <NSDictionary *>*items = [response[@"items"] convertToArray];
                                      NSMutableArray <GHRepository *>*repositories = [NSMutableArray new];
                                      for (NSDictionary *item in items) {
                                          @autoreleasepool {
                                              GHRepository *repository = [[GHRepository alloc] initWithDict:item];
                                              if (repository) {
                                                  [repositories addObject:repository];
                                              }
                                          }
                                      }
                                      if (success) success(repositories);
                                  } else {
                                      NSError *error = [NSError errorWithDomain:@"GH"
                                                                           code:-1
                                                                       userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(@"Incomplete results", nil)}];
                                      if (failure) failure(error);
                                  }
                              }
                              failure:^(NSError * _Nonnull error) {
                                  if (failure) failure(error);
                              }];
}

+ (void)getCommitsForRepository:(GHRepository *)repository
                        success:(void (^)(NSArray <GHCommit *>* commits))success
                        failure:(void (^)(NSError *error))failure
{
    [ABNetwork sendGETRequestWithPath:[NSString stringWithFormat:@"repos/%@/commits", repository.name]
                           parameters:@{}
                              success:^(NSDictionary * _Nonnull response) {
                                  NSArray <NSDictionary *>*items = [response convertToArray];
                                  NSMutableArray <GHCommit *>*commits = [NSMutableArray new];
                                  for (NSDictionary *item in items) {
                                      @autoreleasepool {
                                          GHCommit *commit = [[GHCommit alloc] initWithDict:item];
                                          if (commit) {
                                              [commits addObject:commit];
                                          }
                                      }
                                  }
                                  if (success) success(commits);
                              }
                              failure:^(NSError * _Nonnull error) {
                                  if (failure) failure(error);
                              }];
}

@end
