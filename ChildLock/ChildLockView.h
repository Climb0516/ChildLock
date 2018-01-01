//
//  ChildLockView.h
//  ChildLock
//
//  Created by 王攀登 on 2018/1/1.
//  Copyright © 2018年 王攀登. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ChildLockChangeLock = 1,
    ChildLockChangeUnlock = 2,
    ChildLockChangeHide = 3,
}ChildLockChangeType;

@interface ChildLockView : UIView

@property(nonatomic, copy) void (^selectAnswer)(BOOL allow, BOOL dismiss);

@end
