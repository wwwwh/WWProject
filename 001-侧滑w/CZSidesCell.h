//
//  CZSidesCell.h
//  001-侧滑w
//
//  Created by ios on 16/6/7.
//  Copyright © 2016年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZSidesCell;

@protocol CZSidesCelldelegate <NSObject>

-(void)CZSidesCellremoveData:(CZSidesCell *)cell withNumber:(NSInteger) number;

-(void)CZSidesCellsetData:(CZSidesCell *)cell withNumber:(NSInteger) number;


@end


@interface CZSidesCell : UITableViewCell

@property (weak, nonatomic) UILabel *conentLabel;
@property (weak, nonatomic) id<CZSidesCelldelegate>delegate;

@property (assign, nonatomic) NSInteger number;

@property (weak, nonatomic) UIScrollView *scrollView;

@end
