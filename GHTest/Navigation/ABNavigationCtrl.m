//
//  ABNavigationCtrl.m
//   
//
//  Created by Liliya Sayfutdinova on 1/29/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "ABNavigationCtrl.h"

#import "ABRouter.h"

static ABNavigationCtrl *sharedNavigationCtrl;

@implementation ABNavigationCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ABRouter showRepositoriesListInNavigationCtrl:self];
}

@end
