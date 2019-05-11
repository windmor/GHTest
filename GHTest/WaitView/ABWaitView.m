//
//  ABWaitView.m
//   
//
//  Created by Liliya Sayfutdinova on 1/30/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "ABWaitView.h"

@implementation ABWaitView

+ (instancetype)instance;
{
        return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ABWaitView class])
                                             owner:self
                                           options:nil].firstObject;
}

@end
