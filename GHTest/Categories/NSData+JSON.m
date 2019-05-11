//
//  NSData+JSON.m
//   
//
//  Created by Liliya Sayfutdinova on 1/28/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

- (id)JSONData
{
    NSError *error = nil;
 
    id JSONObject = [NSJSONSerialization JSONObjectWithData:self
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    if (error) {
        return nil;
    }
    
    return JSONObject;
}

@end
