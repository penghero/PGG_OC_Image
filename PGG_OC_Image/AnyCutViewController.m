//
//  AnyCutViewController.m
//  PGG_OC_Image
//
//  Created by 陈鹏 on 2018/1/24.
//  Copyright © 2018年 penggege.CP. All rights reserved.
//

#import "AnyCutViewController.h"
#import "THEmoticonView.h"
#import "UIImage+Quart2D.h"

@interface AnyCutViewController ()

@property (strong, nonatomic) IBOutlet UIView *mengBanView;
@property (strong, nonatomic) IBOutlet UIImageView *zhaoYHImg;
@property (strong, nonatomic) IBOutlet UIButton *resetBtn;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) THEmoticonView *cutImgView;
@end

@implementation AnyCutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cutImgView = [[THEmoticonView alloc] initWithImage:[UIImage createImageWithColor:[UIColor whiteColor] frame:CGRectMake(self.view.center.x, self.view.center.y, 100, 100)]];
    [self.view addSubview:self.cutImgView];
}
- (IBAction)resetBtnAction:(id)sender {
    self.zhaoYHImg.image = [UIImage imageNamed:@"zhaoyihuan"];
    
}
- (IBAction)okBtnAction:(id)sender {
    UIImage *img = [UIImage imageFromImage:self.zhaoYHImg.image inRect:CGRectMake(self.cutImgView.center.x, self.cutImgView.center.y, self.cutImgView.frame.size.width, self.cutImgView.frame.size.height)];
    self.zhaoYHImg.image = img;
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
