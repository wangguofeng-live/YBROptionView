//
//  YBROptionGroup.m
//  Pods
//
//  Created by bdkj on 2019/3/7.
//

#import "YBROptionGroup.h"
#import <YBRConfigurationModule/YBRToolsMacro.h>

@interface YBROptionGroup ()

@property (nonatomic,copy)NSString *groupId;

@property (nonatomic,strong)NSMutableArray *arrOptionViews;

@end

@implementation YBROptionGroup

- (instancetype)initWithGroupId:(NSString *)argGroupId
{
    self = [super init];
    if (self) {
        self.groupId = argGroupId;
    }
    return self;
}

- (void)addOptionView:(UIControl<YBROptionGroupViewProtocol> *)argOptionView {
    if (![self.arrOptionViews containsObject:argOptionView]) {
        [self.arrOptionViews addObject:argOptionView];
        argOptionView.groupId = self.groupId;
        [argOptionView addTarget:self action:@selector(acitonOptionViewOnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)removeOptionView:(UIControl *)argOptionView {
    if ([self.arrOptionViews containsObject:argOptionView]) {
        [argOptionView removeTarget:self action:@selector(acitonOptionViewOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrOptionViews removeObject:self.arrOptionViews];
    }
}

- (void)removeOptionViewAtIndex:(NSInteger)argIndex {
    if (self.arrOptionViews.count > argIndex) {
        UIControl *pControl = self.arrOptionViews[argIndex];
        [pControl removeTarget:self action:@selector(acitonOptionViewOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrOptionViews removeObjectAtIndex:argIndex];
    }
}

- (NSInteger)selectedIndex {
    
    for (int i = 0; i < self.arrOptionViews.count; i++) {
        UIControl *pControl = self.arrOptionViews[i];
        if (pControl.selected) return i;
    }
    return -1;
}

- (void)setSelectedIndex:(NSInteger)argSelectedIndex {
    if (argSelectedIndex < 0) {
        [self.arrOptionViews makeObjectsPerformSelector:@selector(setSelected:) withObject:@NO];
    }else if (self.arrOptionViews.count > argSelectedIndex) {
        UIControl *pControl = self.arrOptionViews[argSelectedIndex];
        [self acitonOptionViewOnClick:pControl];
    }
}

- (NSArray *)selectedIndexs {
    NSMutableArray *arrSelectedIndex = [NSMutableArray array];
    
    for (int i = 0; i < self.arrOptionViews.count; i++) {
        UIControl *pControl = self.arrOptionViews[i];
        if (pControl.selected) [arrSelectedIndex addObject:@(i)];
    }
    
    return arrSelectedIndex;
}

- (NSArray *)allOptionViews {
    return self.arrOptionViews;
}

- (void)acitonOptionViewOnClick:(id)sender {
    
    if (self.allowsMultipleSelection) {
        //允许多选
        UIControl *obj = sender;
        
        //是否允许状态变更
        BOOL bAllow = YES;
        if (self.shouldOptionStateChangeBlock) {
            bAllow = self.shouldOptionStateChangeBlock(obj);
        }
        
        if (bAllow) {
            if (_allowUnselected) {
                obj.selected = !obj.selected;
            }else {
                obj.selected = YES;
            }
            
            if (self.actionSelectedOptionChangedBlock) {
                self.actionSelectedOptionChangedBlock([self.arrOptionViews indexOfObject:sender]);
            }
        }
        
    }else {
        UIControl *obj = sender;
        
        //是否允许状态变更
        BOOL bAllow = YES;
        if (self.shouldOptionStateChangeBlock) {
            bAllow = self.shouldOptionStateChangeBlock(obj);
        }
        
        if (bAllow) {
            kWeakSelf(self)
            [self.arrOptionViews enumerateObjectsUsingBlock:^(UIControl *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isEqual:sender]) {
                    
                    if (weakself.allowUnselected) {
                        obj.selected = !obj.selected;
                    }else {
                        obj.selected = YES;
                    }
                    
                    if (weakself.actionSelectedOptionChangedBlock) {
                        weakself.actionSelectedOptionChangedBlock(idx);
                    }
                }else {
                    obj.selected = NO;
                }
            }];
        }
    }
}

#pragma mark - Geters & Seters
- (NSMutableArray *)arrOptionViews {
    if (!_arrOptionViews) {
        _arrOptionViews = [NSMutableArray array];
    }
    return _arrOptionViews;
}

@end
