//
//  PickView.h
//  城市选择器
//
//  Created by 杨威 on 15/12/24.
//  Copyright © 2015年 杨威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickLocation.h"

@interface PickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UIPickerView * pickview;


@property (copy, nonatomic) void (^selectedCity)(PickView * pickView);

@property (strong, nonatomic) PickLocation * location;

//- (id)initPickView;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)showInView:(UIView *)view;
- (void)cancelPicker;



@end
