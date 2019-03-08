//
//  YBROptionGroup.h
//  Pods
//
//  Created by bdkj on 2019/3/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol YBROptionGroupViewProtocol;
@interface YBROptionGroup : UITableView <UITableViewDelegate>

- (instancetype)initWithGroupId:(NSString *)argGroupId;

@property (nonatomic,readonly)NSInteger selectedIndex;

@property (nonatomic,readonly)NSArray *selectedIndexs;

@property (nonatomic,readonly)NSArray *allOptionViews;

//选中之前会d
@property (nonatomic, copy)BOOL (^shouldOptionStateChangeBlock)(UIControl* optionView);

@property (nonatomic, copy)void (^actionSelectedOptionChangedBlock)(NSInteger changedIndex);

/**
 *  允许手动取消
 */
@property (nonatomic,assign)BOOL allowUnselected;

/**
 *  允许多选
 */
@property (nonatomic,assign)BOOL allowsMultipleSelection;

- (void)addOptionView:(UIControl<YBROptionGroupViewProtocol> *)argOptionView;
- (void)removeOptionView:(UIControl *)argOptionView;
- (void)removeOptionViewAtIndex:(NSInteger)argIndex;

- (void)setSelectedIndex:(NSInteger)argSelectedIndex;

@end

@protocol YBROptionGroupViewProtocol <NSObject>

@property (nonatomic, copy)NSString *groupId;

@end

NS_ASSUME_NONNULL_END
