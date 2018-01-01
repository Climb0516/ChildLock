//
//  ChildLockControl.h
//  ChildLock
//
//  Created by 王攀登 on 2018/1/1.
//  Copyright © 2018年 王攀登. All rights reserved.
//

#import "PopController.h"

@interface ChildLockControl : PopController

@property(nonatomic, copy) void (^selectAnswer)(BOOL allow);

@end
