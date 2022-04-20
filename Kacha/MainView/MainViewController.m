//
//  MainViewController.m
//  KaCha
//
//  Created by 苗乔伟 on 2018/3/21.
//  Copyright © 2018年 苗乔伟. All rights reserved.
//

#import "ClassicalViewController.h"
#import "DIYViewController.h"
#import "ShareViewController.h"
#import "MainViewController.h"
#import "UINavigationController+XWTransition.h"
#import "UIViewController+XWTransition.h"
#import "XWCoolAnimator+XWFold.h"
#import "WheelView.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define bottomW self.main.frame.size.width
#define bottomH self.main.frame.size.height
#define targetR [UIScreen mainScreen].bounds.size.width
#define targetL -[UIScreen mainScreen].bounds.size.width
#define mainP 0
#define rightP ScreenW
#define leftP -ScreenW

@interface MainViewController ()

//@property (strong , nonatomic) UIView *UnusedView;
@property(nonatomic,strong)UISwipeGestureRecognizer *leftS;
@property(nonatomic,strong)UISwipeGestureRecognizer *rightS;
@property(nonatomic,strong)WheelView *wheelV;
@property(nonatomic,strong)UIImageView *background;
@end

@implementation MainViewController

NSInteger gInteger = 0;
NSInteger gLeftRight ;

- (void)viewWillAppear:(BOOL)animated{
    
        if (self.main.hidden == YES)
        self.main.hidden = NO;
    
//    if (self.left.hidden == YES)
//        self.left.hidden = NO;
    
    if (self.right.hidden == YES)
        self.right.hidden = NO;
    
}

- (void)viewDidAppear:(BOOL)animated{
    self.left.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backImage = [UIImage imageNamed:@"back.png"];
    self.view.layer.contents = (id) backImage.CGImage;    // 如果需要背景透明加上下面这句
    //    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;

    
    self.view.backgroundColor = [UIColor colorWithRed:75 green:83 blue:92 alpha:1];
    
    //设置navigationcontroller的bar的颜色和title的颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        UIImageView * background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
//    background.frame = CGRectMake(0, 0, ScreenW, ScreenH);
//    self.background = background;
//    
//    [self.view addSubview: background];
    
    
//    UIImage *bgImage = [UIImage imageNamed:@"background"];
//    self.view.layer.contents = (__bridge id _Nullable)(bgImage.CGImage);
    
//    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainBackground"]];
//    bgView.frame = self.view.bounds;
//    bgView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:bgView];
    UIImageView *round = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rounder"]];
//    UIImageView *round = [[UIImageView alloc] init];

    
    round.frame = CGRectMake(0, 0, ScreenW*0.8, ScreenW*0.8);
    round.center = self.view.center;
//    round.backgroundColor = [UIColor blackColor];
    round.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:round];
    
    
    [self setView];
    [self addBtn];

    //创建圆盘
    
    self.wheelV = [[WheelView wheelView]initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.wheelV.center = self.view.center;
    self.wheelV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.wheelV];
    
    
}



- (void)setView{
    
    self.navigationItem.title = @"KaCha";
    
    UIView *left = [[UIView alloc]initWithFrame:CGRectMake(-ScreenW, 0  , ScreenW, ScreenH )];
    UIView *right = [[UIView alloc]initWithFrame:CGRectMake(ScreenW, 0  , ScreenW, ScreenH )];
    UIView *main = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH )];
    
    left.backgroundColor  = [UIColor clearColor];
    right.backgroundColor = [UIColor clearColor];
    main.backgroundColor  = [UIColor clearColor];
    
    
    self.left = left;
    self.right = right;
    self.main = main;
    
    
    [self.view addSubview:self.left];
    [self.view addSubview:self.right];
    [self.view addSubview:self.main];
    
    
    self.leftS = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftS:)];
    
    self.rightS = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightS:)];
    
    
    _leftS.direction = UISwipeGestureRecognizerDirectionLeft;
    _rightS.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    [self.main addGestureRecognizer:_leftS];
    [self.main addGestureRecognizer:_rightS];
    
}


- (void)leftS:(UISwipeGestureRecognizer *)leftS{
    __block CGRect frame = self.main.frame;
    NSLog(@"%@\n%@\n%@",self.left,self.main,self.right);
    [UIView animateWithDuration:0.5 animations:^{
        frame.origin.x = leftP;
        self.main.frame = frame;
        
        frame.origin.x = mainP;
        self.right.frame = frame;
        
    }];
    frame.origin.x = rightP;
    self.left.frame = frame;
    
    UIView *UnusedView = self.left;
    self.left = self.main;
    self.main = self.right;
    self.right = UnusedView;
    
    if (self.main.gestureRecognizers.count == 0) {
        [self.main addGestureRecognizer:self.leftS];
        [self.main addGestureRecognizer:self.rightS];
    }
    
    extern NSInteger gInteger;
    gInteger += 2;
    extern NSInteger gLeftRight;
    gLeftRight = 0;
    [self.wheelV rotation];
}

- (void)rightS:(UISwipeGestureRecognizer *)rightS{
    __block CGRect frame = self.main.frame;
    [UIView animateWithDuration:0.5 animations:^{
        frame.origin.x =rightP;
        self.main.frame = frame;
        
        frame.origin.x = mainP;
        self.left.frame = frame;
        
    }];
    frame.origin.x = leftP;
    self.right.frame = frame;
    
    UIView *UnusedView = self.right;
    self.right = self.main;
    self.main =self.left;
    self.left = UnusedView;
    
    
    if (self.main.gestureRecognizers.count == 0) {
        [self.main addGestureRecognizer:self.leftS];
        [self.main addGestureRecognizer:self.rightS];
    }
    extern NSInteger gInteger;
    gInteger += 1;
    extern NSInteger gLeftRight;
    gLeftRight = 1;
    [self.wheelV rotation];
    
}



- (void)addBtn{

    
    UIButton *classBtn = [[UIButton alloc]initWithFrame: CGRectMake((ScreenW - 60)/2, ScreenH  * 7 / 8 - 20,60, 60)];
    UIButton *DIYBtn = [[UIButton alloc]initWithFrame: CGRectMake((ScreenW - 60)/2, ScreenH  * 7 / 8- 20,60, 60)];
    UIButton *shareBtn = [[UIButton alloc]initWithFrame: CGRectMake((ScreenW - 60)/2, ScreenH  * 7 / 8- 20, 60, 60)];
    
    classBtn.backgroundColor = [UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1];
    DIYBtn.backgroundColor =[UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1];
    shareBtn.backgroundColor = [UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1];
    
    
    classBtn.layer.cornerRadius =classBtn.frame.size.width/2;
    DIYBtn.layer.cornerRadius =DIYBtn.frame.size.width/2;
    shareBtn.layer.cornerRadius = shareBtn.frame.size.width/2;
    
    UIImageView * ClassicalPicture = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    ClassicalPicture.frame = CGRectMake(-10, -10, 80, 80);
    [classBtn addSubview:ClassicalPicture];
    
    UIImageView * DIYPicture = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    DIYPicture.frame = CGRectMake(-10, -10, 80, 80);
    [DIYBtn addSubview:DIYPicture];
    
    UIImageView * SharePicture = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    SharePicture.frame = CGRectMake(-10, -10, 80, 80);
    [shareBtn addSubview:SharePicture];
    

    [self.main addSubview:classBtn];
    [self.right addSubview:DIYBtn];
    [self.left addSubview:shareBtn];
    

    
    [classBtn addTarget:self action:@selector(classClicked:leftFlag:) forControlEvents:UIControlEventTouchUpInside];
    [DIYBtn addTarget:self action:@selector(DIYClicked:leftFlag:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn addTarget:self action:@selector(shareClicked:leftFlag:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)classClicked:(id<UIViewControllerContextTransitioning>)transitionContext leftFlag:(BOOL)left{
    self.left.hidden = YES;
//    self.main.hidden = YES;
    self.right.hidden = YES;
    ClassicalViewController *classVC = [[ClassicalViewController alloc]init];
    XWCoolAnimator *classAnimator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeFoldFromLeft];
    [self.navigationController xw_pushViewController:classVC withAnimator:classAnimator];
}

- (void)DIYClicked:(id<UIViewControllerContextTransitioning>)transitionContext leftFlag:(BOOL)left{
    self.left.hidden = YES;
//    self.main.hidden = YES;
    self.right.hidden = YES;
    DIYViewController *DIYVC = [[DIYViewController alloc]init];
    XWCoolAnimator *DIYAnimator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeFoldFromLeft];
    [self.navigationController xw_pushViewController:DIYVC withAnimator:DIYAnimator];

}

- (void)shareClicked:(id<UIViewControllerContextTransitioning>)transitionContext leftFlag:(BOOL)left{
    self.left.hidden = YES;
//    self.main.hidden = YES;
    self.right.hidden = YES;
    ShareViewController *shareVC = [[ShareViewController alloc]init];
    XWCoolAnimator *shareAnimator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeFoldFromLeft];
    [self.navigationController xw_pushViewController:shareVC withAnimator:shareAnimator];
}

- (void)classT{
    ClassicalViewController *classVC = [[ClassicalViewController alloc]init];
    [self.navigationController pushViewController:classVC animated:nil];
    
}

- (void)DIY{
    DIYViewController *DIYVC = [[DIYViewController alloc]init];
    [self.navigationController pushViewController:DIYVC animated:nil];
    
}

- (void)share{
    ShareViewController *shareVC = [[ShareViewController alloc]init];
    [self.navigationController pushViewController:shareVC animated:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 过滤掉UIButton，也可以是其他类型
    if ( [touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    
    return YES;
}


@end
