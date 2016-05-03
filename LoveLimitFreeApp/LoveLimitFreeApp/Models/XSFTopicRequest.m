//
//  XSRTopicequest.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFTopicRequest.h"
#import "AFNetworking.h"
@implementation XSFTopicRequest

+ (void)RequestDataWithPath:(NSString *)path Finish:(void (^)(NSArray *))finished
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        finished(array);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求出错 %@",error);
        
    }];
}

@end
