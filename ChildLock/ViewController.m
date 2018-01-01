//
//  ViewController.m
//  ChildLock
//
//  Created by 王攀登 on 2018/1/1.
//  Copyright © 2018年 王攀登. All rights reserved.
//

#import "ViewController.h"

#import <Masonry.h>

#import "ChildLockControl.h"

#define WEAKSELF __weak typeof(self)weakSelf = self;
@interface ViewController ()

@property(nonatomic, strong) ChildLockControl * lockControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIButton *lockButton = [UIButton new];
    [lockButton setTitle:@"童锁" forState:UIControlStateNormal];
    [lockButton setBackgroundColor:[UIColor purpleColor]];
    [lockButton addTarget:self action:@selector(lockBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lockButton];
    [lockButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

- (void)lockBtnClick {
    self.lockControl = [ChildLockControl new];
    WEAKSELF
    self.lockControl.selectAnswer = ^(BOOL allow) {
        if (allow) {
            [weakSelf.lockControl hide];
            [weakSelf doSomething];
        }
    };
    [self.lockControl show];
}

- (void)doSomething {
    
}


@end
