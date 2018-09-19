//
//  JW_BezierPathView.m
//  AnimationTest
//
//  Created by ftimage2 on 2018/9/17.
//  Copyright © 2018年 Jack Wang. All rights reserved.
//

#import "JW_BezierPathView.h"

@implementation JW_BezierPathView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self circlePath];
}

//  BezierPath
-(void)circlePath{
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:true];
    bezierPath.lineWidth = 1;
    
//    UIColor *lineFill = [UIColor redColor];
//    [lineFill setFill];
//    [bezierPath fill];
    
    
    UIColor *lineStoke = [UIColor blueColor];
    [lineStoke setStroke];
    [bezierPath stroke];
    
}


@end
