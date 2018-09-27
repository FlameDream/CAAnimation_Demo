##前言
Core Animation核心动画主要是采用CAAnimation抽象超级类的子类实现动画，它是一组非常强大的动画处理API.使用它能做出非常绚丽的动画效果.Core Animation可以用在Mac OS X和iOS平台. Core Animation的动画执行过程是在后台操作的.不会阻塞主线程.要注意的是, Core Animation是直接作用在CALayer上的.并非UIView.（[Core Animation的Demo](https://github.com/FutureOne011/CAAnimation_Demo)）


##一、CAAnimation详细介绍
 Core Animation核心动画主要是采用CAAnimation抽象超级类的子类实现动画

###1.CAAnimation是什么？
CAAnimation：The abstract superclass for animations in Core Animation.[苹果文档](https://developer.apple.com/documentation/quartzcore/caanimation?language=objc)。它的父类是NSObject，遵守NSSecureCoding, NSCopying, CAMediaTiming, CAAction协议的Core Animation动画抽象超类。
###2.CAAnimation拥有哪些方法和属性
```
方法：
 
 + (instancetype)animation;          // 创建实例对象
 // 设置动画key值(在CALayer添加动画时，添加动画并设置key:CALayer方法中设置- (void)addAnimation:(CAAnimation *)anim forKey:(nullable NSString *)key;)
 + (nullable id)defaultValueForKey:(NSString *)key;   //
 - (BOOL)shouldArchiveValueForKey:(NSString *)key;

属性类别：
 
 // 设置 动画一段时的快慢
 //设置了其动画的时间函数为CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)。时间函数通过修改持续时间的分数来控制动画的速度。(猜想：通过这个方法设置CAMediaTiming协议下的speed)
 
// kCAMediaTimingFunctionLinear  //线型移动
// kCAMediaTimingFunctionEaseIn  //淡入
// kCAMediaTimingFunctionEaseOut   //淡出
// kCAMediaTimingFunctionEaseInEaseOut   //淡入淡出
// kCAMediaTimingFunctionDefault       // 默认
// 同时可以通过自定义CAMediaTimingFunction时间功能定义动画的时间
 
 @property(nullable, strong) CAMediaTimingFunction *timingFunction;
 
 // 动画的执行的两个阶段的代理
 @property(nullable, strong) id <CAAnimationDelegate> delegate;
 
 // 是否 移除动画执行完渲染树，
 //默认情况下是YES，动画执行完CALayer恢复最初状态为：NO，保留原始CALayer渲染树。
 //注意：在使用fillMode动画时，不能使用YES（执行完成后，动画内容消失）
 
 @property(getter=isRemovedOnCompletion) BOOL removedOnCompletion;
```
###3.CAAnimation遵守的协议
NSSecureCoding, NSCopying对应的内容无需要多解释，在iOS经常会看到两个协议。

- CAAction: 协议方法：
 ```

//被调用以在接收器上触发名为“path”的事件。
// 事件发生的对象（例如图层）是“anObject”。 参数字典可以是nil，如果是非nil，它携带与事件相关的参数
 - (void)runActionForKey:(NSString *)event object:(id)anObject
 arguments:(nullable NSDictionary *)dict;

 ```

- CAMediaTiming：CAMediaTiming协议实现 layers动画，CAMediaTiming
 CAMediaTiming协议通过设置开始时间、动画执行时间、次数以及speed、timeoffset的方式控制动画
```
 
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
 //kCAFillModeForwards
 //kCAFillModeBackwards
// kCAFillModeBoth
// kCAFillModeRemoved
 
 @property(copy) CAMediaTimingFillMode fillMode;

```
### 4.CAAnimation动画的继承关系
在Core Animation中可以使用创建实例对象的动画类：
 
 1.基础动画：   CABasicAnimation
 2.关键帧动画：  CAKeyframeAnimation
 3.转场动画:    CATransition
 4.弹性动画：   CASpringAnimation
 5.动画组合：   CAAnimationGroup
这几个动画类的层级关系如下图：
```
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
```

**总结：单位时间内一个物体改变量（距离、颜色、形状等）形成动画。而CAAnimation类是对动画时间相关的内容的处理，相关的量值并没有定义，CAAnimation并不能构成一个动画的完整条件，只能让其子类来实现完整的动画。**

###二、Core Animtion其他类介绍
####1.CAPropertyAnimation
CAPropertyAnimation：继承CAAnimation，其子类：CABasicAnimation和CAKeyframeAnimatio
创建CAPropertyAnimation需要设置『动画对象』的关键keyPath（每个对象的属性都是一个keypath值）
```
 //CAAnimation的抽象子类，用于创建操纵图层属性值的动画。CABasicAnimation和CAKeyframeAnimation其子类
 + (instancetype)animationWithKeyPath:(nullable NSString *)path;
 
 //用于设置动画对象key-path值
 @property(nullable, copy) NSString *keyPath;
 
 //这两个值是只读属性的值，不需要关心
 @property(getter=isAdditive) BOOL additive;
 @property(getter=isCumulative) BOOL cumulative;
 
 //如果非nil是在将插值设置为动画的目标属性的新显示值之前应用于插值的函数。 默认为零。
 @property(nullable, strong) CAValueFunction *valueFunction;
```

####2.CABasicAnimation
CABasicAnimation : 继承CAPropertyAnimation
```
//
//这三个属性之间的规则
//
//fromValue和toValue不为空,动画的效果会从fromValue的值变化到toValue.
//fromValue和byValue都不为空,动画的效果将会从fromValue变化到fromValue+byValue
//toValue和byValue都不为空,动画的效果将会从toValue-byValue变化到toValue
//只有fromValue的值不为空,动画的效果将会从fromValue的值变化到当前的状态.
//只有toValue的值不为空,动画的效果将会从当前状态的值变化到toValue的值.
//只有byValue的值不为空,动画的效果将会从当前的值变化到(当前状态的值+byValue)的值.
//

@property(nullable, strong) id fromValue;
@property(nullable, strong) id toValue;
@property(nullable, strong) id byValue;
 ```
 例子：
```
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

```

####4.CAKeyframeAnimation
 CAKeyframeAnimation:继承CAPropertyAnimation
```
// values  为动画提供一个关键帧的关键值得关键点
@property(nullable, copy) NSArray *values;
// 提供一个动画执行的路径，默认为nil，如果不为空，设置为kCAAnimationPaced
@property(nullable) CGPathRef path;

// 关键帧之间动画的时间节点，rang为[0,1]
@property(nullable, copy) NSArray<NSNumber *> *keyTimes;

// 设置关键帧之间的动画快慢效果
@property(nullable, copy) NSArray<CAMediaTimingFunction *> *timingFunctions;

// The "calculation mode". Possible values are `discrete', `linear',
//`paced', `cubic' and `cubicPaced'. Defaults to `linear'. When set to
//  `paced' or `cubicPaced' the `keyTimes' and `timingFunctions'
//properties of the animation are ignored and calculated implicitly.

@property(copy) CAAnimationCalculationMode calculationMode;


// 对于具有三次计算模式的动画，这些属性提供对插值方案的控制。 每个关键帧可能具有与之关联的张力，连续性和偏差值，每个都在[-1,1]范围内（这定义了Kochanek-Bartels样条，请参阅http://en.wikipedia.org/wiki/Kochanek-Bartels_spline）。 
// 张力值控制曲线的“紧密度”（正值更紧，负值更圆）。 连续性值控制段的连接方式（正值给出尖角，负值给出倒角）。 偏差值定义曲线发生的位置（正值在控制点之前移动曲线，负值在控制点之后移动它）。 
//每个数组中的第一个值定义第一个控制点的切线的行为，第二个值控制第二个点的切线，依此类推。 任何未指定的值都默认为零（如果未指定所有值，则给出Catmull-Rom样条曲线）。

@property(nullable, copy) NSArray<NSNumber *> *tensionValues;
@property(nullable, copy) NSArray<NSNumber *> *continuityValues;
@property(nullable, copy) NSArray<NSNumber *> *biasValues;
 
//如果关键帧执行过程中自动相反旋转
@property(nullable, copy) CAAnimationRotationMode rotationMode;
```
***例子：***
```
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

```

####5.CASpringAnimation
CASpringAnimation：继承CABasicAnimation (iOS 9)
``` 
//理解下面的属性的时候可以结合现实物理现象,比如把它想象成一个弹簧上挂着一个金属小球
 //质量,振幅和质量成反比
 @property CGFloat mass;
 //刚度系数(劲度系数/弹性系数),刚度系数越大,形变产生的力就越大,运动越快
 @property CGFloat stiffness;
 //阻尼系数,阻止弹簧伸缩的系数,阻尼系数越大,停止越快,可以认为它是阻力系数
 @property CGFloat damping;
 //初始速率,动画视图的初始速度大小速率为正数时,速度方向与运动方向一致,速率为负数时,速度方向与运动方向相反.
 @property CGFloat initialVelocity;
 //结算时间,只读.返回弹簧动画到停止时的估算时间，根据当前的动画参数估算通常弹簧动画的时间使用结算时间比较准确
 @property(readonly) CFTimeInterval settlingDuration;
 ```
例子：
```
-(void)animationBegin:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"position.y"];
    springAnimation.mass = 1;
    springAnimation.stiffness = 100;
    springAnimation.damping = 1;
    springAnimation.initialVelocity = 0;
    springAnimation.duration = springAnimation.settlingDuration;
    springAnimation.fromValue = @(self.opView.center.y);
    springAnimation.toValue = @(self.opView.center.y + (btn.selected?+150:-150));
    springAnimation.fillMode = kCAFillModeForwards;
    [self.opView.layer addAnimation:springAnimation forKey:nil];
    
    btn.selected = !btn.selected;
}

```

####6.CATransition
 CATransition:继承 CAAnimation
```
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
 
```
例子：
```
-(void)btnTransitionAnimation{
    CATransition *transitionAnimation = [[CATransition alloc] init];
    transitionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transitionAnimation.duration = 1;
    transitionAnimation.removedOnCompletion = true;
    
    transitionAnimation.type = @"cube";
    transitionAnimation.subtype = kCATransitionFromLeft;
    
    [_transitionView.layer addAnimation:transitionAnimation forKey:@"transition"];
  }
```



####7.CAAnimationGroup
 CAAnimationGroup继承于CAAnimation
 ```
 //CAAnimationGroup动画组
 /只有一个属性,数组中接受CAAnimation元素
 @property(nullable, copy) NSArray *animations;
 
 ```
例子：
```
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
```

###总之

Core Animation动画其实就是通过设置CAAnimation中的协议和CAAnimation子类的属性实现动画效果，迅速创建一个动画需要注意的事项：
* 1.需要必须设置的属性：时间（duration）、需要改变的属性key-path（位置、角度、颜色深浅等），key-path改变的值。
* 2.其他属性的设置，根据需要设置

