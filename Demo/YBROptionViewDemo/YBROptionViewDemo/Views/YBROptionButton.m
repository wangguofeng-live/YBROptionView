//
//  YBROptionButton.m
//  YBROptionViewDemo
//
//  Created by bdkj on 2019/3/7.
//  Copyright © 2019 bdkj. All rights reserved.
//

#import "YBROptionButton.h"

@implementation YBROptionButton
@synthesize groupId;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configurationView];
    }
    return self;
}

- (void)configurationView {
    self.layer.borderColor = [UIColor blackColor].CGColor;
}

#pragma mark Seter & Geter

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.layer.borderWidth = selected ? 1 : 0;
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
