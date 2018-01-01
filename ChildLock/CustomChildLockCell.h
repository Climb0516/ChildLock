//
//  CustomChildLockCell.h
//  ChildLock
//
//  Created by 王攀登 on 2018/1/1.
//  Copyright © 2018年 王攀登. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomChildLockCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;
- (void)configure:(NSString *)title;

@end
