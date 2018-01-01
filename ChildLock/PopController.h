//
//  PopController.h
//  ChildLock
//
//  Created by 王攀登 on 2018/1/1.
//  Copyright © 2018年 王攀登. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopController : UIViewController

@property (nonatomic, copy) void(^UpdateLanscape) (void);
@property (nonatomic, copy) void(^UpdatePortrait) (void);

- (void)show;
- (void)hide;
- (UIInterfaceOrientation)currentOrientation;

@end
