//
//  SpringAnimationVC.m
//  AnimationTest
//
//  Created by ftimage2 on 2018/9/18.
//  Copyright © 2018年 Jack Wang. All rights reserved.
//

#import "SpringAnimationVC.h"

@interface SpringAnimationVC ()
@property(nonatomic, strong)UIView *opView;
@end

@implementation SpringAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
    [btn setTitle:@"Animation_Spring" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(animationBegin:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btn];
    
    
    _opView = [[UIView alloc] init];
    _opView.frame = CGRectMake(100, 500, 50, 50);
    _opView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_opView];
    
}


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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
