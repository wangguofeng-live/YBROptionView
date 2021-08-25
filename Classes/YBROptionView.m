//
//  YBROptionView.m
//  YBRInsiderApp
//
//  Created by bdkj on 2017/1/6.
//  Copyright © 2017年 BDKJ_Hbb. All rights reserved.
//

#import "YBROptionView.h"
#import <Masonry/Masonry.h>

#define YBR_OPTION_VIEW_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


@interface YBROptionView ()
{
    UIImageView *m_pImageView;
    UILabel *m_pTextLabel;
}

@end

@implementation YBROptionView
@synthesize groupId;

- (instancetype)initWithText:(NSString *)argText {
    NSBundle *bundle = [NSBundle bundleForClass:YBROptionView.class];
    return [self initWithText:argText
                selectedImage:[UIImage imageNamed:@"ybr_options_resources_radio" inBundle:bundle compatibleWithTraitCollection:nil]
              unSelectedImage:[UIImage imageNamed:@"ybr_options_resources_unradio" inBundle:bundle compatibleWithTraitCollection:nil]];
}

- (instancetype)initWithText:(NSString *)argText selectedImage:(UIImage *)argSelectedImage unSelectedImage:(UIImage *)argUnselectedImage {
    return [self initWithText:argText selectedImage:argSelectedImage unSelectedImage:argUnselectedImage layoutImageWidth:0 imageToTextInterval:5];
}

- (instancetype)initWithText:(NSString *)argText
               selectedImage:(UIImage *)argSelectedImage
             unSelectedImage:(UIImage *)argUnselectedImage
            layoutImageWidth:(CGFloat)imageWidth
         imageToTextInterval:(CGFloat)imageToTextInterval {
    self = [super init];
    if (self) {
        m_pImageView = [[UIImageView alloc] initWithImage:argUnselectedImage highlightedImage:argSelectedImage];
        [self ov_configurationViewLayoutImageWidth:imageWidth imageToTextInterval:imageToTextInterval];
        self.text = argText;
        
        
        self.enabled = YES;
        [self addTarget:self action:@selector(actionOnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)ov_configurationViewLayoutImageWidth:(CGFloat)imageWidth imageToTextInterval:(CGFloat)imageToTextInterval {
    m_pImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:m_pImageView];
    
    m_pTextLabel = [[UILabel alloc] init];
    m_pTextLabel.textColor = YBR_OPTION_VIEW_RGBA(34, 34, 34, 1);
    m_pTextLabel.font = [UIFont systemFontOfSize:17];
    
    [self addSubview:m_pTextLabel];
    
    [m_pImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        
        if (imageWidth > 0) make.width.mas_equalTo(imageWidth);
    }];
    
    
    __weak typeof(m_pImageView) weakImageView = m_pImageView;
    [m_pTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(m_pImageView) strongImageView = weakImageView;
        make.left.mas_equalTo(strongImageView.mas_right).offset(imageToTextInterval);
        make.centerY.mas_equalTo(0);
    }];

}

- (void)actionOnClick:(id)sender {
    if (!self.groupId) {
        
        if (_allowUnselected) {
            self.selected = !self.selected;
        }else {
            self.selected = YES;
        }
    }
}

#pragma mark Seter & Geter

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    m_pImageView.highlighted = selected;
}

- (void)setText:(NSString *)text {
    m_pTextLabel.text = text;
}

- (NSString *)text {
    return m_pTextLabel.text;
}

- (void)setTextFont:(UIFont *)textFont {
    m_pTextLabel.font = textFont;
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        self.alpha = 1;
    }else {
        self.alpha = 0.3f;
    }
}

@end
