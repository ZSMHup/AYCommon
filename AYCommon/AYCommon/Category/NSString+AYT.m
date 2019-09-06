//
//  NSString+AYT.m
//  AYCommon
//
//  Created by zsm on 2019/7/3.
//  Copyright © 2019 ZSM. All rights reserved.
//

#import "NSString+AYT.h"

@implementation NSString (AYT)

- (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

@end
