//
//  ChildLockControl.m
//  ChildLock
//
//  Created by 王攀登 on 2018/1/1.
//  Copyright © 2018年 王攀登. All rights reserved.
//

#import "ChildLockControl.h"

#import <Masonry.h>

#import "ChildLockView.h"

#define WEAKSELF __weak typeof(self)weakSelf = self;
@interface ChildLockControl ()

@property (nonatomic, strong) ChildLockView * childLockView;

@end

@implementation ChildLockControl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.childLockView];
    WEAKSELF
    self.childLockView.selectAnswer = ^(BOOL allow, BOOL dismiss) {
        if (allow) {
            weakSelf.selectAnswer(allow);
        }
    };
    [self.childLockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(315, 250));
        make.centerX.centerY.equalTo(self.view);
    }];
}

- (ChildLockView *)childLockView {
    if (!_childLockView) {
        _childLockView = [ChildLockView new];
    }
    return _childLockView;
}



@end
