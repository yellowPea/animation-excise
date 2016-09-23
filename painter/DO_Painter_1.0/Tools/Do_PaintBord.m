//
//  Do_PaintBord.m
//  DO_Painter_1.0
//
//  Created by aDou on 16/7/9.
//  Copyright © 2016年 dou. All rights reserved.
//

#import "Do_PaintBord.h"

@interface Do_PaintBord()
@property(nonatomic,strong) UIBezierPath *bezierPath;
@property(nonatomic,strong) NSMutableArray *cancelArray;
@end

@implementation Do_PaintBord

-(void)initBord
{
    self.lineColor = [UIColor redColor];
    self.lineWidth = 1.0;
    self.AllLineArray = [NSMutableArray arrayWithCapacity:50];
    self.cancelArray = [NSMutableArray arrayWithCapacity:50];
}
#pragma mark --撤销操作,重绘界面--
-(void)backImage
{
    if (self.AllLineArray.count>0) {
        NSInteger cancelIndex = self.AllLineArray.count - 1;
        [self.cancelArray addObject:self.AllLineArray[cancelIndex]];
        [self.AllLineArray removeObjectAtIndex:cancelIndex];
        [self setNeedsDisplay];
    }
}
#pragma mark --撤销撤销操作,重绘界面--
-(void)forwardImage
{
    if (self.cancelArray.count>0) {
        NSInteger backIndex = self.cancelArray.count - 1;
        [self.AllLineArray addObject:self.cancelArray[backIndex]];
        [self.cancelArray removeObjectAtIndex:backIndex];
        [self setNeedsDisplay];
    }
}
#pragma mark --开始1条线--
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.bezierPath = [UIBezierPath bezierPath];
    self.bezierPath.lineCapStyle = kCGLineCapRound;
    self.bezierPath.lineJoinStyle = kCGLineCapRound;
    UITouch *firstTouch = [touches anyObject];
    CGPoint begainPoint = [firstTouch locationInView:self];
    [self.bezierPath moveToPoint:begainPoint];
    
    NSMutableDictionary *lineInfoDic = [[NSMutableDictionary alloc]initWithCapacity:3];
    [lineInfoDic setObject:self.lineColor forKey:@"linecolor"];
    [lineInfoDic setObject:[NSNumber numberWithFloat:self.lineWidth] forKey:@"linewidth"];
    [lineInfoDic setObject:self.bezierPath forKey:@"bezierpath"];
    
    [self.AllLineArray addObject:lineInfoDic];
}
#pragma mark --记录touch的point,重绘界面--
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *painter = [touches anyObject];
    CGPoint touchPoint = [painter locationInView:self];
    [self.bezierPath addLineToPoint:touchPoint];
    [self setNeedsDisplay];
}
#pragma mark --绘制界面--
-(void)drawRect:(CGRect)rect
{
    for (int pointIndex = 0; pointIndex<self.AllLineArray.count; pointIndex++) {
        NSDictionary *lineInfo = self.AllLineArray[pointIndex];
        UIColor *lineColor = lineInfo[@"linecolor"];
        UIBezierPath *bezierPath = lineInfo[@"bezierpath"];
        
        [lineColor setStroke];
        [bezierPath setLineWidth:[lineInfo[@"linewidth"] floatValue]];
        [bezierPath stroke];
    }
}














@end
