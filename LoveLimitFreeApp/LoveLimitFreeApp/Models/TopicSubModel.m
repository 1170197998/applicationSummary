//
//  XSFTopicSubModel.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "TopicSubModel.h"

@implementation TopicSubModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        self.applicationId = dictionary[@"applicationId"];
        self.downloads = dictionary[@"downloads"];
        self.iconUrl = dictionary[@"iconUrl"];
        self.name = dictionary[@"name"];
        self.ratingOverall = dictionary[@"ratingOverall"];
        self.starOverall = dictionary[@"starOverall"];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
