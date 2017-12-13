           //
//  VudioViewController.m
//  本地相册和视频
//
//  Created by 张杰 on 2016/10/21.
//  Copyright © 2016年 张杰. All rights reserved.
//

#import "VudioViewController.h"
@interface VudioViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *underline;
@property (nonatomic, strong) UIButton *slidingBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger statusInt;
@property (nonatomic, strong) NSString *status;
@end

@implementation VudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的预约";
    [self showTableView:100];
    [self initView];
}

- (void)initView {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.bgView];
    NSArray *arr = [NSArray arrayWithObjects:@"已预约", @"已完成", @"已过期", @"已取消", nil];
    for (NSInteger i = 0; i < 4; i++) {
        self.slidingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.slidingBtn.backgroundColor = [UIColor whiteColor];
        self.slidingBtn.frame = CGRectMake((self.bgView.frame.size.width/4)*i, 0, self.bgView.frame.size.width/4, self.bgView.frame.size.height);
        self.slidingBtn.tag = 100+i;
        [self.slidingBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [self.slidingBtn setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState: UIControlStateNormal];
        [self.slidingBtn addTarget:self action:@selector(sliding:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:self.slidingBtn];
        
    }
    [self.bgView addSubview:self.underline];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        _bgView.layer.borderWidth = 1;
        _bgView.layer.masksToBounds = YES;
        // _bgView.userInteractionEnabled = YES;
       // _bgView.layer.borderColor = COLOR_BianKuang.CGColor;
    }
    return _bgView;
}

- (UILabel *)underline {
    if (!_underline) {
        _underline = [[UILabel alloc]initWithFrame:CGRectMake(0,self.bgView.frame.size.height-5,self.bgView.frame.size.width/4, 3)];
        //_underline.backgroundColor = clickColor;
    }
    return _underline;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10,50, self.view.frame.size.width-20, self.view.frame.size.height)];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*4, self.view.frame.size.height);
        _scrollView.pagingEnabled = YES;
        // _scrollView.userInteractionEnabled = YES;
        _scrollView.directionalLockEnabled = YES;
    }
    return _scrollView;
}

- (void)sliding:(UIButton *)sender {
    [self showTableView:sender.tag];
}

- (void)showTableView:(NSInteger)tag {
    self.underline.frame = CGRectMake((self.bgView.frame.size.width/4)*(tag-100), 45, self.bgView.frame.size.width/4, 3);
    [self.scrollView setContentOffset:CGPointMake(self.bgView.frame.size.width*(tag-100),0)animated:YES];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.bgView.frame.size.width*(tag-100), 50, self.view.frame.size.width,self.view.frame.size.height-58-64) style:UITableViewStylePlain];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    //self.tableView.userInteractionEnabled = YES;
    //定义显示默认cell的横线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    self.tableView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.textLabel.text = @"1111";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    id params = @{@"orderUuid":[NSString stringWithFormat:@"%@",self.responseOutpatientOrderlist.data[indexPath.section].orderUuid]};
//    [[PageManager shareInstance]gotoPage:[HDYuYueInfoViewController new] withParams:params];
    NSLog(@"222");
}

@end
