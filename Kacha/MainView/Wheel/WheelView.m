//
//  WheelView.m
//  try
//
//  Created by 苗乔伟 on 2018/4/8.
//  Copyright © 2018年 苗乔伟. All rights reserved.
//

#import "WheelView.h"
#import "MainViewController.h"

@interface WheelView ()
@property (strong, nonatomic) IBOutlet UIImageView *pictures;
@property NSInteger rightInteger;
@property NSInteger leftInteger;
@end

@implementation WheelView

+ (instancetype)wheelView{
    return  [[[NSBundle mainBundle] loadNibNamed:@"WheelView" owner:nil options:nil] lastObject];
    
}


- (void)rotation{
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    //旋转多少
    anim.toValue = @(M_PI_4);
    //顺时针还是逆时针
    anim.duration = 0.5;
    
    anim.repeatCount = 1;
    
    [self.layer addAnimation:anim forKey:@"transform.rotation"];
    
    
    extern NSInteger gInteger;
   
    
   
    //声明一个字符串，让他来承载名字；
    NSString * imageName_before = [NSString stringWithFormat:@"%d",(int)abs((int) gInteger % 3) + 2];
    NSString * imageName = [NSString stringWithFormat:@"%d",(int)abs((int) gInteger % 3)];
    NSString * imageName_after = [NSString stringWithFormat:@"%d",(int)abs((int) gInteger % 3) + 1];
    if ((int)abs((int) gInteger % 3) == 2 ) {
        imageName_after = [NSString stringWithFormat:@"%d",0];
        imageName_before = [NSString stringWithFormat:@"%d",1];
    }
//    if ((int)abs((int) gInteger % 3) + 2 == 4) {
//        imageName_before = [NSString stringWithFormat:@"%d",1];
//    }
    if ((int)abs((int) gInteger % 3) + 2 == 3) {
        imageName_before = [NSString stringWithFormat:@"%d",0];
    }
//    NSLog(@"%d我从%@向右变化为%@",gInteger,imageName,imageName_after);
    self.pictures.image = [UIImage imageNamed:imageName];
    
    extern NSInteger gLeftRight;
    
    if (gLeftRight == 1) {
        [UIView animateWithDuration:0.5 animations:^{
            self.pictures.image = [UIImage imageNamed:imageName];
            self.pictures.alpha -= 1;
        } completion:^(BOOL finished) {
            self.pictures.image = [UIImage imageNamed:imageName_after];
            self.pictures.alpha = 1;
        }];
    }else if (gLeftRight == 0)
    {
        //向左
        [UIView animateWithDuration:0.5 animations:^{
            NSLog(@"%@",imageName_before);
            self.pictures.image = [UIImage imageNamed:imageName_before];
            self.pictures.alpha -= 1;
        } completion:^(BOOL finished) {
            self.pictures.image = [UIImage imageNamed:imageName_after];
            self.pictures.alpha = 1;
        }];
    }
    
    
    
}

- (void)rotation2{
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    //旋转多少
    anim.toValue = @(M_PI_4);
    //顺时针还是逆时针
    anim.duration = 0.5;
    
    anim.repeatCount = 1;
    
    [self.layer addAnimation:anim forKey:@"transform.rotation"];
    
    
    extern NSInteger gInteger;
    
    
    
    //声明一个字符串，让他来承载名字；
    
    NSString * imageName = [NSString stringWithFormat:@"%d",(int)abs((int)abs(gInteger)  % 3)];
    NSString * imageName_after = [NSString stringWithFormat:@"%d",(int)abs((int)abs(gInteger)  % 3) - 1];
    if ((int)abs((int) gInteger % 3) == 0 ) {
        imageName_after = [NSString stringWithFormat:@"%d",2];
    }
    
    NSLog(@"%d我从%@向右变化为%@",gInteger,imageName,imageName_after);
    self.pictures.image = [UIImage imageNamed:imageName];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.pictures.image = [UIImage imageNamed:imageName];
        self.pictures.alpha -= 1;
    } completion:^(BOOL finished) {
        self.pictures.image = [UIImage imageNamed:imageName_after];
        self.pictures.alpha = 1;
    }];
    
}




@end
