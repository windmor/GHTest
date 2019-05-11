//
//  NSDictionary+Networking.m
//   
//
//  Created by Liliya Sayfutdinova on 1/28/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "NSDictionary+Networking.h"

@implementation NSDictionary (Networking)

- (NSArray *)queryItems
{
    NSMutableArray *items = [NSMutableArray new];
    for (NSString *key in self) {
        [items addObject:[NSURLQueryItem queryItemWithName:key value:self[key]]];
    }
    return items;
}

@end
