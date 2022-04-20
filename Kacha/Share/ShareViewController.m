//
//  ShareViewController.m
//  KaCha
//
//  Created by 苗乔伟 on 2018/3/21.
//  Copyright © 2018年 苗乔伟. All rights reserved.
//

#import "ShareViewController.h"
#import "ARViewController.h"
#import "UINavigationController+XWTransition.h"
#import "UIViewController+XWTransition.h"
#import "XWCoolAnimator+XWFold.h"


@interface ShareViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btn setTintColor:[UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1]];
    self.navigationItem.title = @"纸雕灯";
    UIImage *backImage = [UIImage imageNamed:@"back.png"];
    self.view.layer.contents = (id) backImage.CGImage;   
//    self.view.backgroundColor = [UIColor ];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1],NSForegroundColorAttributeName,nil]];
    
    
    
    
}
- (IBAction)click:(id)sender {
    
    ARViewController *ARVC = [[ARViewController alloc]init];
    XWCoolAnimator *ARAN = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeFoldFromLeft];
    [self.navigationController xw_pushViewController:ARVC withAnimator:ARAN];
//    ARViewController *ARVC = [[ARViewController alloc]init];
//    [self.navigationController pushViewController:ARVC animated:YES];
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
