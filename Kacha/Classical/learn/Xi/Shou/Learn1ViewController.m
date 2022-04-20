//
//  Learn1ViewController.m
//  KaCha
//
//  Created by zlr on 2018/5/1.
//  Copyright © 2018年 苗乔伟. All rights reserved.
//

#import "Learn1ViewController.h"

@interface Learn1ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImage;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) CAGradientLayer *gradientLayer;
@property (weak, nonatomic) IBOutlet UIView *ShouMainView;

@end

@implementation Learn1ViewController

// 设置全局变量i作为控制器
static NSInteger i = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backImage = [UIImage imageNamed:@"back.png"];
    self.view.layer.contents = (id) backImage.CGImage;  
    self.navigationItem.title = @"寿";
    
    _ShouMainView.layer.cornerRadius = 16;
    _ShouMainView.layer.masksToBounds = YES;
    
    // 设置uilabel的文字
    self.label.text = @"将图片从左向右拖拽以完成折叠";
    
    i=0;
#pragma mark 折叠设置
    // 让左图只显示左半部分
    self.topImage.layer.contentsRect = CGRectMake(0, 0, 0.5, 1);
    // 让右图只显示右半部分
    self.bottomImage.layer.contentsRect = CGRectMake(0.5, 0, 0.5, 1);
    
    // 设置锚点
    self.topImage.layer.anchorPoint = CGPointMake(0.74, 0.5);
    self.bottomImage.layer.anchorPoint = CGPointMake(0.26, 0.5);
    // 渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    // 将阴影覆盖bottomImage
    //    gradientLayer.frame = self.bottomImage.bounds;
    // 设置渐变层的颜色
    gradientLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor,];
    // 设置渐变为透明 opacity为不透明度
    gradientLayer.opacity = 0;
    
    self.gradientLayer = gradientLayer;
    
    [self.bottomImage.layer addSublayer:gradientLayer];
}
- (IBAction)pan:(UIPanGestureRecognizer *)pan {
    // i==0时，图像处于初始状态，进行拖拽以完成折叠
    if(i==0){
        // 获取移动的偏移量
        CGPoint transP = [pan translationInView:pan.view];
        //  让左部图片开始旋转
        CGFloat angle = transP.x*M_PI / 200;
        // 让左边图片开始旋转
        self.topImage.layer.transform = CATransform3DMakeRotation(angle, 0, 1, 0);
        // 添加近大远小的透视效果（修改transform的m34的值）
        CATransform3D transform = CATransform3DIdentity;
        // 眼睛离屏幕的距离
        transform.m34 = -1 / 300.0;
        
        // 设置渐变层的不透明度
        self.gradientLayer.opacity = transP.x * 1/200.0;
        
        self.topImage.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0);
        if (pan.state == UIGestureRecognizerStateEnded){
            if (transP.x <= 100){
                self.gradientLayer.opacity = NO;
                // 左部图片的复位
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.topImage.layer.transform = CATransform3DIdentity;
                } completion:nil];
                i=0;
            }else {
                self.gradientLayer.opacity = NO;
                self.topImage.layer.transform = CATransform3DMakeTranslation(0, 100, 0);
                self.topImage.layer.transform = CATransform3DMakeRotation(180 * M_PI/180, 0, 1, 0);
                i=1;
                self.label.text = @"点击图片以裁剪图片";
            }
        }
    }
    // i==1说明折叠已经完成，改变uilabel的文字
//    if (i==1){
//        /*
//         tapViewController *tapVC = [[tapViewController alloc]init];
//         XWCoolAnimator *tapAnimator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeFoldFromLeft];
//         [self.navigationController pushViewController:tapVC animated:tapAnimator];
//         */
//        // 改变uilabel的文字
//        self.label.text = @"点击图片以裁剪图片";
//    }
    // i==2，说明tap已经完成且tap开关已关闭，重新设置图片样式与拖动
    if(i==100){
        // 让左图只显示右半部分
        self.topImage.layer.contentsRect = CGRectMake(0.5, 0, 0.5, 1);
        // 让右图只显示右半部分
        self.bottomImage.layer.contentsRect = CGRectMake(0.5, 0, 0.5, 1);
        
        // 设置锚点
        self.topImage.layer.anchorPoint = CGPointMake(0.26, 0.5);
        self.bottomImage.layer.anchorPoint = CGPointMake(0.26, 0.5);
        
        // 获取移动的偏移量
        CGPoint transP = [pan translationInView:pan.view];
        //  让左部图片开始旋转
        CGFloat angle = transP.x*M_PI / 200;
        // 让左边图片开始旋转
        self.topImage.layer.transform = CATransform3DMakeRotation(-angle, 0, 1, 0);
        // 添加近大远小的透视效果（修改transform的m34的值）
        CATransform3D transform = CATransform3DIdentity;
        // 眼睛离屏幕的距离
        transform.m34 = -1 / 300.0;
        
        // 设置渐变层的不透明度
        self.gradientLayer.opacity = transP.x * 1/200.0;
        
        self.topImage.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0);
        if (pan.state == UIGestureRecognizerStateEnded){
            if (transP.x >= -100){
                self.gradientLayer.opacity = NO;
                // 左部图片的复位
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.topImage.layer.transform = CATransform3DIdentity;
                } completion:nil];
                i=100;
                
            }else {
                self.gradientLayer.opacity = NO;
                self.topImage.layer.transform = CATransform3DMakeTranslation(0, 100, 0);
                self.topImage.layer.transform = CATransform3DMakeRotation(180 * M_PI/180, 0, 1, 0);
                i=1000;
                
            }
        }
    }
}
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    // 如果i==1,说明已经完成了折叠，打开tap开关，使图片可以进行裁剪；否则不进行动作
    if(i==1){
        self.topImage.image=[UIImage imageNamed:@"NewCircle"];
        self.bottomImage.image=[UIImage imageNamed:@"NewCircle"];
        self.label.text = @"首先，画出同心圆 Tap";
        // 使控制器i=2,关闭tap开关，使图片可以继续拖拽
        i=2;
    }
    // 此时，图片变换为一个半圆形
    // 如果i==2,再次tap，使图片产生虚线
    else if(i==2){
        self.topImage.image=[UIImage imageNamed:@"NewTxCircle"];
        self.bottomImage.image=[UIImage imageNamed:@"NewTxCircle"];
        self.label.text = @"再将同心圆分为三部分";
        // 使控制器i=2,关闭tap开关，使图片可以继续拖拽
        i=3;
    }
    else if(i==3){
        self.topImage.image=[UIImage imageNamed:@"NewTxCircle2"];
        self.bottomImage.image=[UIImage imageNamed:@"NewTxCircle2"];
        self.label.text = @"以同心圆为准勾勒图形";
        // 使控制器i=2,关闭tap开关，使图片可以继续拖拽
        i=4;
    }
    else if(i==4){
        self.topImage.image=[UIImage imageNamed:@"CutOne"];
        self.bottomImage.image=[UIImage imageNamed:@"CutOne"];
        self.label.text = @"对最下面一部分裁剪";
        // 使控制器i=2,关闭tap开关，使图片可以继续拖拽
        i=5;
    }
    else if(i==5){
        self.topImage.image = [UIImage imageNamed:@"CutTwo"];
        self.bottomImage.image = [UIImage imageNamed:@"CutTwo"];
        self.label.text = @"对第二部分裁剪";
        i = 6;
    }
    else if(i==6){
        self.topImage.image = [UIImage imageNamed:@"CutThree"];
        self.bottomImage.image = [UIImage imageNamed:@"CutThree"];
        self.label.text = @"对最后一部分裁剪";
        i = 7;
    }
    else if(i==7){
        self.topImage.image = [UIImage imageNamed:@"NewShou"];
        self.bottomImage.image = [UIImage imageNamed:@"NewShou"];
        self.label.text = @"拖动图片以展开";
        i = 100;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* i=0  初始状态,进行拖拽以完成折叠
   i=1  1)说明折叠已经完成，改变uilabel的文字 2)作为tap的开关，i=1时，tap才会有动作
   i=2
   i=100 tap开关关闭
*/

@end
