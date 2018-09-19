//
//  AnimationGroupVC.m
//  AnimationTest
//
//  Created by ftimage2 on 2018/9/18.
//  Copyright © 2018年 Jack Wang. All rights reserved.
//

#import "AnimationGroupVC.h"

@interface AnimationGroupVC ()

@property(nonatomic, strong)CALayer *animationGroupLayer;
@end

@implementation AnimationGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
    [btn setTitle:@"Animation_Group" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAcitonAnimation) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btn];
    
    
    _animationGroupLayer = [[CALayer alloc] init];
    _animationGroupLayer.frame = CGRectMake(100, 300, 50, 50);
    _animationGroupLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_animationGroupLayer];
    
}

-(void)btnAcitonAnimation{
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    CAKeyframeAnimation *keyAnimation = [self addKeyFrame];
    CABasicAnimation *scaleAnimation =[self addBasicFrame];
    CABasicAnimation *rotationAnimation = [self addBasicOtherFrame];
    
    animationGroup.duration = 4;
    animationGroup.animations = @[scaleAnimation,keyAnimation,rotationAnimation];
    [_animationGroupLayer addAnimation:animationGroup forKey:@"group"];
    
}


-(CAKeyframeAnimation *)addKeyFrame{
    CAKeyframeAnimation *keyAnimation = [[CAKeyframeAnimation alloc] init];
    keyAnimation.keyPath = @"position";
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(125, 325, 200, 300)];
    keyAnimation.path = bezierPath.CGPath;
    
    keyAnimation.removedOnCompletion = false;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyAnimation.autoreverses = false;
    keyAnimation.duration = 4;
    
    return keyAnimation;
}

-(CABasicAnimation *)addBasicFrame{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.fromValue = @1;
    basicAnimation.toValue = @0.1;
    basicAnimation.removedOnCompletion = false;
    basicAnimation.duration = 4;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basicAnimation.autoreverses = true;
    
    return basicAnimation;
}


-(CABasicAnimation *)addBasicOtherFrame{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(2*M_PI);
    basicAnimation.removedOnCompletion = false;
    basicAnimation.duration = 4;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basicAnimation.autoreverses = true;
    
    return basicAnimation;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
