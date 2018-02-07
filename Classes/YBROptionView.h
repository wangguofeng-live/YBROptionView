//
//  YBROptionView.h
//  YBRInsiderApp
//
//  Created by bdkj on 2017/1/6.
//  Copyright © 2017年 BDKJ_Hbb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBROptionView : UIControl

- (instancetype)initWithText:(NSString *)argText;

- (instancetype)initWithText:(NSString *)argText selectedImage:(UIImage *)argSelectedImage unSelectedImage:(UIImage *)argUnselectedImage;

@property (nonatomic)NSString *text;

@property (nonatomic)UIFont *textFont;

@property (nonatomic)UIColor *textColor;

/**
 *  允许手动取消
 */
@property (nonatomic,assign)BOOL allowUnselected;

@end


@interface YBROptionGroup : NSObject

- (instancetype)initWithGroupId:(NSString *)argGroupId;

@property (nonatomic,readonly)NSInteger selectedIndex;

@property (nonatomic,readonly)NSArray *selectedIndexs;

@property (nonatomic,readonly)NSArray *allOptionViews;

/**
 *  允许手动取消
 */
@property (nonatomic,assign)BOOL allowUnselected;

/**
 *  允许多选
 */
@property (nonatomic,assign)BOOL allowsMultipleSelection;

- (void)addOptionView:(YBROptionView *)argOptionView;
- (void)removeOptionView:(UIControl *)argOptionView;
- (void)removeOptionViewAtIndex:(NSInteger)argIndex;

- (void)setSelectedIndex:(NSInteger)argSelectedIndex;

- (void)addSelectedOptionChangedBlock:(void (^)(NSInteger))argBlock;

@end
