//
//  ViewController.m
//  YBROptionViewDemo
//
//  Created by bdkj on 2019/3/6.
//  Copyright © 2019 bdkj. All rights reserved.
//

#import "ViewController.h"

#import <YBROptionView.h>
#import <PureLayout.h>

#import "YBROptionButton.h"

@interface ViewController ()
{
    YBROptionGroup *optionGrop;
    
    YBROptionGroup *option2Grop;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testSimpleOptionView];
    [self testCustomOptionView];
}

- (void)testSimpleOptionView {
    optionGrop = [[YBROptionGroup alloc] initWithGroupId:@"Group1"];
//    optionGrop.allowUnselected = YES;   //是否可以取消选中
//    optionGrop.allowsMultipleSelection = YES; //是否允许多选
    
    YBROptionView *pOption1View = [[YBROptionView alloc] initWithText:@"Option1"];
    
    YBROptionView *pOption2View = [[YBROptionView alloc] initWithText:@"Option2"];
    
    [self.view addSubview:pOption1View];
    [self.view addSubview:pOption2View];
    
    [optionGrop addOptionView:pOption1View];
    [optionGrop addOptionView:pOption2View];
    
    
    [pOption1View autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:150];
    [pOption1View autoSetDimensionsToSize:CGSizeMake(100, 30)];
    [pOption1View autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    
    [pOption2View autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:150];
    [pOption2View autoSetDimensionsToSize:CGSizeMake(100, 30)];
    [pOption2View autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
}

- (void)testCustomOptionView {
    option2Grop = [[YBROptionGroup alloc] initWithGroupId:@"Group2"];
    
    YBROptionButton *pOption1View = [YBROptionButton buttonWithType:UIButtonTypeCustom];
    [pOption1View setTitle:@"Custom1" forState:UIControlStateNormal];
    [pOption1View setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pOption1View.layer.cornerRadius = 15;
    
    YBROptionButton *pOption2View = [YBROptionButton buttonWithType:UIButtonTypeCustom];
    [pOption2View setTitle:@"Custom2" forState:UIControlStateNormal];
    [pOption2View setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pOption2View.layer.cornerRadius = 15;
    
    [self.view addSubview:pOption1View];
    [self.view addSubview:pOption2View];
    
    [option2Grop addOptionView:pOption1View];
    [option2Grop addOptionView:pOption2View];
    
    
    [pOption1View autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:150];
    [pOption1View autoSetDimensionsToSize:CGSizeMake(100, 30)];
    [pOption1View autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:400];
    
    [pOption2View autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:150];
    [pOption2View autoSetDimensionsToSize:CGSizeMake(100, 30)];
    [pOption2View autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:400];
}

@end
