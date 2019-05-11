//
//  ABNetwork.m
//   
//
//  Created by Liliya Sayfutdinova on 1/28/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "ABNetwork.h"

#import "NSDictionary+Networking.h"
#import "NSData+JSON.h"

static const NSString *API_URL = @"https://api.github.com";

@implementation ABNetwork

+ (void)sendGETRequestWithPath:(NSString *)path
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(NSDictionary *response))success
                       failure:(void (^)(NSError *error))failure
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{@"Accept" : @"application/json"}];
    config.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;//NSURLRequestReloadIgnoringLocalCacheData;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    if (session) {
        NSString *dataUrl = [NSString stringWithFormat:@"%@/%@", API_URL, path];
        NSURLComponents *components = [NSURLComponents componentsWithString:dataUrl];
        components.queryItems = parameters.queryItems;

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:components.URL];
        request.HTTPMethod = @"GET";
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            if (error) {
                                                                NSCachedURLResponse *cachedURLResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
                                                                if (cachedURLResponse) {
                                                                    if (success) success(cachedURLResponse.data.JSONData);
                                                                } else {
                                                                    if (failure) failure(error);
                                                                }
                                                            } else {
                                                                if (((NSHTTPURLResponse *)response).statusCode != 200) {
                                                                    NSError *error = [NSError errorWithDomain:@"GH"
                                                                                                         code:-1
                                                                                                     userInfo:@{NSLocalizedDescriptionKey : [NSHTTPURLResponse localizedStringForStatusCode:((NSHTTPURLResponse *)response).statusCode]}];
                                                                    if (failure) failure(error);
                                                                } else {
                                                                    if (success) success(data.JSONData);
                                                                }
                                                            }
                                                        });
                                                    }];
        [dataTask resume];
    }
}

+ (void)downloadImageByPath:(NSString *)path
                 parameters:(NSDictionary *)parameters
                    success:(void (^)(UIImage *image))success
                    failure:(void (^)(NSError *error))failure
{
    NSString *dataUrl = [NSString stringWithFormat:@"%@/%@", API_URL, path];
    NSURLComponents *components = [NSURLComponents componentsWithString:dataUrl];
    components.queryItems = parameters.queryItems;

    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession] downloadTaskWithURL:components.URL
                                                                                  completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                                                          if (error) {
                                                                                              if (failure) failure(error);
                                                                                          } else {
                                                                                              UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                                                                                              if (success) success(downloadedImage);
                                                                                          }
                                                                                      });
                                                                                  }];
    [downloadPhotoTask resume];
}

@end
