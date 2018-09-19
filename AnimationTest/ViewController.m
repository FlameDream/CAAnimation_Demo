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
     
    1.Core Animation介绍
    
     CAAnimation：Core Animation中动画的抽象超类（The abstract superclass for animations in Core Animation.）
     
     CAAnmiation支持CAMediaTiming和CAAction的基本协议，不能直接创建CAAnimation的实例，Core Animation layers or SceneKit objects对象实现动画效果创建相关的子类：CABasicAnimation、CAKeyframeAnimation、CATransition、CASpringAnimation、CAAnimationGroup
     
     CAPropertyAnimation：CAAnimation的抽象子类，用于创建操纵图层属性值的动画。CABasicAnimation和CAKeyframeAnimation其子类
     CAPropertyAnimation和CAAnimtion一样都是无法创建实例类型
     
     
     可以使用创建实例对象的动画类：
     
        1.基础动画：   CABasicAnimation
        2.关键帧动画：  CAKeyframeAnimation
        3.转场动画:    CATransition
        4.弹性动画：   CASpringAnimation
        5.动画组合：   CAAnimationGroup
     
     
     CAAnimation 之间的继承关系
     CAAnimation｛
         CAPropertyAnimation {
             CABasicAnimation {
                CASpringAnimation
             }
             CAKeyframeAnimation
         }
         CATransition
         CAAnimationGroup
     }
     
     
     2.CAAnimation详细介绍
        2.1.CAAnimation类
        CAAnimation：Core Animation中动画的抽象超类（引子：苹果文档）
     
     CAAnimation的父类是NSObject，遵守NSSecureCoding, NSCopying, CAMediaTiming, CAAction协议，拥有
     
     方法l：
     
        + (instancetype)animation;          // 创建实例对象
     // 设置动画key值(在CALayer添加动画时，添加动画并设置key:CALayer方法中设置- (void)addAnimation:(CAAnimation *)anim forKey:(nullable NSString *)key;)
        + (nullable id)defaultValueForKey:(NSString *)key;   //
        - (BOOL)shouldArchiveValueForKey:(NSString *)key;
     
     
     属性类别：
    
     // 设置 动画一段时的快慢
    //设置了其动画的时间函数为CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)。时间函数通过修改持续时间的分数来控制动画的速度。(猜想：通过这个方法设置CAMediaTiming协议下的speed)
     
     kCAMediaTimingFunctionLinear  //线型移动
     kCAMediaTimingFunctionEaseIn  //淡入
     kCAMediaTimingFunctionEaseOut   //淡出
     kCAMediaTimingFunctionEaseInEaseOut   //淡入淡出
     kCAMediaTimingFunctionDefault       // 默认
     同时可以通过自定义CAMediaTimingFunction时间功能定义动画的时间
     
        @property(nullable, strong) CAMediaTimingFunction *timingFunction;
     
     // 动画的执行的两个阶段的代理
        @property(nullable, strong) id <CAAnimationDelegate> delegate;
     
     // 是否 移除动画执行完渲染树，
        默认情况下是YES，动画执行完CALayer恢复最初状态
        为：NO，保留原始CALayer渲染树。
        注意：在使用fillMode动画时，不能使用YES（执行完成后，动画内容消失）

        @property(getter=isRemovedOnCompletion) BOOL removedOnCompletion;
     
     
     2.2 CAAnimation的协议详解
        NSSecureCoding, NSCopying对应的内容无需要多解释
        CAAction:
     协议方法：
     
        - (void)runActionForKey:(NSString *)event object:(id)anObject
     arguments:(nullable NSDictionary *)dict;（被调用以在接收器上触发名为“path”的事件。 事件发生的对象（例如图层）是“anObject”。 参数字典可以是nil，如果是非nil，它携带与事件相关的参数）
     
        CAMediaTiming：CAMediaTiming协议实现 layers动画，CAMediaTiming
     CAMediaTiming协议通过设置开始时间、动画执行时间、次数以及speed、timeoffset的方式控制动画
    
    //设置当前动画开始的时间，如果没有设置默认为0，动画当前生成的时间
     @property CFTimeInterval beginTime;
     // 设置 动画执行的时长 默认：0
    @property CFTimeInterval duration;
    
     // 可以通过这两个参数设置更复杂的动画效果，可以实现动画的暂停、快进等效果
     //动画执行时间： t = (tp - begin) * speed + offset
     // 动画执行时间为：t     系统时间：tp   动画开始时间：begin
     // 默认情况下，speed：1     offset：0
     // speed：单位时间执行的rate  例子：如果rate是2  本地时间是当前时间快两倍
    @property float speed;
    @property CFTimeInterval timeOffset;
    
    
    //执行的重复次数
    @property float repeatCount;
    
     //每次执行的时长   默认时间为0
    @property CFTimeInterval repeatDuration;
     
    // 是否 动画逆转执行；自定义为NO
    @property BOOL autoreverses;
    
    
    //默认是kCAFillModeRemoved，当动画不再播放的时候就显示图层模型指定的值剩下的三种类型向前，向后或者即向前又向后去填充动画状态，使得动画在开始前或者结束后仍然保持开始和结束那一刻的值。其中一下四种类型：
     kCAFillModeForwards
     kCAFillModeBackwards
     kCAFillModeBoth
     kCAFillModeRemoved
     
    @property(copy) CAMediaTimingFillMode fillMode;

     
     总结：单位时间内一个物体改变量（距离、颜色、形状等）形成动画。而CAAnimation类是对动画时间相关的内容的处理，相关的量值并没有定义，CAAnimation并不能构成一个动画的完整条件，只能让其子类来实现完整的动画。
    */
    

    
    NSArray *btnArrTitle = @[@"BasicAnimation",@"KeyframeAnimation",@"Transition",@"SpringAnimation",@"AnimationGroup"];
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
        btn.backgroundColor = [UIColor grayColor];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = true;
        [self.view addSubview:btn];
    }

}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
