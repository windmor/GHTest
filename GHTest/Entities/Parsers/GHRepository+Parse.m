//
//  GHRepository+Parse.m
//  GHTest
//
//  Created by Liliya Sayfutdinova on 10/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "GHRepository+Parse.h"

#import "NSObject+ObjectConverter.h"

@implementation GHRepository (Parse)

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.repositoryId = [dict[@"id"] convertToString];
        self.name = [dict[@"full_name"] convertToString];
        self.language = [dict[@"language"] convertToString];
        if (dict[@"description"]) {
            self.descriptionText = [dict[@"description"] convertToString];
        }
        
        if (dict[@"owner"]) {
            GHAccount *owner = [GHAccount new];
            owner.login = [dict[@"owner"][@"login"] convertToString];
            owner.accountId = [dict[@"owner"][@"id"] convertToInteger];
            owner.avatarUrl = [dict[@"owner"][@"avatar_url"] convertToString];
            self.owner = owner;
        }
    }
    return self;
}


@end
