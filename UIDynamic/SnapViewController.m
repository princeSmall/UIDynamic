//
//  SnapViewController.m
//  UIDynamic
//
//  Created by tongle on 2017/9/4.
//  Copyright © 2017年 tong. All rights reserved.
//

#import "SnapViewController.h"

@interface SnapViewController (){
    CGPoint p;
}
@property (nonatomic,strong)UIDynamicAnimator * animator;
@property (nonatomic,strong)UIView * redView;


@end

@implementation SnapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建一个仿真者[UIDynamicAnimator] 用来仿真物理行为
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.animator removeAllBehaviors];
    UITouch * touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    p = location;
    NSLog(@"%@",NSStringFromCGPoint(location));
     // 3 添加吸附事件
     UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.redView snapToPoint:location];
    // 改变震动幅度，0表示振幅最大，1振幅最小
    snap.damping = 0.5;
    // 4. 将吸附事件添加到仿真者行为中
    [self.animator addBehavior:snap];
    
}
-(UIView *)redView{
    if (_redView ==nil) {
        _redView = [[UIView alloc]initWithFrame:CGRectMake(p.x, p.y, 50, 50)];
        _redView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_redView];
    }
    return _redView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
