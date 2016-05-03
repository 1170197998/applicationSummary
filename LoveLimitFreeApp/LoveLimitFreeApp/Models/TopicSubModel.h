//
//  XSFTopicSubModel.h
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TopicSubModel
@end

@interface TopicSubModel : NSObject

@property (nonatomic,copy)NSString *applicationId;
@property (nonatomic,copy)NSString *downloads;
@property (nonatomic,copy)NSString *iconUrl;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *ratingOverall;
@property (nonatomic,copy)NSString *starOverall;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
