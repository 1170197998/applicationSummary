//
//  XSFRequest.h
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/31.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSFRequest : NSObject

+ (void)RequestDataWithPath:(NSString *)path Finish:(void(^)(NSDictionary *dictinary))finished;

@end
