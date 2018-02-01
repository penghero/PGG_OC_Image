//
//  GuaJiangViewController.m
//  PGG_OC_Image
//
//  Created by 陈鹏 on 2018/1/24.
//  Copyright © 2018年 penggege.CP. All rights reserved.
//https://github.com/penghero/PGG_OC_Image.git

#import "GuaJiangViewController.h"
#import "UIImage+Quart2D.h"

@interface GuaJiangViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *zhaoYHImage;
@property (strong, nonatomic) IBOutlet UIImageView *moHuImage;

@end

@implementation GuaJiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    添加拖动手势 模拟擦拭
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(wipePanGestureEvent:)];
    [self.moHuImage addGestureRecognizer:pan];
}
- (void)wipePanGestureEvent:(UIPanGestureRecognizer * )pan{
    self.moHuImage.image = [UIImage wipeImageWithView:self.moHuImage currentPoint:[pan locationInView:self.moHuImage] size:CGSizeMake(30, 30)];
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
