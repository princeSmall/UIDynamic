//
//  gravityViewController.m
//  UIDynamic
//
//  Created by iOS on 2017/9/1.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "gravityViewController.h"

@interface gravityViewController ()<UIDynamicAnimatorDelegate>
@property (nonatomic,strong)UIDynamicAnimator * animator;
@property (nonatomic,strong)UIGravityBehavior * gravity;
@property (nonatomic,strong)UICollisionBehavior * collision;
@property (nonatomic,strong)UIView * redView;

@end

@implementation gravityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     // 创建一个仿真者[UIDynamicAnimator] 用来仿真物理行为
     self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    UITouch * touch = touches.anyObject;
    
    CGPoint location = [touch locationInView:self.view];
    
    
    self.redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, widthRed, widthRed)];
    
    self.redView.center = location;
    
    [self.view addSubview:self.redView];
    // 随机色方块
    
    self.redView.backgroundColor = randomColor;
    
    
    // 创建重力的物理仿真行为，并设置具体的items(需要仿真的view)
    [self.gravity addItem:self.redView];
    
    // 下落方向
    //    [gravity setAngle:0.5];
    
    [self.collision addItem:self.redView];
    self.collision.translatesReferenceBoundsIntoBoundary = YES;

    // 将重力仿真行为添加给仿真者实现仿真效果，开始仿真
    [self.animator addBehavior:self.gravity];
    [self.animator addBehavior:self.collision];
    
}
-(UIGravityBehavior *)gravity{
    if (_gravity == nil) {
        _gravity = [[UIGravityBehavior alloc]init];
    }
    return _gravity;
}
-(UICollisionBehavior *)collision{
    if (_collision == nil) {
        _collision = [[UICollisionBehavior alloc]init];
    }
    return _collision;
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
