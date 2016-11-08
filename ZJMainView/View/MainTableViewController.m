//
//  MainTableViewController.m
//  ZJMainView
//
//  Created by LYY on 2016/10/20.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@property (nonatomic,strong)NSMutableArray *mList;

@end
static NSString *cells = @"identifier";
@implementation MainTableViewController

- (NSMutableArray *)mList {
    if (_mList == nil) {
        _mList = [NSMutableArray array];
        [_mList addObjectsFromArray:@[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"]];
    }
    return _mList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cells];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:cells forIndexPath:indexPath];
    }
    
    cell.textLabel.text = self.mList[indexPath.row];
    
    return cell;
}




@end
