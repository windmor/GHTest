//
//  ABHelpers.h
//   
//
//  Created by Liliya Sayfutdinova on 1/29/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ABWaitView;

NS_ASSUME_NONNULL_BEGIN

#define weakify(var) __weak typeof(var) AHKWeak_##var = var;

#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = AHKWeak_##var; \
_Pragma("clang diagnostic pop")

static ABWaitView *waitView = nil;

void showWaitView(void);
void hideWaitView(void);

void showWarningAlert(NSString *message);

NS_ASSUME_NONNULL_END
