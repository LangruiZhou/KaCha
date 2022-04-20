//
//  Learn2ViewController.m
//  KaCha
//
//  Created by zlr on 2018/5/1.
//  Copyright © 2018年 苗乔伟. All rights reserved.
//

#import "Learn2ViewController.h"

@interface Learn2ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImage;
@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) CAGradientLayer *gradientLayer;
@property (weak, nonatomic) IBOutlet UIView *XiMainView;


@end

@implementation Learn2ViewController

// 设置全局变量i作为控制器
static NSInteger i = 0,flag=0;


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backImage = [UIImage imageNamed:@"back.png"];
    self.view.layer.contents = (id) backImage.CGImage;
    self.navigationItem.title = @"囍";
    
    _XiMainView.layer.cornerRadius = 16;
    _XiMainView.layer.masksToBounds = YES;
    
    i=0;
    // 设置uilabel的文字
    self.label.text = @"将图片从左向右拖拽以完成折叠";
    
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
- (IBAction)pan:(UIPanGestureRecognizer *)pan{
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
            }
        }
    }
    // i==1 且 flag == 0 第一次折叠完毕
    if (i==1 && flag == 0){
        /*
         tapViewController *tapVC = [[tapViewController alloc]init];
         XWCoolAnimator *tapAnimator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeFoldFromLeft];
         [self.navigationController pushViewController:tapVC animated:tapAnimator];
         */
        // 改变uilabel的文字
        self.label.text = @"轻触开始下面的学习";
    }else if(i==1 && flag == 1){     // 再次对折（第二次折叠完毕）
        i = 3;
        self.label.text = @"轻触绘制虚线";
    }
    // i==2，说明tap已经完成且tap开关已关闭，重新设置图片样式与拖动
    if(i==20){
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
            if (transP.x >= -100 ){
                self.gradientLayer.opacity = NO;
                // 左部图片的复位
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.topImage.layer.transform = CATransform3DIdentity;
                } completion:nil];
//                i=10;
                
            }else {
                self.gradientLayer.opacity = NO;
                self.topImage.layer.transform = CATransform3DMakeTranslation(0, 100, 0);
                self.topImage.layer.transform = CATransform3DMakeRotation(180 * M_PI/180, 0, 1, 0);
                i=10;
            }
        }
    }
}
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    // 如果i==1,说明已经完成了折叠，打开tap开关，使图片可以进行裁剪；否则不进行动作
    if(i==1 && flag == 0){
        self.topImage.image=[UIImage imageNamed:@"happy1"];
        self.bottomImage.image=[UIImage imageNamed:@"happy1"];
        self.label.text = @"轻触图片使图片居中";
        // 使控制器i=2,关闭tap开关，使图片可以继续拖拽
        i=2;
    }
    // 此时，图片变换为一个半圆形
    // 如果i==2,再次tap，使图片产生虚线
    else if(i==2 && flag == 0){
        self.label.text = @"从左至右拖拽图片";
        self.topImage.image=[UIImage imageNamed:@"happy2"];
        self.bottomImage.image=[UIImage imageNamed:@"happy2"];
        [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.topImage.layer.transform = CATransform3DIdentity;
        } completion:nil];
        i=0;
        flag = 1;
    }else if(i==3 && flag == 1){
        self.topImage.image=[UIImage imageNamed:@"happy3"];
        self.bottomImage.image=[UIImage imageNamed:@"happy3"];
        self.label.text = @"轻触继续裁剪";
        // 使控制器i=2,关闭tap开关，使图片可以继续拖拽
        i=4;
    }else if(i==4 && flag == 1){
        self.topImage.image=[UIImage imageNamed:@"happy4"];
        self.bottomImage.image=[UIImage imageNamed:@"happy4"];
        self.label.text = @"轻触继续裁剪";
        // 使控制器i=2,关闭tap开关，使图片可以继续拖拽
        i=5;
    }else if(i==5){
        self.topImage.image=[UIImage imageNamed:@"happy5"];
        self.bottomImage.image=[UIImage imageNamed:@"happy5"];
        self.label.text = @"轻触以展开图片";
        // 使控制器i=2,关闭tap开关，使图片可以继续拖拽
        i=6;
    }else if(i == 6){
        self.topImage.image=[UIImage imageNamed:@"happy5"];
        self.bottomImage.image=[UIImage imageNamed:@"happy5"];
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.topImage.layer.transform = CATransform3DIdentity;
        } completion:nil];
        self.label.text = @"轻触将图片移至右侧";
        // 使控制器i=2,关闭tap开关，使图片可以继续拖拽
        i=7;
    }else if(i == 7 ){
        self.topImage.image=[UIImage imageNamed:@"happy6"];
        self.bottomImage.image=[UIImage imageNamed:@"happy6"];
        self.label.text = @"从右至左拖动以展开图片";
        // 使控制器i=2,关闭tap开关，使图片可以继续拖拽
        // 让左图只显示左半部分
        self.topImage.layer.contentsRect = CGRectMake(0, 0, 0.5, 1);
        // 让右图只显示右半部分
        self.bottomImage.layer.contentsRect = CGRectMake(0.5, 0, 0.5, 1);
        
        // 设置锚点
        self.topImage.layer.anchorPoint = CGPointMake(0.74, 0.5);
        self.bottomImage.layer.anchorPoint = CGPointMake(0.26, 0.5);
        self.gradientLayer.opacity = NO;
        self.topImage.layer.transform = CATransform3DMakeTranslation(0, 100, 0);
        self.topImage.layer.transform = CATransform3DMakeRotation(180 * M_PI/180, 0, 1, 0);
        flag = 0;
        i=20;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
