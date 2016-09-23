//
//  ViewController.m
//  DO_Painter_1.0
//
//  Created by aDou on 16/7/9.
//  Copyright © 2016年 dou. All rights reserved.
//

#import "ViewController.h"
#import "Do_PaintBord.h"
#import "UIImage+Crop.h"
#import "LeftToolView.h"
@interface ViewController ()

@property (nonatomic,assign) CGFloat redvalue;
@property (nonatomic,assign) CGFloat greenvalue;
@property (nonatomic,assign) CGFloat bluevalue;
@property (nonatomic,assign) CGFloat alphvalue;
@property (strong, nonatomic) IBOutlet Do_PaintBord *paintBord;
@property (strong, nonatomic) IBOutlet UIButton *mauneBtn;
@property (strong, nonatomic) LeftToolView *leftview;
@property (nonatomic,strong) UIAlertController *alert;
@end

@implementation ViewController
#pragma mark --将状态栏改为黑底白条--
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始配置
    _redvalue = 0.1;
    _greenvalue = 0.1;
    _bluevalue = 0.1;
    _alphvalue = 1.0;
    _paintBord.backgroundColor = [UIColor whiteColor];
    [_paintBord initBord];
    [self setlinecolor];
    _paintBord.lineWidth = 1.0;
    
    _leftview = [[NSBundle mainBundle]loadNibNamed:@"LeftView" owner:nil options:nil].firstObject;
    _leftview.frame = CGRectMake(-150, 20, 150, self.view.frame.size.height-50);
    _leftview.alpha = 0.7;
    [self.view addSubview:_leftview];
    
    //颜色RGB
    [_leftview.redcolorSlider addTarget:self action:@selector(redAction:) forControlEvents:(UIControlEventValueChanged)];
    [_leftview.greencolorSlider addTarget:self action:@selector(greenAction:) forControlEvents:(UIControlEventValueChanged)];
    [_leftview.bluecolorSlider addTarget:self action:@selector(blueAction:) forControlEvents:
     (UIControlEventValueChanged)];
    [_leftview.alphSlider addTarget:self action:@selector(alphAction:) forControlEvents:(UIControlEventValueChanged)];
    //线宽
    [_leftview.linewidthSlider addTarget:self action:@selector(changeLineWidth:) forControlEvents:(UIControlEventValueChanged)];
    //保存
    [_leftview.saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //橡皮
    [_leftview.rubberBtn addTarget:self action:@selector(rubberAction:) forControlEvents:(UIControlEventTouchUpInside)];
}
#pragma mark --橡皮--
-(void)rubberAction:(UIButton *)btn
{
    _paintBord.lineColor = _paintBord.backgroundColor;
    [UIView animateWithDuration:0.5 animations:^{
        _leftview.frame = CGRectMake(-150, 20, 150, self.view.frame.size.height-50);
    }];
    self.mauneBtn.tag = 112;
}
#pragma mark *--颜色--*
-(void)redAction:(UISlider *)slider
{
    _redvalue = slider.value;
    [self setlinecolor];
    _leftview.redcolorLabel.text = [NSString stringWithFormat:@"%0.1f",slider.value];
}
-(void)greenAction:(UISlider *)slider
{
    _greenvalue = slider.value;
    [self setlinecolor];
    _leftview.greencolorLabel.text = [NSString stringWithFormat:@"%0.1f",slider.value];
}
-(void)blueAction:(UISlider *)slider
{
    _bluevalue = slider.value;
    [self setlinecolor];
    _leftview.bluecolorLabel.text = [NSString stringWithFormat:@"%0.1f",slider.value];
}
-(void)alphAction:(UISlider *)slider
{
     _alphvalue = slider.value;
    [self setlinecolor];
    _leftview.alphLabel.text = [NSString stringWithFormat:@"%0.1f",slider.value];
}

-(void)setlinecolor
{
    _paintBord.lineColor = [UIColor colorWithRed:_redvalue green:_greenvalue blue:_bluevalue alpha:_alphvalue];
    _leftview.colorPreview.backgroundColor = _paintBord.lineColor;
}
#pragma mark --线宽--
-(void)changeLineWidth:(UISlider *)slider
{
    _paintBord.lineWidth = slider.value;
    _leftview.linewidthTextField.text = [NSString stringWithFormat:@"%0.1f",slider.value];
}
#pragma mark --召唤菜单--
- (IBAction)callOtherButtonAction:(UIButton *)sender {
    if (sender.tag != 111&&[sender.titleLabel.text isEqualToString:@"菜单"]) {
        sender.tag = 111;
        [UIView animateWithDuration:0.5 animations:^{
            _leftview.frame = CGRectMake(0, 20, 150, self.view.frame.size.height-50);
        }];
    }else if(sender.tag == 111&&[sender.titleLabel.text isEqualToString:@"菜单"]){
        sender.tag = 112;
        [UIView animateWithDuration:0.5 animations:^{
            _leftview.frame = CGRectMake(-150, 20, 150, self.view.frame.size.height-50);
        }];
    }
}
#pragma mark --撤销/恢复/保存--
- (IBAction)forwardAction:(id)sender {
    [_paintBord forwardImage];
}
- (IBAction)backAction:(id)sender {
    [_paintBord backImage];
}
- (void)saveAction:(UIButton *)sender {
    _leftview.hidden = YES;
    //截取整个屏幕
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *uiImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //裁剪获取的图，保留绘画区域大小
    CGImageRef sourceImgRef = [uiImg CGImage];
    CGImageRef newImgRef = CGImageCreateWithImageInRect(sourceImgRef, _paintBord.frame);
    UIImage *newImg = [UIImage imageWithCGImage:newImgRef];
    
    CGPoint point5 = CGPointMake(0, 0);
    CGPoint point6 = CGPointMake(_paintBord.frame.size.width, 0);
    CGPoint point7 = CGPointMake(_paintBord.frame.size.width, _paintBord.frame.size.height);
    CGPoint point8 = CGPointMake(0, _paintBord.frame.size.height);
    
    NSArray *pointArr = @[[NSValue valueWithCGPoint:point5],[NSValue valueWithCGPoint:point6],[NSValue valueWithCGPoint:point7],[NSValue valueWithCGPoint:point8]];
    newImg = [newImg cropImageWithPath:pointArr];
    //保存到本地(开辟子线程，解决主线程阻塞)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImageWriteToSavedPhotosAlbum(newImg, nil, nil, nil);
        _alert = [UIAlertController alertControllerWithTitle:nil message:@"保存成功" preferredStyle:(UIAlertControllerStyleAlert)];
        [self presentViewController:_alert animated:YES completion:^{
            [self performSelector:@selector(dismisAction) withObject:nil afterDelay:0.5];
        }];
    });
    _leftview.hidden = NO;
}
-(void)dismisAction
{
    [_alert dismissViewControllerAnimated:YES completion:nil];
}








@end
