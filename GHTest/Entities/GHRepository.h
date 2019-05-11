//
//  GHRepository.h
//  GHTest
//
//  Created by Liliya Sayfutdinova on 10/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GHAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHRepository : NSObject

@property (nonatomic, copy) NSString *repositoryId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *descriptionText;
@property (nonatomic, strong) GHAccount *owner;

@end

NS_ASSUME_NONNULL_END
