//
//  XSFRequest.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/31.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFRequest.h"
#import "AFNetworking.h"
@implementation XSFRequest

+ (void)RequestDataWithPath:(NSString *)path Finish:(void (^)(NSDictionary *))finished
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        finished(dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求出错 %@",error);
        
    }];
}

@end
