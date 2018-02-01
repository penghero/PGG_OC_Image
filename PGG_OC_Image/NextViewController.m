//
//  NextViewController.m
//  PGG_OC_Image
//
//  Created by 陈鹏 on 2018/1/24.
//  Copyright © 2018年 penggege.CP. All rights reserved.
//

#import "NextViewController.h"
#import "UIImage+Quart2D.h"

@interface NextViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *oldImg;
@property (strong, nonatomic) IBOutlet UIImageView *after_Img;
@property (strong, nonatomic) IBOutlet UILabel *beforeData;
@property (strong, nonatomic) IBOutlet UILabel *afterData;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)showAction:(id)sender {
    NSInteger type = self.PGGType;
    switch (type) {
        case 0:{
            self.after_Img.image = [UIImage createImageWithColor:[UIColor redColor] frame:self.view.frame];
            break; }
        case 1: {
                //设置字体样式
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                //NSFontAttributeName:字体大小
            dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
                //字体前景色
            dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
                //字体背景色
            dict[NSBackgroundColorAttributeName] = [UIColor clearColor];
                //字体阴影
            NSShadow * shadow = [[NSShadow alloc]init];
                //阴影偏移量
            shadow.shadowOffset = CGSizeMake(3, 5);
                //阴影颜色
            shadow.shadowColor = [UIColor greenColor];
                //高斯模糊
            shadow.shadowBlurRadius = 5;
            dict[NSShadowAttributeName] = shadow;
                //字体间距
            dict[NSKernAttributeName] = @10;
            self.after_Img.image = [UIImage waterImageWithImage:[UIImage imageNamed:@"textImage"] text:@"鹏哥哥->水印" textPoint:CGPointMake(500, 500) attributedString:dict];
            break; }
        case 2: {
            self.after_Img.image = [UIImage waterImageWithImage:[UIImage imageNamed:@"textImage"] waterImage:[UIImage imageNamed:@"textImage"] waterImageRect:CGRectMake(100, 100, 200, 200)];
            break; }
        case 3: {
            UIImage *img = [UIImage imageNamed:@"textImage"];
            self.after_Img.image = [UIImage clipCircleImageWithImage:img circleRect:CGRectMake(0, 0, img.size.width, img.size.height)];
            break; }
        case 4: {
            UIImage *img = [UIImage imageNamed:@"textImage"];
            self.after_Img.image = [UIImage clipCircleImageWithImage:img circleRect:CGRectMake(0, 0, img.size.width, img.size.height) borderWidth:5 borderColor:[UIColor redColor]];
            break; }
        case 5: {
            [UIImage cutScreenWithView:self.view successBlock:^(UIImage *image, NSData *imagedata) {
                self.after_Img.image = image;
            }];
            break; }
        case 6: {
            
            break; }
        case 7: {
            self.after_Img.image = [UIImage boxblurImage:[UIImage imageNamed:@"zhaoyihuan"] withBlurNumber:0.8];
            break; }
        case 8: {
            UIImage *img = [UIImage imageNamed:@"textImage"];
            NSData *beforeData = UIImageJPEGRepresentation(img,1);
            self.after_Img.image = [UIImage compressImage:img toByte:1000];
            NSData *afterData = UIImageJPEGRepresentation(self.after_Img.image,1);
            [self.beforeData setHidden:NO];
            [self.afterData setHidden:NO];
            self.beforeData.text = [NSString stringWithFormat:@"压缩前:%lu k",(unsigned long)[beforeData length]/1024];
            self.afterData.text = [NSString stringWithFormat:@"压缩后:%lu k",(unsigned long)[afterData length]/1024];
            break; }
        case 9: {
            
            break; }
        case 10: {
            
            break; }
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
