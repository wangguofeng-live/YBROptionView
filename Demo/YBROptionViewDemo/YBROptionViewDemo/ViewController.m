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

@interface ViewController ()
{
    YBROptionGroup *optionGrop;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    optionGrop = [[YBROptionGroup alloc] initWithGroupId:@"Group1"];
    
    
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


@end
