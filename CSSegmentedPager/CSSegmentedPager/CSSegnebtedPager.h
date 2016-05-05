//
//  CSSegnebtedPager.h
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/25.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSSegnebtedPager;


@protocol CSSegnebtedPagerDelegate <NSObject>

@optional

//代理方法，返回选中的index
-(void)SegnebtedPager:(CSSegnebtedPager *)SegnebtedPager didSelectIndex:(int)index;

@end



@interface CSSegnebtedPager : UIScrollView

@property (nonatomic ,weak)id <CSSegnebtedPagerDelegate>delegate;


//字体大小
@property (nonatomic,strong) UIFont *titleFont;

//按钮之间的间距
@property (nonatomic,assign) int spacing;

//字体颜色
@property (nonatomic,strong) UIColor *titleColor;

//选中状态字体颜色
@property (nonatomic,strong) UIColor *selectedTitleColor;

//横线颜色
@property (nonatomic,strong) UIColor *selectedViewColor;

//横线高度
@property (nonatomic,assign) int selectedViewHighly;

//很闲移动速度(秒)
@property (nonatomic,assign) CGFloat selectedViewMovementSpeed;

//增加左右两边的额外滚动范围
@property (nonatomic,assign) UIEdgeInsets edgeInsets;


-(id)initWithTitles:(NSArray *)titles;

@end
