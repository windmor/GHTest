//
//  ABNetwork.h
//   
//
//  Created by Liliya Sayfutdinova on 1/28/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABNetwork : NSObject

+ (void)sendGETRequestWithPath:(NSString *)path
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(NSDictionary *response))success
                       failure:(void (^)(NSError *error))failure;

+ (void)downloadImageByPath:(NSString *)path
                 parameters:(NSDictionary *)parameters
                    success:(void (^)(UIImage *image))success
                    failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
