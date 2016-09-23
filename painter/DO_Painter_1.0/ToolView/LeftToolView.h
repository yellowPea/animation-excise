//
//  LeftToolView.h
//  DO_Painter_1.0
//
//  Created by aDou on 16/7/18.
//  Copyright © 2016年 dou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftToolView : UIScrollView

@property (strong, nonatomic) IBOutlet UICollectionView *pencialChooseView;
@property (strong, nonatomic) IBOutlet UISlider *linewidthSlider;
@property (strong, nonatomic) IBOutlet UITextField *linewidthTextField;
@property (strong, nonatomic) IBOutlet UISlider *redcolorSlider;
@property (strong, nonatomic) IBOutlet UILabel *redcolorLabel;
@property (strong, nonatomic) IBOutlet UISlider *greencolorSlider;
@property (strong, nonatomic) IBOutlet UILabel *greencolorLabel;
@property (strong, nonatomic) IBOutlet UISlider *bluecolorSlider;
@property (strong, nonatomic) IBOutlet UILabel *bluecolorLabel;
@property (strong, nonatomic) IBOutlet UISlider *alphSlider;
@property (strong, nonatomic) IBOutlet UILabel *alphLabel;
@property (strong, nonatomic) IBOutlet UIView *colorPreview;
@property (nonatomic, strong) IBOutlet UIButton *rubberBtn;               //橡皮
@property (nonatomic, strong) IBOutlet UIButton *saveBtn;                 //保存
@property (nonatomic, strong) IBOutlet UIButton *paintingBtn;             //画作
@property (nonatomic, strong) IBOutlet UIButton *buildPaintingBtn;          //新建
@end
