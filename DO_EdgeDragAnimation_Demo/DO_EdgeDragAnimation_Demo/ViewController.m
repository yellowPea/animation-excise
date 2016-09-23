//
//  ViewController.m
//  DO_EdgeDragAnimation_Demo
//
//  Created by aDou on 16/7/30.
//  Copyright © 2016年 aDou. All rights reserved.
//

#import "ViewController.h"
#import "DO_EdgeDragView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //EdgeType根据需求可以给不同边加拖拽效果
    DO_EdgeDragView *ev = [[DO_EdgeDragView alloc]initWithFrame:self.view.bounds EdgeType:right];
    ev.color = [UIColor lightGrayColor];
    [self.view addSubview:ev];
    
}







@end
