//
//  ClassicalViewController.m
//  KaCha
//
//  Created by 苗乔伟 on 2018/3/21.
//  Copyright © 2018年 苗乔伟. All rights reserved.
//

#import "ClassicalViewController.h"
#import "UINavigationController+XWTransition.h"
#import "UIViewController+XWTransition.h"
#import "XWCoolAnimator+XWFold.h"
#import "EndlessLoopShowView.h"
#import "Learn1ViewController.h"
#import "Learn2ViewController.h"
#import "Learn3ViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height


@interface ClassicalViewController ()<EndlessLoopShowViewDelegate>
@property (strong,nonatomic) UITapGestureRecognizer *tap;
@property (assign,nonatomic) NSInteger count;
@end

@implementation ClassicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame: CGRectMake((ScreenW - 60)/2, ScreenH  * 7 / 8 - 20,60, 60)];
    btn.backgroundColor = [UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1];
    btn.layer.cornerRadius =btn.frame.size.width/2;
    UIImageView * btnPicture = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    btnPicture.frame = CGRectMake(-10, -10, 80, 80);
    [btn addSubview:btnPicture];
    [self.view addSubview:btn];
    
    
    UIImage *backImage = [UIImage imageNamed:@"back.png"];
    self.view.layer.contents = (id) backImage.CGImage;   
    self.navigationItem.title= @"经典";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1],NSForegroundColorAttributeName,nil]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:leftFlag:)];
    
    //创建一下背景图片
    
    UIImageView *bgView = [[UIImageView alloc] init];
//Image:[UIImage imageNamed:@"bgpicture"]];
    bgView.frame = self.view.bounds;
    bgView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:bgView];
    
    EndlessLoopShowView * showView = [[EndlessLoopShowView alloc]initWithFrame:CGRectMake(0, -20, ScreenW, ScreenH)];
    showView.backgroundColor = [UIColor clearColor];
    showView.imageDataArr = @[@"shou",@"xi",@"flower4"];
    
    
    
    showView.delegate = self;
    [self.view addSubview:showView];
    [showView addGestureRecognizer:tap];
    
}
- (void)endlessLoop:(EndlessLoopShowView *)showView scrollToIndex:(NSInteger)currentIndex {
    self.count = currentIndex;
    NSLog(@"currentIndex = %ld",currentIndex);
}

- (void)tap:(id<UIViewControllerContextTransitioning>)transitionContext leftFlag:(BOOL)left{
//    TeachViewController *teachVC = [[TeachViewController alloc]init];
    Learn1ViewController *L1VC = [[Learn1ViewController alloc]init];
    Learn2ViewController *L2VC = [[Learn2ViewController alloc]init];
    Learn3ViewController *L3VC = [[Learn3ViewController alloc]init];
    XWCoolAnimator *classAnimator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeFoldFromLeft];
    
    switch (_count) {
        case 0:
            [self.navigationController xw_pushViewController:L1VC withAnimator:classAnimator];
            NSLog(@"l1就要转了");
            break;
        case 1:
            [self.navigationController xw_pushViewController:L2VC withAnimator:classAnimator];
            NSLog(@"l2就要转了");
            break;
        case 2:
            [self.navigationController xw_pushViewController:L3VC withAnimator:classAnimator];
            NSLog(@"l3就要转了");
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

