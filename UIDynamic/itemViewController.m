//
//  itemViewController.m
//  UIDynamic
//
//  Created by tongle on 2017/9/5.
//  Copyright © 2017年 tong. All rights reserved.
//

#import "itemViewController.h"

@interface itemViewController (){
    CGPoint p;
}
@property (nonatomic,strong)UIDynamicAnimator * animator;
@property (nonatomic,strong)UIGravityBehavior * gravity;
@property (nonatomic,strong)UICollisionBehavior * collision;
@property (nonatomic,strong)UIDynamicItemBehavior *itemBehavior;


@end

@implementation itemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

/**
 生成小球，添加仿真事件
 */
-(void)touchesAddSquareView{
    float  viewWidth = 20;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(p.x, p.y, viewWidth, viewWidth)];
    view.layer.cornerRadius = viewWidth / 2.0;
    view.backgroundColor = randomColor;
    [self performSelector:@selector(removeView:) withObject:view afterDelay:10];
    [self.view addSubview:view];
    [self.collision addItem:view];
    [self.itemBehavior addItem:view];
    [self.gravity addItem:view];
    [self.animator addBehavior:self.collision];
    [self.animator addBehavior:self.itemBehavior];
    [self.animator addBehavior:self.gravity];
    
}

/**
 removeView

 @param view 移除十秒前的view并去除view的animatic
 */
-(void)removeView:(UIView *)view{
    if (view == nil) {
        return;
    }
    [UIView animateWithDuration:.5 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        [self.collision removeItem:view];
        [self.itemBehavior removeItem:view];
        [self.gravity removeItem:view];
    }];
    
}
-(UIDynamicAnimator *)animator{
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
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
         [_collision addBoundaryWithIdentifier:@"barrier" forPath:[UIBezierPath bezierPathWithRect:self.view.bounds]];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collision;
}
-(UIDynamicItemBehavior *)itemBehavior{
    if (_itemBehavior == nil) {
        _itemBehavior = [[UIDynamicItemBehavior alloc] init];
        _itemBehavior.elasticity = 1;
    }
    return _itemBehavior;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    p = location;
    [self touchesAddSquareView];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    p = location;
   [self touchesAddSquareView];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesAddSquareView];
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
