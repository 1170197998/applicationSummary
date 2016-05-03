//
//  XSRTopicequest.h
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSFTopicRequest : NSObject

+ (void)RequestDataWithPath:(NSString *)path Finish:(void(^)(NSArray *array))finished;

@end
