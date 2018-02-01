//
//  NextViewController.h
//  PGG_OC_Image
//
//  Created by 陈鹏 on 2018/1/24.
//  Copyright © 2018年 penggege.CP. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, PGGImageType) {
    PGGImageTypeA = 0,
    PGGImageTypeB,
    PGGImageTypeC,
    PGGImageTypeD,
    PGGImageTypeE,
    PGGImageTypeF,
    PGGImageTypeG,
    PGGImageTypeH,
    PGGImageTypeI,
    PGGImageTypeJ,
    PGGImageTypeK,
};

/**
 普通展示
 */
@interface NextViewController : UIViewController

@property (assign, nonatomic) PGGImageType *PGGType;

@end
