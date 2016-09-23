//
//  Do_PaintBord.h
//  DO_Painter_1.0
//
//  Created by aDou on 16/7/9.
//  Copyright © 2016年 dou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Do_PaintBord : UIView
@property (nonatomic,strong)UIColor *lineColor;
@property (nonatomic,strong)NSMutableArray *AllLineArray;//保存所有线条
@property (nonatomic,assign)CGFloat lineWidth;
-(void)initBord;
-(void)backImage;
-(void)forwardImage;
@end
