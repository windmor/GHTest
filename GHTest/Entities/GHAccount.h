//
//  GHAccount.h
//  GHTest
//
//  Created by Liliya Sayfutdinova on 11/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHAccount : NSObject

@property (nonatomic, assign) NSInteger accountId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *avatarUrl;

@end

NS_ASSUME_NONNULL_END
