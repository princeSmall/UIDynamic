//
//  ViewController.m
//  UIDynamic
//
//  Created by iOS on 2017/9/1.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "ViewController.h"
#import "gravityViewController.h"
#import "SnapViewController.h"
#import "gravityCollisionViewController.h"
#import "itemViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * TTableView;
@property (nonatomic,strong)NSArray * titleArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIDynamic";
    self.TTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.TTableView.delegate= self;
    self.TTableView.dataSource = self;
    [self.view addSubview:self.TTableView];
    self.TTableView.tableFooterView = [UIView new];
    self.titleArray = [[NSArray alloc]initWithObjects:@"重力",@"吸附",@"重力+碰撞",@"重力+弹跳", nil];
    // Do any additional setup after loading the view, typically from a nib.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = @"cell";
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        gravityViewController * one = [[gravityViewController alloc]init];
        [self.navigationController pushViewController:one animated:YES];
    }else if (indexPath.row == 1){
        SnapViewController * two = [[SnapViewController alloc]init];
        [self.navigationController pushViewController:two animated:YES];
    }else if (indexPath.row == 2){
        gravityCollisionViewController * three = [[gravityCollisionViewController alloc]init];
        [self.navigationController pushViewController:three animated:YES];
    }else if (indexPath.row == 3){
        itemViewController * four = [[itemViewController alloc]init];
        [self.navigationController pushViewController:four animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
