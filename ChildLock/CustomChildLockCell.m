//
//  CustomChildLockCell.m
//  ChildLock
//
//  Created by 王攀登 on 2018/1/1.
//  Copyright © 2018年 王攀登. All rights reserved.
//

#import "CustomChildLockCell.h"

#import <Masonry.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
@interface CustomChildLockCell ()

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation CustomChildLockCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CALayer *layer = [self.contentView layer];
        layer.cornerRadius = 35/2;
        layer.borderWidth = 0;
        layer.masksToBounds = YES;
        self.contentView.backgroundColor = UIColorFromRGB(0xA2D46B);
        self.titleLabel = [UILabel new];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)configure:(NSString *)title {
    self.titleLabel.text = title;
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
