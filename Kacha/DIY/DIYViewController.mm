//
//  DIYViewController.m
//  KaCha
//
//  Created by 苗乔伟 on 2018/3/21.
//  Copyright © 2018年 苗乔伟. All rights reserved.
//


#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/types_c.h>
#import <opencv2/imgcodecs/ios.h>
#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DIYViewController.h"

@interface DIYViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    cv::Mat cvImage;
    
}


@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak,nonatomic)UIImage* image;

@end


@implementation DIYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:254.0/255 green:224.0/255 blue:136.0/255 alpha:1]];
    self.navigationItem.title = @"创作";
    UIImage *backImage = [UIImage imageNamed:@"back.png"];
    self.view.layer.contents = (id) backImage.CGImage;   
    //    CGRect rect = [UIScreen mainScreen].bounds;
    //    self.imgView.frame = rect;
    
    
    
    self.image = [UIImage imageNamed:@"111.png"];
    UIImageToMat(self.image, cvImage);
    
    if(!cvImage.empty()){
        cv::Mat gray;
        // 将图像转换为灰度显示
        cv::cvtColor(cvImage,gray,CV_RGB2GRAY);
        // 应用高斯滤波器去除小的边缘
        cv::GaussianBlur(gray, gray, cv::Size(5,5), 1.2,1.2);
        // 计算与画布边缘
        cv::Mat edges;
        cv::Canny(gray, edges, 0, 50);
        // 使用白色填充
        //        cvImage.setTo(cv::Scalar::all(225));
        cvImage.setTo(cv::Scalar::all(0));
        // 修改边缘颜色
        cvImage.setTo(cv::Scalar(238,44,44,255),edges);
        // 将Mat转换为Xcode的UIImageView显示
        self.imgView.image = MatToUIImage(cvImage);
    }
}


- (IBAction)addImg:(id)sender {
   
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    
   
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        
        [self presentViewController:pickerImage animated:YES completion:nil];
    }];
    [alertVc addAction:cancle];
    //    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        self.imgView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        
        
        
        
        
        NSData *data;
        if (UIImagePNGRepresentation(self.imgView.image) ==nil)
        {
            data = UIImageJPEGRepresentation(self.imgView.image,1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(self.imgView.image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/userHeader.png"] contents:data attributes:nil];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        //加在视图中
        //
        
        
        UIImageToMat(self.imgView.image, cvImage);
        cv::Mat gray;
        // 将图像转换为灰度显示
        cv::cvtColor(cvImage,gray,CV_RGB2GRAY);
        // 应用高斯滤波器去除小的边缘
        cv::GaussianBlur(gray, gray, cv::Size(5,5), 1.2,1.2);
        // 计算与画布边缘
        cv::Mat edges;
        cv::Canny(gray, edges, 0, 50);
        // 使用白色填充
        //        cvImage.setTo(cv::Scalar::all(225));
        cvImage.setTo(cv::Scalar::all(0));
        // 修改边缘颜色
        cvImage.setTo(cv::Scalar(238,44,44,255),edges);
        // 将Mat转换为Xcode的UIImageView显示
        self.imgView.image = MatToUIImage(cvImage);
        
        
        [self.imgView setImage:self.imgView.image];
        
    }
}
// 取消选取图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
