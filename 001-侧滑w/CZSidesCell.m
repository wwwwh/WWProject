//
//  CZSidesCell.m
//  001-侧滑w
//
//  Created by ios on 16/6/7.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "CZSidesCell.h"

#define WHColor(R,G,B) [UIColor colorWithRed:(R) / 255.0  green:(G) / 255.0 blue:(B) / 255.0 alpha:1]
#define WHRandomColor WHColor(arc4random_uniform(255.0) ,arc4random_uniform(255.0),arc4random_uniform(255.0))

#define screenW [UIScreen mainScreen].bounds.size.width
#define cellHeight 80

@interface CZSidesCell ()<UIScrollViewDelegate>
//@property (weak, nonatomic) UIScrollView *scrollView;

@property (weak, nonatomic) UIView *btnView;
@property (weak, nonatomic) UIView *conentView;

@property (weak, nonatomic) UIView *shareView;

@end

@implementation CZSidesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenW, cellHeight)];
        scrollView.backgroundColor = [UIColor redColor];
        self.scrollView = scrollView;
        self.scrollView.delegate = self;
        [self.contentView addSubview:scrollView];
        //创建盛放按钮视图
        UIView *btnView = [[UIView alloc]init];
        CGFloat btnViewW = cellHeight *3;
        CGFloat btnViewH = cellHeight;
        CGFloat btnViewX = screenW -btnViewW;
        CGFloat btnViewY = 0;
        btnView.frame = CGRectMake(btnViewX, btnViewY, btnViewW, btnViewH);
        //按钮个数跟宽高
        NSInteger btuCount = 3;
        CGFloat btnW = cellHeight;
        CGFloat btnH = btnW;
        
        NSArray *btnColor = @[[UIColor lightGrayColor],[UIColor blueColor],[UIColor yellowColor]];
        NSArray *btnText = @[@"移除",@"新建",@"分享"];
        
        for (NSInteger i = 0; i<btuCount; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnW, 0, btnW, btnH)];
            [btn setTitle:btnText[i] forState:UIControlStateNormal];
            btn.backgroundColor = btnColor[i];
            [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            [btnView addSubview:btn];
         }
        self.btnView = btnView;
        [self.scrollView addSubview:btnView];
        //创建内容视图
        UIView *conentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, cellHeight)];
        conentView.backgroundColor = WHRandomColor;
        self.conentView = conentView;
        
        UILabel *conentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, screenW - 20, cellHeight - 20)];
        conentLabel.backgroundColor = [UIColor yellowColor];
        self.conentLabel = conentLabel;
        [conentView addSubview:conentLabel];
        [self.scrollView addSubview:conentView];
        self.scrollView.contentSize = CGSizeMake(screenW + self.btnView.frame.size.width, 0);
        
    }
    return self;
}
//分享视图的创建
-(UIView *)shareView{
    if (_shareView == nil) {
        UIView *shareView = [[UIView alloc]initWithFrame:CGRectMake(screenW, 0, screenW, cellHeight)];
        CGFloat btnW = screenW/4;
        CGFloat btnH = cellHeight;
        
        NSArray *array = @[@"新浪",@"百度",@"猫扑",@"网易"];
        for (NSInteger i = 0; i< array.count; i ++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(btnW * i, 0, btnW, btnH)];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor lightGrayColor];
            [btn addTarget:self action:@selector(shareViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [shareView addSubview:btn];
        }
        _shareView = shareView;
        [self.contentView addSubview:shareView];
    }

    return _shareView;
}
//按钮视图的Button的点击方法
-(void)clickButton:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"移除"]) {
        [self removeData];
    }
   else if ([sender.titleLabel.text isEqualToString:@"新建"]) {
        [self setData];
    }
    
   else {
        [self shareData];
    }
    

}
//移除按钮点击
-(void)removeData{
    
    [UIView animateWithDuration:1 animations:^{
        self.scrollView.contentOffset = CGPointZero;
    }];
    if ([self.delegate respondsToSelector:@selector(CZSidesCellremoveData:withNumber:)]) {
        [self.delegate CZSidesCellremoveData:self withNumber:self.number];
    }


}
//新建按钮的点击
-(void)setData{
    [UIView animateWithDuration:1 animations:^{
        self.scrollView.contentOffset = CGPointZero;
    }];
    if ([self.delegate respondsToSelector:@selector(CZSidesCellsetData:withNumber:)]) {
        [self.delegate CZSidesCellsetData:self withNumber:self.number];
    }

}
//分享按钮的点击
-(void)shareData{
    UIView *shareView = self.shareView;
    [UIView animateWithDuration:1 animations:^{
        shareView.frame = CGRectMake(0, 0, screenW, cellHeight);
    }];

}
//分享视图上按钮的点击方法
-(void)shareViewButtonClick:(UIButton *)sender{
    [UIView animateWithDuration:1 animations:^{
        self.scrollView.contentOffset = CGPointZero;
        self.shareView.frame = CGRectMake(screenW, 0, screenW, cellHeight);
    }];

}
//实现scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.btnView.transform = CGAffineTransformMakeTranslation(self.scrollView.contentOffset.x, 0);
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.x < self.btnView.bounds.size.width/2 ) {
        scrollView.contentOffset = CGPointZero;
    }
    else{
        scrollView.contentOffset = CGPointMake(self.btnView.bounds.size.width,0);
        self.btnView.transform = CGAffineTransformMakeTranslation(self.scrollView.contentOffset.x, 0);
    }

}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
