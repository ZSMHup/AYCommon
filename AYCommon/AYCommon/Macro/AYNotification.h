//
//  AYNotification.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/17.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AYNotification : NSObject

@end

CG_INLINE void NotificationRegister(id observer, SEL selector, NSString *name, id object) {

    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object];
}

CG_INLINE void NotificationPost(NSString *name, id object, NSDictionary *userInfo) {

    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

CG_INLINE void NotificationRemove(id observer, NSString *name, id object) {

    [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:object];
}

CG_INLINE void NotificationRemoveAll(id observer) {

    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}

/* 宏定义__发送通知 */
#define kPostNotificationName(n) [[NSNotificationCenter defaultCenter] postNotificationName:n object:nil]
#define kPostNotificationName_object(n, o) [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]

/**
 通知: 测试
 */
UIKIT_EXTERN NSString *const TEST;

