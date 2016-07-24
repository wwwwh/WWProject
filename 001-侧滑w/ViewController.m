//
//  ViewController.m
//  001-侧滑w
//
//  Created by ios on 16/6/7.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "ViewController.h"
#import "CZSidesCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate,CZSidesCelldelegate>

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataPlist;

@end

@implementation ViewController

-(NSMutableArray *)dataPlist{
    if (_dataPlist == nil) {
        _dataPlist = [NSMutableArray array];
        for (NSInteger i = 0; i<20; i++) {
            NSString *str = [NSString stringWithFormat:@"第%zd行数据",i];
            [_dataPlist addObject:str];
        }
    }
    return _dataPlist;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:tableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataPlist.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CZSidesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CZSidesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.conentLabel.text = self.dataPlist[indexPath.row];
    cell.number = indexPath.row;
    cell.delegate = self;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;

}
-(void)CZSidesCellremoveData:(CZSidesCell *)cell withNumber:(NSInteger)number{

    [self.dataPlist removeObjectAtIndex:number];
    [self.tableView reloadData];

}

-(void)CZSidesCellsetData:(CZSidesCell *)cell withNumber:(NSInteger)number{
    
    NSString *str = @"哈哈哈哈";
    [self.dataPlist insertObject:str atIndex:number];
    [self.tableView reloadData];

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSArray *cells = [self.tableView visibleCells];
    for (CZSidesCell *cell in cells) {
        [UIView animateWithDuration:1 animations:^{
        
            cell.scrollView.contentOffset = CGPointZero;
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
