//
//  GHCommit+Parse.m
//  GHTest
//
//  Created by Liliya Sayfutdinova on 11/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "GHCommit+Parse.h"

#import "NSObject+ObjectConverter.h"

@implementation GHCommit (Parse)

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.sha = [dict[@"sha"] convertToString];
        self.message = [dict[@"commit"][@"message"] convertToString];
        
        GHAccount *author = [GHAccount new];
        author.name = [dict[@"commit"][@"author"][@"name"] convertToString];
        if ([dict[@"author"] convertToDictionary]) {
            author.accountId = [dict[@"author"][@"id"] convertToInteger];
            author.avatarUrl = [dict[@"author"][@"avatar_url"] convertToString];
        }
        self.author = author;
    }
    return self;
}

@end
