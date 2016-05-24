//
//  XSFTopicModel.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFTopicModel.h"

@implementation XSFTopicModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        self.title = dictionary[@"title"];
        self.date = dictionary[@"date"];
        self.desc = dictionary[@"desc"];
        self.desc_img = dictionary[@"desc_img"];
        self.img = dictionary[@"img"];
        
        self.applications = dictionary[@"applications"];
    }
   return self;
}

@end
