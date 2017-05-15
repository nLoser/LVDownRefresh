//
//  LVRefresh.h
//  DownRefresh
//
//  Created by LV on 2017/5/12.
//  Copyright © 2017年 LV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LVRefreshOrgan : UIView
@property (nonatomic, assign) CGRect originFrame;
- (void)stretch:(CGFloat)value;
- (void)refreshing;
- (void)disappearing;
@end

@interface LVRefreshEye : LVRefreshOrgan ///< 眼睛
@property (nonatomic, strong) CALayer * eyeBall;
@end

@interface LVRefreshMouth : LVRefreshOrgan ///< 嘴巴
@property (nonatomic, assign) CGPoint originCenter;
@end

@interface LVRefreshJaw : LVRefreshOrgan ///< 下巴
@end

@interface LVRefreshFace : LVRefreshOrgan ///< 脸
@property (nonatomic, strong) LVRefreshEye *leftEye;
@property (nonatomic, strong) LVRefreshEye *rightEye;
@property (nonatomic, strong) LVRefreshMouth * mouth;
@property (nonatomic, strong) LVRefreshJaw * jaw;
@end

@interface LVRefresh : UIView
+ (LVRefresh *)attachScrollView:(UIScrollView *)scrollView
                         target:(id)target
                         action:(SEL)action;
- (void)scrollViewDidScroll;
- (void)scrollViewDidEndDragging;
- (void)finish;
@end
