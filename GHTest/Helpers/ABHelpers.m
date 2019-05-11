//
//  ABHelpers.m
//   
//
//  Created by Liliya Sayfutdinova on 1/29/19.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "ABHelpers.h"

#import "ABWaitView.h"

#pragma mark - Wait View

UIWindow *realKeyWindow()
{
    UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    if ([currentKeyWindow isMemberOfClass:[UIWindow class]]) {
        return currentKeyWindow;
    } else {
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            if ([window isMemberOfClass:[UIWindow class]]) {
                return window;
            }
        }
        return currentKeyWindow;
    }
}

BOOL waitViewIsShown;
void showWaitView(void)
{
    waitViewIsShown = YES;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        if (!waitView && waitViewIsShown == YES) {
            waitView = [ABWaitView instance];
            waitView.frame = [[UIScreen mainScreen] bounds];
            [realKeyWindow() addSubview:waitView];
        }
    });
}

void hideWaitView(void)
{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        waitViewIsShown = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [waitView removeFromSuperview];
            waitView = nil;
        });
    });
}

#pragma mark - Alerts

void showWarningAlert(NSString *message)
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                     }];
    [alert addAction:okButton];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert
                                                                                 animated:YES
                                                                               completion:nil];
}

