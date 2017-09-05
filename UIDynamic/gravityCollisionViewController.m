//
//  gravityCollisionViewController.m
//  UIDynamic
//
//  Created by tongle on 2017/9/4.
//  Copyright © 2017年 tong. All rights reserved.
//

#import "gravityCollisionViewController.h"

@interface gravityCollisionViewController ()<UICollisionBehaviorDelegate>
@property (nonatomic,strong)UIDynamicAnimator * animator;
@property (nonatomic,strong)UIGravityBehavior * gravity;
@property (nonatomic,strong)UICollisionBehavior * collision;

@property (nonatomic,strong)UIView * redView;
@property (nonatomic,strong)UIView * greenView;
@property (nonatomic,strong)UIView * blueView;
@property (nonatomic,strong)UIView * blackView;



@end

@implementation gravityCollisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    self.greenView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 30)];
    self.greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.greenView];
    
    self.blueView = [[UIView alloc] initWithFrame:CGRectMake(120, 300, 100, 30)];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    
    self.blackView = [[UIView alloc] initWithFrame:CGRectMake(140, 400, 100, 30)];
    self.blackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.blackView];
    
    self.blueView.transform =  CGAffineTransformMakeRotation(M_PI_4);
    self.greenView.transform = CGAffineTransformMakeRotation(-M_PI / 8);
    
     // Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    self.redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, widthRed, widthRed)];
    self.redView.center = location;
    self.redView.backgroundColor = randomColor;
    [self.view addSubview:self.redView];
    [self.gravity addItem:self.redView];
    // 添加碰撞检测
    [self.collision addItem:self.redView];
    [self.collision addItem:self.greenView];
    [self.collision  addItem:self.blueView];
    self.collision.translatesReferenceBoundsIntoBoundary = YES;
    self.collision.collisionDelegate = self;
    
    
   __weak typeof(self) weakSelf = self;
        // 获取方块运动轨迹坐标
    self.collision.action = ^{
        NSLog(@"%@", NSStringFromCGRect(weakSelf.redView.frame));
        
    };

    CGFloat Y = self.view.frame.size.height;
    CGFloat X = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    //设置红色的View为底边界,左边框跟右边框作为边界
    [self.collision addBoundaryWithIdentifier:@"collision1" fromPoint:CGPointMake(0,Y) toPoint:CGPointMake(X, Y)];
    [self.collision addBoundaryWithIdentifier:@"collision2" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, height)];
    [self.collision addBoundaryWithIdentifier:@"collision3" fromPoint:CGPointMake(X,0) toPoint:CGPointMake(X, height)];
    [self.animator addBehavior:self.collision];
    [self.animator addBehavior:self.gravity];
   
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

- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p{
    
    if ([item isEqual:self.greenView]) {
        UIGravityBehavior * gravity = [[UIGravityBehavior alloc] initWithItems:@[self.greenView]];
        [self.animator addBehavior:gravity];
    }else if ([item isEqual:self.blueView]){
        UIGravityBehavior * gravity = [[UIGravityBehavior alloc] initWithItems:@[self.blueView]];
        [self.animator addBehavior:gravity];
    }
    
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
