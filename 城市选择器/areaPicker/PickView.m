//
//  PickView.m
//  城市选择器
//
//  Created by 杨威 on 15/12/24.
//  Copyright © 2015年 杨威. All rights reserved.
//

#import "PickView.h"

@interface PickView ()
{
    NSArray *provinces, *cities, *areas;
}


@end

@implementation PickView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pickview.delegate = self;
        self.pickview.dataSource = self;
        
        [self addSubview:self.pickview];
        
        provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
        cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
        
        self.location.state = [[provinces objectAtIndex:0] objectForKey:@"state"];
        self.location.city = [[cities objectAtIndex:0] objectForKey:@"city"];
        
        areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
        if (areas.count > 0) {
            self.location.district = [areas objectAtIndex:0];
        } else{
            self.location.district = @"";
        }
        
    }
    return self;
}

#pragma mark - 懒加载方法
-(PickLocation *)location
{
    if (!_location) {
        _location = [[PickLocation alloc ]init];
    }
    return _location;
}

-(UIPickerView *)pickview
{
    if (!_pickview) {
        _pickview = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.frame.size.height / 2, self.frame.size.width, self.frame.size.height / 2)];
    }
    return _pickview;
}

#pragma mark - animation
- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
}

- (void)cancelPicker
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}



#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
                return [areas count];
                break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   switch (component) {
       case 0:
           return [[provinces objectAtIndex:row] objectForKey:@"state"];
           break;
       case 1:
           return [[cities objectAtIndex:row] objectForKey:@"city"];
           break;
       case 2:
           if ([areas count] > 0) {
               return [areas objectAtIndex:row];
               break;
           }
       default:
           return  @"";
           break;
   }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   switch (component) {
       case 0:
           cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
           [self.pickview selectRow:0 inComponent:1 animated:YES];
           [self.pickview reloadComponent:1];
           
           areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
           [self.pickview selectRow:0 inComponent:2 animated:YES];
           [self.pickview reloadComponent:2];
           
           self.location.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
           self.location.city = [[cities objectAtIndex:0] objectForKey:@"city"];
           if ([areas count] > 0) {
               self.location.district = [areas objectAtIndex:0];
           } else{
               self.location.district = @"";
           }
           break;
       case 1:
           areas = [[cities objectAtIndex:row] objectForKey:@"areas"];
           [self.pickview selectRow:0 inComponent:2 animated:YES];
           [self.pickview reloadComponent:2];
           
           self.location.city = [[cities objectAtIndex:row] objectForKey:@"city"];
           if ([areas count] > 0) {
               self.location.district = [areas objectAtIndex:0];
           } else{
               self.location.district = @"";
           }
           break;
       case 2:
           if ([areas count] > 0) {
               self.location.district = [areas objectAtIndex:row];
           } else{
               self.location.district = @"";
           }
           break;
       default:
           break;
   }
    if (self.selectedCity) {
        self.selectedCity(self);
    }
}
@end

