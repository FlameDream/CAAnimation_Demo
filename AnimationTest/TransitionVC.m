//
//  TransitionVC.m
//  AnimationTest
//
//  Created by ftimage2 on 2018/9/18.
//  Copyright © 2018年 Jack Wang. All rights reserved.
//

#import "TransitionVC.h"

#define ScreenWidth     self.view.frame.size.width
#define ScreenHeight    self.view.frame.size.height

@interface TransitionVC ()
@property(nonatomic, strong)UIView *transitionView;
@end

@implementation TransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
    [btn setTitle:@"Cube_left" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTransitionAnimation) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btn];
    
    _transitionView = [[UIView alloc] init];
    _transitionView.frame = CGRectMake((ScreenWidth - 200) / 2, 200, 200,300);
    _transitionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_transitionView];
    
}

/**
 CATransition:继承 CAAnimation
 //转场类型,字符串类型参数.系统提供了四中动画形式:
 //kCATransitionFade//逐渐消失
 //kCATransitionMoveIn//移进来
 //kCATransitionPush//推进来
 //kCATransitionReveal//揭开
 //另外,除了系统给的这几种动画效果,我们还可以使用系统私有的动画效果:
 //@"cube",//立方体翻转效果
 //@"oglFlip",//翻转效果
 //@"suckEffect",//收缩效果,动画方向不可控
 //@"rippleEffect",//水滴波纹效果,动画方向不可控
 //@"pageCurl",//向上翻页效果
 //@"pageUnCurl",//向下翻页效果
 //@"cameralIrisHollowOpen",//摄像头打开效果,动画方向不可控
 //@"cameraIrisHollowClose",//摄像头关闭效果,动画方向不可控
 @property(copy) NSString *type;
 //转场方向,系统一共提供四个方向:
 //kCATransitionFromRight//从右开始
 //kCATransitionFromLeft//从左开始
 //kCATransitionFromTop//从上开始
 //kCATransitionFromBottom//从下开始
 @property(nullable, copy) NSString *subtype;
 
 //开始进度,默认0.0.如果设置0.3,那么动画将从动画的0.3的部分开始
 @property float startProgress;
 //结束进度,默认1.0.如果设置0.6,那么动画将从动画的0.6部分以后就会结束
 @property float endProgress;
 
 
 CATransition也是继承CAAnimation,系统默认提供了12种动画样式,加上4个动画方向,除了方向不可控的四种效果外,大概一共提供了36种动画.
 
 */

-(void)btnTransitionAnimation{
    CATransition *transitionAnimation = [[CATransition alloc] init];
    transitionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transitionAnimation.duration = 1;
    transitionAnimation.removedOnCompletion = true;
    
    transitionAnimation.type = @"cube";
    transitionAnimation.subtype = kCATransitionFromLeft;
    
    [_transitionView.layer addAnimation:transitionAnimation forKey:@"transition"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
