//
//  LVRefresh.m
//  DownRefresh
//
//  Created by LV on 2017/5/12.
//  Copyright © 2017年 LV. All rights reserved.
//

#import "LVRefresh.h"

static const CGFloat kLVRefreshHeight = 64;
static const CGFloat kLVRefreshFaceWidth = 40;
static const CGFloat kLVRefreshEyeWidth = 12;
static const CGFloat kLVRefreshMouthNormalWidth = 8;
static const CGFloat kLVRefreshMouthNormalHeigh = 5;

static const CGFloat kLVRefreshLineW = 1;

static const CGFloat kLVRefreshEyeBot = 14;
static const CGFloat kLVRefreshEyeLeft = 4;
static const CGFloat kLVRefreshMouthBot = 4;



#define kLVRefreshStyleColor [UIColor blackColor]
#define kLVRefreshMouthColor [UIColor colorWithRed:1 green:0.78 blue:0.78 alpha:1]


typedef NS_ENUM(NSUInteger, LVRefreshControlState) {
    LVRefreshControlStateIdle,
    LVRefreshControlStateRefreshing,
    LVRefreshControlStateFinished
};


@implementation LVRefreshOrgan
- (void)stretch:(CGFloat)value{}
- (void)refreshing{}
- (void)disappearing{}
@end
@implementation LVRefreshEye
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.eyeBall];
        self.layer.cornerRadius = ceilf(CGRectGetWidth(frame)/2.f);
        self.layer.borderColor = kLVRefreshStyleColor.CGColor;
        self.layer.borderWidth = kLVRefreshLineW;
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (CALayer *)eyeBall {
    if (!_eyeBall) {
        _eyeBall = [CALayer layer];
        _eyeBall.frame =CGRectMake(0, 0, 2, 2);
        _eyeBall.cornerRadius = 1;
        _eyeBall.masksToBounds = YES;
        _eyeBall.backgroundColor = kLVRefreshStyleColor.CGColor;
        _eyeBall.position = CGPointMake(ceilf(CGRectGetWidth(self.frame)/2.f), ceilf(CGRectGetHeight(self.frame)/2.f));
    }
    return _eyeBall;
}
- (void)stretch:(CGFloat)value {
    if (value<=2) {
        value = 2;
    }else {
        value =  (MIN(value, kLVRefreshHeight) / kLVRefreshHeight) * CGRectGetWidth(self.frame);
    }
    CGRect bouds = self.bounds;
    bouds.size = CGSizeMake(value, value);
    _eyeBall.bounds = bouds;
    _eyeBall.cornerRadius = value/2.f;
}
- (void)refreshing {
    [self disappearing];
    UIBezierPath * rotation = [UIBezierPath bezierPathWithArcCenter:_eyeBall.position radius:CGRectGetWidth(self.frame)/2.f-2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.path = rotation.CGPath;
    ani.duration = 2;
    ani.repeatCount = MAXFLOAT;
    [_eyeBall addAnimation:ani forKey:@"rortaion"];
}
- (void)disappearing {
    [_eyeBall removeAllAnimations];
    CGRect bouds = self.bounds;
    bouds.size = CGSizeMake(2, 2);
    _eyeBall.bounds = bouds;
    _eyeBall.cornerRadius = 1;
}
@end
@implementation LVRefreshMouth
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kLVRefreshStyleColor;
    }
    return self;
}
@end
@implementation LVRefreshJaw

@end
@implementation LVRefreshFace
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftEye];
        [self addSubview:self.rightEye];
        [self addSubview:self.mouth];
        [self addSubview:self.jaw];
    }
    return self;
}
-(LVRefreshEye *)leftEye {
    if (!_leftEye) {
        CGRect frame = CGRectMake(0, 0, kLVRefreshEyeWidth, kLVRefreshEyeWidth);
        frame.origin.y = CGRectGetHeight(self.frame)-kLVRefreshEyeBot-kLVRefreshEyeWidth;
        frame.origin.x = kLVRefreshEyeLeft;
        _leftEye = [[LVRefreshEye alloc] initWithFrame:frame];
        _leftEye.originFrame = frame;
    }
    return _leftEye;
}
- (LVRefreshEye *)rightEye {
    if (!_rightEye) {
        CGRect frame = CGRectMake(0, 0, kLVRefreshEyeWidth, kLVRefreshEyeWidth);
        frame.origin.y = CGRectGetHeight(self.frame)-kLVRefreshEyeBot-kLVRefreshEyeWidth;
        frame.origin.x = CGRectGetWidth(self.frame)-kLVRefreshEyeWidth-kLVRefreshEyeLeft;
        _rightEye = [[LVRefreshEye alloc] initWithFrame:frame];
        _rightEye.originFrame = frame;
    }
    return _rightEye;
}
- (LVRefreshMouth *)mouth {
    if (!_mouth) {
        CGRect frame = CGRectMake(0, CGRectGetHeight(self.frame)-kLVRefreshMouthBot-kLVRefreshMouthNormalHeigh, kLVRefreshMouthNormalWidth, kLVRefreshMouthNormalHeigh);
        _mouth = [[LVRefreshMouth alloc] initWithFrame:frame];
        CGPoint center = _mouth.center;
        center.x = ceilf(CGRectGetWidth(self.frame)/2.f);
        _mouth.center = center;
        _mouth.originFrame = frame;
    }
    return _mouth;
}
- (LVRefreshJaw *)jaw {
    if (!_jaw) {
        
    }
    return _jaw;
}
#pragma mark - Override
- (void)stretch:(CGFloat)value {
    [_leftEye stretch:value];
    [_rightEye stretch:value];
    [_mouth stretch:value];
    [_jaw stretch:value];
    //TODO:
    
    if (value == 0) {
        self.frame = self.originFrame;
    }else {
        CGRect frame = self.originFrame;
        frame.origin.y -= value;
        self.frame = frame;
    }
}
- (void)refreshing {
    [_leftEye refreshing];
    [_rightEye refreshing];
    [_mouth refreshing];
    [_jaw refreshing];
    //TODO:
    
    self.frame = self.originFrame;
}
-(void)disappearing {
    [_leftEye disappearing];
    [_rightEye disappearing];
    [_mouth disappearing];
    [_jaw disappearing];
    //TODO:
    
    self.frame = self.frame;
}
@end










@interface LVRefresh()
@property (nonatomic, strong) LVRefreshFace * face;
@property (nonatomic, assign) LVRefreshControlState state;

@property (nonatomic, assign) CGFloat animationProgress;
@property (nonatomic, assign) CGFloat overflow;
@property (nonatomic, assign) CGFloat originTopContentInset;
@property (nonatomic, assign) CGFloat realContentOffsetY;
@property (nonatomic, weak) UIScrollView * weakScrollView;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;
@end

@implementation LVRefresh


#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _face = [[LVRefreshFace alloc] initWithFrame:CGRectMake(0, 0, kLVRefreshFaceWidth, kLVRefreshFaceWidth)];
        _face.center = CGPointMake(ceilf(CGRectGetWidth(frame)/2.f), ceilf(CGRectGetHeight(frame)/2.f));
        _face.originFrame = _face.frame;
        [self addSubview:_face];
        
        _face.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

#pragma mark - Getter

- (CGFloat)animationProgress {
    return MIN(1, fabs(self.realContentOffsetY/kLVRefreshHeight));
}

- (CGFloat)realContentOffsetY {
    return self.weakScrollView.contentOffset.y;
}

- (CGFloat)overflow {
    CGFloat y = self.weakScrollView.contentOffset.y;
    if(y>=0) return 0;
    y = y+kLVRefreshHeight;
    return y<0?fabs(y):0;
}

#pragma mark - Private 

- (void)stretchWithOverflow:(CGFloat)overflow {
    [self.face stretch:overflow];
}

#pragma mark - Public

+ (LVRefresh *)attachScrollView:(UIScrollView *)scrollView target:(id)target action:(SEL)action {
    CGFloat width = CGRectGetWidth(scrollView.frame);
    LVRefresh * refresh = [[LVRefresh alloc] initWithFrame:CGRectMake(0, -kLVRefreshHeight, width, kLVRefreshHeight)];
    refresh.weakScrollView = scrollView;
    refresh.target = target;
    refresh.action = action;
    [scrollView addSubview:refresh];
    return refresh;
}

- (void)scrollViewDidScroll {
    if (self.state == LVRefreshControlStateIdle) {
        [self stretchWithOverflow:self.overflow];
    }
}

- (void)scrollViewDidEndDragging {
    if (self.state == LVRefreshControlStateIdle) {
        if(self.animationProgress == 1) self.state = LVRefreshControlStateRefreshing;
        if (self.state == LVRefreshControlStateRefreshing) {
            UIEdgeInsets newInsets = self.weakScrollView.contentInset;
            newInsets.top = self.originTopContentInset + CGRectGetHeight(self.frame);
            CGPoint contentOffset = self.weakScrollView.contentOffset;
            
            [UIView animateWithDuration:0 animations:^{
                self.weakScrollView.contentInset = newInsets;
                self.weakScrollView.contentOffset = contentOffset;
            }];
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            if ([self.target respondsToSelector:self.action]) {
                [self.target performSelector:self.action withObject:self];
            }
#pragma clang diagnostic pop
            //TODO:刷新
            [self.face refreshing];
        }else {
            [self.face disappearing];
        }
    }
}

#pragma mark - Public Action

- (void)finish {
    [self.face disappearing];
    
    self.state = LVRefreshControlStateFinished;
    UIEdgeInsets newInsets = self.weakScrollView.contentInset;
    newInsets.top = 0;
    [UIView animateWithDuration:0.8 animations:^{
        self.weakScrollView.contentInset = newInsets;
    }completion:^(BOOL finished) {
        self.state = LVRefreshControlStateIdle;
    }];
}

@end
