//
//  YBROptionView.h
//  YBRInsiderApp
//
//  Created by bdkj on 2017/1/6.
//  Copyright © 2017年 BDKJ_Hbb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBROptionGroup.h"

@interface YBROptionView : UIControl <YBROptionGroupViewProtocol>

- (instancetype)initWithText:(NSString *)argText;

- (instancetype)initWithText:(NSString *)argText selectedImage:(UIImage *)argSelectedImage unSelectedImage:(UIImage *)argUnselectedImage;

- (instancetype)initWithText:(NSString *)argText
               selectedImage:(UIImage *)argSelectedImage
             unSelectedImage:(UIImage *)argUnselectedImage
            layoutImageWidth:(CGFloat)imageWidth
         imageToTextInterval:(CGFloat)imageToTextInterval;

@property (nonatomic)NSString *text;

@property (nonatomic)UIFont *textFont;

@property (nonatomic)UIColor *textColor;

/**
 *  允许手动取消 （当加入Group时，失效)
 */
@property (nonatomic,assign)BOOL allowUnselected;

@end
