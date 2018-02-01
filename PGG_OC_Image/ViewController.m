//
//  ViewController.m
//  PGG_OC_Image
//
//  Created by 陈鹏 on 2018/1/24.
//  Copyright © 2018年 penggege.CP. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "GuaJiangViewController.h"
#import "AnyCutViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *ItemArray;

@end

static NSString *cellID = @"UITableViewCellID";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    
}
- (NSArray *)ItemArray {
    if (!_ItemArray) {
        _ItemArray = [NSArray arrayWithObjects:@"PGG生成纯色图片",@"PGG给图片添加文字水印",@"PGG给图片添加图片水印",@"PGG裁剪圆形图片",@"PGG裁剪带边框的圆形图片",@"PGG截屏",@"PGG刮奖",@"PGG毛玻璃效果",@"PGG压缩成指定大小",@"PGG来任意裁剪试试",@"PGG缓存图片", nil];
    }
    return _ItemArray;
}

#pragma mark - 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ItemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.ItemArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 6: {
            GuaJiangViewController *guaJiang = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"guajiang"];
            [self presentViewController:guaJiang animated:YES completion:nil];
            break;
        }
        case 9: {
            AnyCutViewController *any = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"anycut"];
            [self presentViewController:any animated:YES completion:nil];
            break;
        }
        default: {
            NextViewController *next = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"next"];
            next.PGGType = (long)indexPath.row;
            [self presentViewController:next animated:YES completion:nil];
            break; }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
