//
//  ChildLockView.m
//  ChildLock
//
//  Created by 王攀登 on 2018/1/1.
//  Copyright © 2018年 王攀登. All rights reserved.
//

#import "ChildLockView.h"

#import <Masonry.h>

#import "CustomChildLockCell.h"

#define FONT(x)      [UIFont systemFontOfSize:x]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
@interface ChildLockView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, copy) NSString *answer;
@property(nonatomic, copy) NSString *checkAnswer;
@property(nonatomic, strong) UILabel *answerBord;

@end

@implementation ChildLockView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lock_bg"]];
        //        [MMPopupWindow sharedWindow].touchWildToHide = YES;
        [self generalUI];
    }
    return self;
}

- (void)generalUI {
    
    UIImageView *logoImgView = [UIImageView new];
    logoImgView.image = [UIImage imageNamed:@"Frog"];
    [self addSubview:logoImgView];
    
    // UI
    UILabel *titleLabel = [UILabel new];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = FONT(15);
    titleLabel.textColor = UIColorFromRGB(0x112800);
    titleLabel.text = @"请确认家长身份";
    [self addSubview:titleLabel];
    
    NSString *item = [self math];
    UIFont *calFont = FONT(25);
    CGRect calRect = [item boundingRectWithSize:CGSizeMake(1200, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : calFont} context:nil];
    UILabel *calculate = [UILabel new];
    calculate.font = calFont;
    [self addSubview:calculate];
    
    calculate.text = item;
    self.answerBord = [UILabel new];
    [self addSubview:self.answerBord];
    self.answerBord.textAlignment = NSTextAlignmentCenter;
    self.answerBord.textColor = UIColorFromRGB(0x112800);
    self.answerBord.font = calFont;
    self.answerBord.backgroundColor = UIColorFromRGB(0xA2D46B);
    CALayer *layer = [self.answerBord layer];
    layer.cornerRadius = 35/2;
    layer.borderWidth = 0;
    layer.masksToBounds = YES;
    
    // Masonry
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.offset(30);
        make.height.offset(20);
    }];
    [calculate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.offset(calRect.size.width);
        make.height.offset(calRect.size.height);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(34);
    }];
    [self.answerBord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(calculate.mas_right);
        make.centerY.equalTo(calculate);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(-24);
        make.left.equalTo(self.mas_left).offset(-44);
    }];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(35, 35);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(23);
        make.right.offset(-23);
        make.top.mas_equalTo(calculate.mas_bottom).offset(30);
        make.bottom.offset(0);
    }];
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[CustomChildLockCell class] forCellWithReuseIdentifier:[CustomChildLockCell reuseIdentifier]];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomChildLockCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CustomChildLockCell reuseIdentifier] forIndexPath:indexPath];
    
    [cell configure:[NSString stringWithFormat:@"%ld", (long) indexPath.row]];
    
    
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}


- (NSString *)math {
    NSInteger mtulFirst = arc4random() % 10;
    NSInteger mtulSecond = arc4random() % 10;
    self.answer = [NSString stringWithFormat:@"%ld", mtulFirst * mtulSecond];
    return [NSString stringWithFormat:@"%ld  X  %ld =  ", (long) mtulFirst, (long) mtulSecond];
}

- (void)dealyDismiss {
    self.answerBord.text = nil;
    self.checkAnswer = nil;
}

- (void)dealySend {
    //    [self hide];
    if (self.selectAnswer) {
        self.selectAnswer(YES, NO);
    }
}

//- (void)hide {
////    [super hide];
//    self.selectAnswer(NO, NO);
//
//}

#pragma mark anmation

- (void)shakeAnimationForView:(UIView *)view {
    // 获取到当前的View
    CALayer *viewLayer = view.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 10, position.y);
    CGPoint y = CGPointMake(position.x - 10, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:.06];
    // 设置次数
    [animation setRepeatCount:3];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger num = indexPath.row;
    if (!self.checkAnswer) {
        self.checkAnswer = [NSString stringWithFormat:@"%ld", (long) num];
    } else {
        self.checkAnswer = [self.checkAnswer stringByAppendingString:[NSString stringWithFormat:@"%ld", (long) num]];
    }
    //检测是否正确
    self.answerBord.text = self.checkAnswer;
    if ([self.checkAnswer isEqualToString:self.answer]) {
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(dealySend) userInfo:nil repeats:NO];
        return;
    }
    if (self.answer.length > 1) {
        NSString *subFirst = [self.answer substringToIndex:1];
        if (![subFirst isEqualToString:self.checkAnswer]) {
            [self shakeAnimationForView:self];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(dealyDismiss) userInfo:nil repeats:NO];
        }
    } else {
        [self shakeAnimationForView:self];
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(dealyDismiss) userInfo:nil repeats:NO];
    }
}


@end
