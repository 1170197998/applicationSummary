//
//  XSFTopicModel.h
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicSubModel.h"
@interface XSFTopicModel : NSObject

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *desc;
@property (nonatomic,copy)NSString *desc_img;
@property (nonatomic,copy)NSString *img;

@property (nonatomic, strong)NSArray * applications;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
