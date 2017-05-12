//
//  ViewController.m
//  DownRefresh
//
//  Created by LV on 2017/5/12.
//  Copyright © 2017年 LV. All rights reserved.
//

#import "ViewController.h"
#import "LVRefresh.h"

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate>
@property (nonatomic, strong) UITableView * sc;
@property (nonatomic, strong) LVRefresh * refresh;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.sc = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.sc.delegate = self;
    self.sc.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.sc];
    self.refresh = [LVRefresh attachScrollView:self.sc target:self action:@selector(refreshAction)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.refresh scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.refresh scrollViewDidEndDragging];
}

- (void)refreshAction {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refresh finish];
    });
}

@end
