//
//  BaseAnimationVC.m
//  AnimationTest
//
//  Created by ftimage2 on 2018/9/18.
//  Copyright © 2018年 Jack Wang. All rights reserved.
//

#import "BaseAnimationVC.h"

@interface BaseAnimationVC ()
@property(nonatomic, strong)UIView *animationView;
@end

@implementation BaseAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSArray *btnArrTitle = @[@"平移动画",@"缩放动画",@"旋转动画",@"颜色动画"];
    NSInteger lineNum = 2;
    CGFloat BtnWith = 150;
    CGFloat btnHeight = 30;
    
    CGFloat oneWith = BtnWith + 30;
    CGFloat oneHeigth = btnHeight + 30;
    
    for (int i = 0; i< btnArrTitle.count; i++) {
        NSInteger currentLineNum = i / lineNum;
        NSInteger currentEveryNum = i % lineNum;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20 + oneWith * currentEveryNum, 100 + currentLineNum * oneHeigth, BtnWith, btnHeight)];
        [btn setTitle:btnArrTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(animationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 10;
        btn.backgroundColor = [UIColor greenColor];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = true;
        [self.view addSubview:btn];
    }
    
    _animationView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
    _animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_animationView];
    
    
}

-(void)animationBtnAction:(UIButton *)send{
    NSInteger num = send.tag - 10;
    CABasicAnimation *animationBasic = [[CABasicAnimation alloc] init];
    
    switch (num) {
          //动画平移
        case 0:
            animationBasic.keyPath = @"position";
            animationBasic.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y+100)];
            break;
            // 缩放
        case 1:
            animationBasic.keyPath = @"transform.scale";
            animationBasic.fromValue = @1;
            animationBasic.toValue = @0.1;
            break;
            
//            旋转动画
        case 2:
            animationBasic.keyPath = @"transform.rotation";
            animationBasic.toValue = @(M_PI);
            break;
            
//            颜色
        case 3:
            animationBasic.keyPath = @"opacity";
            animationBasic.fromValue = @1;
            animationBasic.toValue = @0.1;
            break;
            
        default:
            break;
    }
    animationBasic.duration = 1;
    
    animationBasic.removedOnCompletion = false;
    
    animationBasic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //反转
//    [animationBasic setAutoreverses:true];
    
    [self.animationView.layer addAnimation:animationBasic forKey:@"basic"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
