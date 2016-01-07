//
//  PickLocation.h
//  城市选择器
//
//  Created by 杨威 on 15/12/29.
//  Copyright © 2015年 杨威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PickLocation : NSObject

@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *district;
@property (copy, nonatomic) NSString *street;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
