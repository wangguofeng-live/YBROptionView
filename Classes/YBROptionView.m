//
//  YBROptionView.m
//  YBRInsiderApp
//
//  Created by bdkj on 2017/1/6.
//  Copyright © 2017年 BDKJ_Hbb. All rights reserved.
//

#import "YBROptionView.h"
#import <PureLayout/PureLayout.h>
#import "YBRToolsMacro.h"

//#define YBROptionValueChangedNotification @"YBROptionValueChangedNotification"
//#define YBROptionValueChangedNotificationUserInfoKey_Group @"YBROptionValueChangedNotificationUserInfoKey_Group"
//#define YBROptionValueChangedNotificationUserInfoKey_FromObject @"YBROptionValueChangedNotificationUserInfoKey_FromObject"

@class YBROptionGroup;

@interface YBROptionView ()
{
    UIImageView *m_pImageView;
    UILabel *m_pTextLabel;
}

@property (nonatomic, assign)YBROptionGroup *optionGroup;

@end

@implementation YBROptionView

- (instancetype)initWithText:(NSString *)argText {
    NSBundle *bundle = [NSBundle bundleForClass:YBROptionView.class];
    return [self initWithText:argText
                selectedImage:[UIImage imageNamed:@"ybr_options_resources_radio" inBundle:bundle compatibleWithTraitCollection:nil]
              unSelectedImage:[UIImage imageNamed:@"ybr_options_resources_unradio" inBundle:bundle compatibleWithTraitCollection:nil]];
}

- (instancetype)initWithText:(NSString *)argText selectedImage:(UIImage *)argSelectedImage unSelectedImage:(UIImage *)argUnselectedImage {
    self = [super init];
    if (self) {
        m_pImageView = [[UIImageView alloc] initWithImage:argUnselectedImage highlightedImage:argSelectedImage];
        [self ov_configurationView];
        self.text = argText;
        
        
        self.enabled = YES;
        [self addTarget:self action:@selector(actionOnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(optionValueChangedNotification:) name:YBROptionValueChangedNotification object:nil];
    }
    return self;
}

- (void)ov_configurationView {
    m_pImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:m_pImageView];
    [m_pImageView configureForAutoLayout];
    [m_pImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
    //    [m_pImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    //    [m_pImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    m_pTextLabel = [[UILabel alloc] init];
    m_pTextLabel.textColor = RGBA(34, 34, 34, 1);
    m_pTextLabel.font = [UIFont systemFontOfSize:17];
    
    [self addSubview:m_pTextLabel];
    [m_pTextLabel configureForAutoLayout];
    [m_pTextLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:m_pImageView withOffset:5];
    [m_pTextLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

- (void)actionOnClick:(id)sender {
    //    [[NSNotificationCenter defaultCenter] postNotificationName:YBROptionValueChangedNotification object:nil userInfo:@{YBROptionValueChangedNotificationUserInfoKey_Group:self.group,YBROptionValueChangedNotificationUserInfoKey_FromObject : self}];
    //
    if (!_optionGroup) {
        
        if (_allowUnselected) {
            self.selected = !self.selected;
        }else {
            self.selected = YES;
        }
    }
}

//- (void)optionValueChangedNotification:(NSNotification *)notification {
//
//    NSDictionary *userInfo = notification.userInfo;
//    NSString *strGroup = [userInfo objectForKey:YBROptionValueChangedNotificationUserInfoKey_Group];
//    if ([strGroup isEqual:self.group]) {
//
//        id pFromObject = [userInfo objectForKey:YBROptionValueChangedNotificationUserInfoKey_FromObject];
//        self.selected = [self isEqual:pFromObject];
//    }
//
//}

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

@end

@interface YBROptionGroup ()
{
    NSMutableArray *m_arrOptionViews;
    void (^argSelectedOptionChangedBlock)(NSInteger);
}
@end

@implementation YBROptionGroup

- (instancetype)initWithGroupId:(NSString *)argGroupId
{
    self = [super init];
    if (self) {
        m_arrOptionViews = [NSMutableArray array];
    }
    return self;
}

- (void)addOptionView:(YBROptionView *)argOptionView {
    if (![m_arrOptionViews containsObject:argOptionView]) {
        [m_arrOptionViews addObject:argOptionView];
        argOptionView.optionGroup = self;
        [argOptionView addTarget:self action:@selector(acitonOptionViewOnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)removeOptionView:(UIControl *)argOptionView {
    if ([m_arrOptionViews containsObject:argOptionView]) {
        [argOptionView removeTarget:self action:@selector(acitonOptionViewOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [m_arrOptionViews removeObject:m_arrOptionViews];
    }
}

- (void)removeOptionViewAtIndex:(NSInteger)argIndex {
    if (m_arrOptionViews.count > argIndex) {
        UIControl *pControl = m_arrOptionViews[argIndex];
        [pControl removeTarget:self action:@selector(acitonOptionViewOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [m_arrOptionViews removeObjectAtIndex:argIndex];
    }
}

- (NSInteger)selectedIndex {
    
    for (int i = 0; i < m_arrOptionViews.count; i++) {
        UIControl *pControl = m_arrOptionViews[i];
        if (pControl.selected) return i;
    }
    return -1;
}

- (void)setSelectedIndex:(NSInteger)argSelectedIndex {
    if (argSelectedIndex < 0) {
        [m_arrOptionViews makeObjectsPerformSelector:@selector(setSelected:) withObject:@NO];
    }else if (m_arrOptionViews.count > argSelectedIndex) {
        UIControl *pControl = m_arrOptionViews[argSelectedIndex];
        [self acitonOptionViewOnClick:pControl];
    }
}

- (NSArray *)selectedIndexs {
    NSMutableArray *arrSelectedIndex = [NSMutableArray array];
    
    for (int i = 0; i < m_arrOptionViews.count; i++) {
        UIControl *pControl = m_arrOptionViews[i];
        if (pControl.selected) [arrSelectedIndex addObject:@(i)];
    }
    
    return arrSelectedIndex;
}

- (NSArray *)allOptionViews {
    return m_arrOptionViews;
}

- (void)acitonOptionViewOnClick:(id)sender {
    
    if (self.allowsMultipleSelection) {
        //允许多选
        UIControl *obj = sender;
        if (_allowUnselected) {
            obj.selected = !obj.selected;
        }else {
            obj.selected = YES;
        }
        
         if (argSelectedOptionChangedBlock) {
             argSelectedOptionChangedBlock([m_arrOptionViews indexOfObject:sender]);
         }
        
    }else {
        
        [m_arrOptionViews enumerateObjectsUsingBlock:^(UIControl *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isEqual:sender]) {
                
                if (_allowUnselected) {
                    obj.selected = !obj.selected;
                }else {
                    obj.selected = YES;
                }
                
                if (argSelectedOptionChangedBlock) {
                    argSelectedOptionChangedBlock(idx);
                }
            }else {
                obj.selected = NO;
            }
        }];
    }
}

- (void)addSelectedOptionChangedBlock:(void (^)(NSInteger))argBlock {
    argSelectedOptionChangedBlock = [argBlock copy];
}

@end
