//
//  ViewController.m
//  城市选择器
//
//  Created by 杨威 on 15/12/24.
//  Copyright © 2015年 杨威. All rights reserved.
//

#import "ViewController.h"
#import "PickView.h"
@interface ViewController ()
{
    UITapGestureRecognizer * tap;
}
@property(nonatomic,strong)PickView * pick;
@property (strong, nonatomic) IBOutlet UILabel *showLable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenPickView:)];
//    tap.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:tap];
    
    
    
}

- (IBAction)selectBtnAction:(UIButton *)sender {
    // pickView 呈现
    [self.pick showInView:self.view];
    
    __weak ViewController * vc = self;
    // 选择回调
    self.pick.selectedCity = ^(PickView * pick){
        // 回调pickview信息  在pickview属性中 包含了location属性 对应着当前选中城市的所有信息
        NSLog(@"%@",pick.location.city);
        vc.showLable.text = pick.location.city;
    };
}

-(void)hiddenPickView:(UITapGestureRecognizer *)tap
{
    // 将 pickview隐藏
    [self.pick cancelPicker];
}

-(PickView *)pick
{
    if (!_pick) {
        _pick = [[PickView alloc]initWithFrame:self.view.frame];
    }
    return _pick;
}
@end
