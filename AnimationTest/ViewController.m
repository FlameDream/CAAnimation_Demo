//
//  ViewController.m
//  AnimationTest
//
//  Created by ftimage2 on 2018/9/17.
//  Copyright © 2018年 Jack Wang. All rights reserved.
//

#import "ViewController.h"
#import "JW_BezierPathView.h"

#import <objc/runtime.h>

#import "BaseAnimationVC.h"
#import "KeyFrameVC.h"
#import "TransitionVC.h"
#import "AnimationGroupVC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    
    /**
     
    
     CAAnmiation：Core Animation中动画的抽象超类（The abstract superclass for animations in Core Animation.）
     
     CAAnmiation支持CAMediaTiming和CAAction的基本协议，不能直接创建CAAnimation的实例，Core Animation layers or SceneKit objects对象实现动画效果创建相关的子类：CABasicAnimation、CAKeyframeAnimation、CATransition、CASpringAnimation、CAAnimationGroup
     
     CAPropertyAnimation：CAAnimation的抽象子类，用于创建操纵图层属性值的动画。CABasicAnimation和CAKeyframeAnimation其子类
     CAPropertyAnimation和CAAnimtion一样都是无法创建实例类型
     
     
     可以使用创建实例对象的动画类：
     
        1.基础动画：   CABasicAnimation
        2.关键帧动画：  CAKeyframeAnimation
        3.转场动画:    CATransition
        4.弹性动画：   CASpringAnimation
        5.动画组合：   CAAnimationGroup
     
     */
    
    NSArray *btnArrTitle = @[@"BasicAnimation",@"KeyframeAnimation",@"Transition",@"SpringAnimation",@"AnimationGroup"];
    NSInteger lineNum = 2;
    CGFloat BtnWith = 150;
    CGFloat btnHeight = 30;
    
    CGFloat oneWith = BtnWith + 30;
    CGFloat oneHeigth = btnHeight + 30;
   
    for (int i = 0; i< 5; i++) {
        NSInteger currentLineNum = i / lineNum;
        NSInteger currentEveryNum = i % lineNum;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20 + oneWith * currentEveryNum, 100 + currentLineNum * oneHeigth, BtnWith, btnHeight)];
        [btn setTitle:btnArrTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(animationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 10;
        btn.backgroundColor = [UIColor grayColor];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = true;
        [self.view addSubview:btn];
    }
    
    [self rotate];
    
//    // BezierPath
//    JW_BezierPathView *jwView = [[JW_BezierPathView alloc] initWithFrame:self.view.frame];
//    jwView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:jwView];
    
}

//
-(void)animationBtnAction:(UIButton *)send{
    NSInteger num = send.tag - 10;
    
    NSArray *animationVCArr = @[@"BaseAnimationVC",@"KeyFrameVC",@"TransitionVC",@"SpringAnimationVC",@"AnimationGroupVC"];
    
    Class class = NSClassFromString(animationVCArr[num]);
    UIViewController *viewVC =  class.new;
//    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:viewVC];
    viewVC.title = animationVCArr[num];
    viewVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewVC animated:true];
}


- (void)rotate
{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(200, 200, 200, 100)];
    
    CAShapeLayer *lary = [[CAShapeLayer alloc] init];
    lary.path = path.CGPath;
    lary.fillColor = [UIColor clearColor].CGColor;
    lary.strokeColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:lary];
    
    
    
    CABasicAnimation *animation = [ CABasicAnimation
                                   
                                   animationWithKeyPath: @"transform" ];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    
    
    //围绕Z轴旋转，垂直与屏幕
    
    animation.toValue = [ NSValue valueWithCATransform3D:
                         
                         
                         
                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    
    animation.duration = 0.5;
    
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1000;
//    //在图片边缘添加一个像素的透明区域，去图片锯齿
//
//    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
//
//    UIGraphicsBeginImageContext(imageRrect.size);
//
//    [imageView.image drawInRect:CGRectMake(1,1,imageView.frame.size.width-2,imageView.frame.size.height-2)];
//
//    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//
//    UIGraphicsEndImageContext();
    
    
    
    [lary addAnimation:animation forKey:nil];
    
//    // 对Y轴进行旋转
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    // 1秒后执行
//    animation.beginTime = CACurrentMediaTime() + 1;
//    // 持续时间
//    animation.duration = 2.5;
//    // 重复次数
//    animation.repeatCount = 100000;
//    // 起始角度
//    animation.fromValue = @(0.0);
//    // 终止角度
//    animation.toValue = @(2 * M_PI);
//    // 添加动画
//    [lary addAnimation:animation forKey:@"rotate"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
