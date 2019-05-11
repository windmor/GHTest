//
//  NSObject+ObjectConverter.h
//   
//
//  Created by Liliya Sayfutdinova on 1/28/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ObjectConverter)

- (NSInteger)convertToInteger;
- (NSString *)convertToString;
- (BOOL)convertToBOOL;

- (NSDictionary *)convertToDictionary;
- (NSArray *)convertToArray;

@end

NS_ASSUME_NONNULL_END
