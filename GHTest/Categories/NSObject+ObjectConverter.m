//
//  NSObject+ObjectConverter.m
//   
//
//  Created by Liliya Sayfutdinova on 1/28/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "NSObject+ObjectConverter.h"

@implementation NSObject (ObjectConverter)

- (NSInteger)convertToInteger
{
    if (![self isEqual:[NSNull null]])
        return [(id)self integerValue];
    else
        return NSNotFound;
}

- (NSString *)convertToString
{
    if (self && ![self isEqual:[NSNull null]])
        return [[NSString alloc] initWithFormat:@"%@", self];
    else
        return @"";
}

- (BOOL)convertToBOOL
{
    if (![self isEqual:[NSNull null]])
        return [(id)self boolValue];
    else
        return NO;
}

- (NSDictionary *)convertToDictionary
{
    if (!self || (self && [self isEqual:[NSNull null]]) || ![self isKindOfClass:[NSDictionary class]])
        return nil;
    else
        return [[NSDictionary dictionaryWithDictionary:(id)self] copy];
}

- (NSArray *)convertToArray
{
    if (!self || ((self && [self isEqual:[NSNull null]]) && ![self isKindOfClass:[NSArray class]]))
        return nil;
    else
        return [[NSArray arrayWithArray:(id)self] copy];
}

@end
