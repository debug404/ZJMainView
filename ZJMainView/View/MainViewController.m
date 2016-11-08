//
//  MainViewController.m
//  ZJMainView
//
//  Created by LYY on 2016/10/20.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewController.h"
#import "LeftViewController.h"

#define LEFT_WIDTH 300 //左侧宽度
#define NAV_HIGHT 64  //顶部高度
#define PHOTO_HIGHT 150 //图片高度
#define FUN_HIGHT 60 //图片高度

#define kScreenHeight CGRectGetHeight([[UIScreen mainScreen] bounds])
#define kScreenWidth  CGRectGetWidth([[UIScreen mainScreen] bounds])

@interface MainViewController ()<UIScrollViewDelegate> {
    UIView *navBar;
    UIView *centerView;
    UIImageView *imgView;
    UIView *functionView;
}

@property (nonatomic,strong)UIScrollView *rootScrollView;
@property (nonatomic,strong)UIScrollView *mainScrollView;

@property (nonatomic,strong)MainTableViewController *mainTableView;
@property (nonatomic,strong)LeftViewController *leftTableView;


@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadScroll];
    [self loadLeftView];
    [self loadImageView];
    [self loadNavbarView];
    [self loadCenterView];
    [self loadFunctionView];
    [self loadTableView];
    
}


- (void)loadScroll {
    
    [self.view addSubview:self.rootScrollView];
    [self.rootScrollView setBackgroundColor:[UIColor grayColor]];
    self.rootScrollView.contentOffset = CGPointMake(LEFT_WIDTH, 0);
    
}

- (void)loadImageView {
    imgView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    imgView.frame = CGRectMake(LEFT_WIDTH, NAV_HIGHT, kScreenWidth, PHOTO_HIGHT);
    [self.rootScrollView addSubview:imgView];
    
}


- (void)loadNavbarView {
    
    navBar = [[UIView alloc] initWithFrame:CGRectMake(LEFT_WIDTH, 0, kScreenWidth, NAV_HIGHT)];
    [navBar setBackgroundColor:[UIColor redColor]];
    [self.rootScrollView addSubview:navBar];
    

}

- (void)loadCenterView {
    
    
}


- (void)loadFunctionView {
    
    functionView = [[UIView alloc] initWithFrame:CGRectMake(LEFT_WIDTH, NAV_HIGHT + PHOTO_HIGHT, kScreenWidth, FUN_HIGHT)];
    [functionView setBackgroundColor:[UIColor grayColor]];
    [self.rootScrollView addSubview:functionView];
    
}

- (void)loadTableView {
    [self.rootScrollView addSubview:self.mainTableView.view];
    
    
    [self.rootScrollView addSubview:self.mainScrollView];
    [self.mainScrollView setBackgroundColor:[UIColor blackColor]];
    self.mainScrollView.alpha = 0.2;
    self.mainScrollView.userInteractionEnabled = NO;
    [self.mainTableView.view addGestureRecognizer:self.mainScrollView.panGestureRecognizer];
    
    
    
}

- (void)loadLeftView {
    [self.rootScrollView addSubview:self.leftTableView.view];
    [self.leftTableView.view setBackgroundColor:[UIColor purpleColor]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float y = scrollView.contentOffset.y;
    float x = scrollView.contentOffset.x;
    
    if (scrollView == self.mainScrollView) {
       
        if (y>0 && y< PHOTO_HIGHT) {
            [self scrollAdaptNum:y];
        }
        
        if (y <= 0) {
            [self scrollAdaptNum:0];
            self.mainTableView.tableView.contentOffset = CGPointMake(0,y);
        }
        if (y >= PHOTO_HIGHT) {
            [self scrollAdaptNum:PHOTO_HIGHT];
             self.mainTableView.tableView.contentOffset = CGPointMake(0,y - PHOTO_HIGHT);
        }
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float y = scrollView.contentOffset.y;
    float x = scrollView.contentOffset.x;
    
    if (scrollView == self.rootScrollView) {
        
        
        if (x < LEFT_WIDTH/2) {
            self.rootScrollView.contentOffset = CGPointMake(0, 0);
        }
        
        
        if (x > LEFT_WIDTH/2) {
            self.rootScrollView.contentOffset = CGPointMake(LEFT_WIDTH, 0);
        }
        
        
    }
    
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    float y = scrollView.contentOffset.y;
    float x = scrollView.contentOffset.x;
    
    if (scrollView == self.rootScrollView) {
        
        
        if (x < LEFT_WIDTH/2) {
            
            [UIView animateWithDuration:0.5 animations:^{
                self.rootScrollView.contentOffset = CGPointMake(0, 0);
            }];
            
        }
        
        
        if (x > LEFT_WIDTH/2) {
            [UIView animateWithDuration:0.5 animations:^{
                self.rootScrollView.contentOffset = CGPointMake(LEFT_WIDTH, 0);
            }];
        }
        
        
    }
    
    
    if (scrollView == self.mainScrollView) {
    
        if (y < PHOTO_HIGHT/2) {
            
            [UIView animateWithDuration:0.5 animations:^{
                self.mainScrollView.contentOffset = CGPointMake(0, 0);
            }];
            
        }
        
        
        if (y > PHOTO_HIGHT/2) {
            [UIView animateWithDuration:0.5 animations:^{
                self.mainScrollView.contentOffset = CGPointMake(LEFT_WIDTH, 0);
            }];
        }

    
    }
    
    
}


- (void)scrollAdaptNum:(int)y {
    
    CGRect frame = CGRectMake(LEFT_WIDTH, NAV_HIGHT + PHOTO_HIGHT + FUN_HIGHT, kScreenWidth, kScreenHeight - NAV_HIGHT - PHOTO_HIGHT - FUN_HIGHT);
    frame.size.height = frame.size.height + y;
    frame.origin.y = frame.origin.y - y;
    self.mainTableView.view.frame = frame;
    
    frame = CGRectMake(LEFT_WIDTH, NAV_HIGHT + PHOTO_HIGHT, kScreenWidth, FUN_HIGHT);
    frame.origin.y = frame.origin.y - y;
    functionView.frame = frame;
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.rootScrollView) {
        [scrollView setContentOffset:scrollView.contentOffset animated:NO];
    }
    
}


- (UIScrollView *)rootScrollView {
    
    if (_rootScrollView == nil) {
        _rootScrollView = [[UIScrollView alloc] init];
        _rootScrollView.contentSize = CGSizeMake(kScreenWidth + LEFT_WIDTH, 0);
        _rootScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _rootScrollView.bounces = NO;
        _rootScrollView.delegate = self;
    }
    return _rootScrollView;
    
}
- (UIScrollView *)mainScrollView {
    
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] init];
        
        _mainScrollView.frame = CGRectMake(LEFT_WIDTH, NAV_HIGHT + PHOTO_HIGHT + FUN_HIGHT, kScreenWidth, kScreenHeight - NAV_HIGHT - PHOTO_HIGHT - FUN_HIGHT);
        _mainScrollView.contentSize = CGSizeMake(0, kScreenHeight - NAV_HIGHT - PHOTO_HIGHT - FUN_HIGHT + PHOTO_HIGHT);
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
    
}
- (MainTableViewController *)mainTableView {
    
    if (_mainTableView == nil) {
        _mainTableView = [[MainTableViewController alloc] init];
        _mainTableView.view.frame = CGRectMake(LEFT_WIDTH, NAV_HIGHT + PHOTO_HIGHT + FUN_HIGHT, kScreenWidth, kScreenHeight - NAV_HIGHT - PHOTO_HIGHT - FUN_HIGHT);
    }
    return _mainTableView;
    
}
- (LeftViewController *)leftTableView {
    
    if (_leftTableView == nil) {
        _leftTableView = [[LeftViewController alloc] init];
        _leftTableView.view.frame = CGRectMake(0, 0, LEFT_WIDTH, kScreenHeight);
    }
    return _leftTableView;
}

@end
