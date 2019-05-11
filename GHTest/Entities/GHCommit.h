//
//  GHCommit.h
//  GHTest
//
//  Created by Liliya Sayfutdinova on 11/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GHAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHCommit : NSObject

@property (nonatomic, copy) NSString *sha;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) GHAccount *author;

@end

NS_ASSUME_NONNULL_END
