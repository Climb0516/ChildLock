//
//  PopController.m
//  ChildLock
//
//  Created by 王攀登 on 2018/1/1.
//  Copyright © 2018年 王攀登. All rights reserved.
//

#import "PopController.h"

#import "OrientationUtils.h"

@interface PopController ()

@property (nonatomic, assign) UIInterfaceOrientation lastOrientation;

@end

@implementation PopController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.20f];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.hidden = YES;
    //    self.view.alpha = 0;
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bgView];
    bgView.frame = self.view.frame;
    UITapGestureRecognizer * tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [bgView addGestureRecognizer:tapView];
}

- (void)hide {
    [UIView animateWithDuration:0.6 animations:^{
        self.view.hidden = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)show {
    [self performSelector:@selector(visbleView) withObject:nil afterDelay:0.0f];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.modalPresentationStyle = UIModalPresentationCustom;
    [[OrientationUtils getCurrentVC] presentViewController:self animated:YES completion:nil];
}

- (void)visbleView {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.hidden = NO;
        //        self.view.alpha = 1;
    }];
}
- (UIInterfaceOrientation)currentOrientation {
    return self.lastOrientation;
}
-(BOOL)shouldAutorotate
{
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskLandscape|UIInterfaceOrientationMaskPortrait;
}

//iOS8旋转动作的具体执行
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator: coordinator];
    // 监察者将执行： 1.旋转前的动作  2.旋转后的动作（completion）
    [coordinator animateAlongsideTransition: ^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         _lastOrientation = [UIApplication sharedApplication].statusBarOrientation;
         if ([OrientationUtils isOrientationLandscape]) {
             [self p_prepareFullScreen];
         }
         else {
             [self p_prepareSmallScreen];
         }
     } completion: ^(id<UIViewControllerTransitionCoordinatorContext> context) {
     }];
    
}

//iOS7旋转动作的具体执行
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    _lastOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (toInterfaceOrientation == UIDeviceOrientationLandscapeRight || toInterfaceOrientation == UIDeviceOrientationLandscapeLeft) {
        [self p_prepareFullScreen];
    }
    else {
        [self p_prepareSmallScreen];
    }
}

// 切换成全屏的准备工作
- (void)p_prepareFullScreen {
    if (self.UpdateLanscape) {
        self.UpdateLanscape();
    }
}

// 切换成小屏的准备工作
- (void)p_prepareSmallScreen {
    if (self.UpdatePortrait) {
        self.UpdatePortrait();
    }
}

@end
