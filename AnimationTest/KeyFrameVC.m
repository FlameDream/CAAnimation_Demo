//
//  KeyFrameVC.m
//  AnimationTest
//
//  Created by ftimage2 on 2018/9/18.
//  Copyright © 2018年 Jack Wang. All rights reserved.
//

#import "KeyFrameVC.h"

@interface KeyFrameVC ()
@property(nonatomic, strong)CALayer *animationLayer;
@end

@implementation KeyFrameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *btnArrTitle = @[@"平移动画",@"缩放动画",@"旋转动画",@"颜色动画",@"BezierPath"];
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
    
    _animationLayer = [[CALayer alloc] init];
    _animationLayer.frame = CGRectMake(100, 300, 50, 50);
    _animationLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_animationLayer];
}


-(void)animationBtnAction:(UIButton *)send{
    NSInteger num = send.tag - 10;
    CAKeyframeAnimation *keyAnimation = [[CAKeyframeAnimation alloc] init];
     UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(125, 325, 200, 300)];
    
    
//      使用PathRef
//    CGMutablePathRef path = CGPathCreateMutable();//创建可变路径
//    CGPathAddEllipseInRect(path, NULL, CGRectMake(0, 0, 320, 500));
//    CGPathRelease(path);

    switch (num) {
            //动画平移
        case 0:
            keyAnimation.keyPath = @"position";
            keyAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(self.animationLayer.frame.origin.x, self.animationLayer.frame.origin.y)],[NSValue valueWithCGPoint:CGPointMake(self.animationLayer.frame.origin.x, self.animationLayer.frame.origin.y+100)],[NSValue valueWithCGPoint:CGPointMake(self.animationLayer.frame.origin.x+100, self.animationLayer.frame.origin.y+100)],[NSValue valueWithCGPoint:CGPointMake(self.animationLayer.frame.origin.x + 100, self.animationLayer.frame.origin.y)],[NSValue valueWithCGPoint:CGPointMake(self.animationLayer.frame.origin.x, self.animationLayer.frame.origin.y)]];
            break;
            // 缩放
        case 1:
            keyAnimation.keyPath = @"transform.scale";
            keyAnimation.values = @[@1,@0.2,@0.9,@0.1];
            break;
            
            //            旋转动画
        case 2:
            keyAnimation.keyPath = @"transform.rotation";
            keyAnimation.values = @[@(M_2_PI),@(-M_PI),@(M_PI * 2),@(0)];
            break;
            
            //            颜色
        case 3:
            keyAnimation.keyPath = @"opacity";
            keyAnimation.values = @[@1,@0.2,@0.9,@0.1];
            break;
            
        case 4:
            keyAnimation.keyPath = @"position";
            keyAnimation.path = bezierPath.CGPath;
            break;
        default:
            break;
    }
    keyAnimation.duration = 5;
    
    keyAnimation.removedOnCompletion = false;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //反转
    //    [animationBasic setAutoreverses:true];
    
    [self.animationLayer addAnimation:keyAnimation forKey:@"basic"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
