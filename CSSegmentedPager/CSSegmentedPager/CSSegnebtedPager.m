//
//  CSSegnebtedPager.m
//  XHHospital
//
//  Created by 徐呈赛 on 16/3/25.
//  Copyright © 2016年 XuhuiCompany. All rights reserved.
//

#import "CSSegnebtedPager.h"
#import "CSPagerBtn.h"
#import "UIView+Extension.h"

@interface CSSegnebtedPager ()<UIScrollViewDelegate>


//按钮下面的横杆
@property (nonatomic,weak) UIView *selectedView;

//临时保存的数组
@property (nonatomic,strong) NSArray *titles;

//临时按钮
@property (nonnull,strong)  CSPagerBtn *selectedBtn;

//保存临时X值
@property (nonatomic,assign) CGFloat temporaryX;

@property (nonatomic,assign) int index;

@property (nonatomic,assign) BOOL temporaryVariable;






@end


@implementation CSSegnebtedPager




-(id)initWithTitles:(NSArray *)titles
{

    if (self = [super init]) {
        
        
        UIView *selectedView = [[UIView alloc]init];
        [self addSubview: selectedView];
        self.selectedView = selectedView;
        selectedView.backgroundColor = [UIColor orangeColor];
        
        
        
        
        self.backgroundColor = [[UIColor alloc]initWithRed:0/255.0 green:188/255.0 blue:212/255.0 alpha:1];
        self.titles = titles;
        self.titleFont = [UIFont systemFontOfSize:16];
        self.spacing = 30;
        self.titleColor = [[UIColor alloc]initWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        self.selectedTitleColor =  [UIColor whiteColor];
        
        //去除水平方向的滚动条
        self.showsHorizontalScrollIndicator = NO;
        //去除垂直方向的滚动条
        self.showsVerticalScrollIndicator = NO;
        
        
        
        
        //设置额外的滚动区域
        self.contentInset = UIEdgeInsetsMake(0, 50, 0, 50);
        
        
        self.delegate = self;
        
        
        
    }
    return self;

}


//设置额外的滚动区域
-(void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    
    self.contentInset = edgeInsets;
}

-(void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
    
 

    for (int i = 0; i < self.titles.count; i++) {
        
        CSPagerBtn *btn = [[CSPagerBtn alloc]init];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        btn.titleLabel.font = self.titleFont;
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        [self addSubview:btn];
        
        if (i == 0) {
            
            //[self btnClick:btn];
        }
        
        
    }
    
}















-(void)btnClick:(UIButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = (CSPagerBtn *)btn;
    
    
    
    
    
    if (self.temporaryVariable == NO) {
        
        
        self.selectedView.width = btn.width;
        self.selectedView.x = btn.x;
        
    }else{
    
    
        [UIView animateWithDuration:self.selectedViewMovementSpeed animations:^{
            self.selectedView.width = btn.width;
            self.selectedView.x = btn.x;
        }];
        
    }
    
    
    
   
    
    if (btn.centerX < self.width * 0.5 - self.contentInset.left) {
        
      
        
        [self setContentOffset:CGPointMake(btn.x - btn.x - self.contentInset.left, 0) animated:YES];
        
    }else if (btn.centerX > (self.contentSize.width - self.width * 0.5 + self.contentInset.right)){
    
        [self setContentOffset:CGPointMake(self.contentSize.width - self.width + self.contentInset.left, 0) animated:YES];
        
        
    }else{
    
        [self setContentOffset:CGPointMake(btn.centerX - self.width * 0.5, 0) animated:YES];
    }
    
    

    //调用代理方法
    if ([self.delegate respondsToSelector:@selector(SegnebtedPager:didSelectIndex:)]) {
        [self.delegate SegnebtedPager:self didSelectIndex:btn.tag];
    }
    
    
 
  
}




-(void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)view;
            btn.titleLabel.font = titleFont;
        }
    }
    
    [self setNeedsLayout];
}



-(void)setSpacing:(int)spacing
{
    _spacing = spacing;
    [self setNeedsLayout];
}

-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)view;
            [btn setTitleColor:titleColor forState:UIControlStateNormal];
        }
    }
    
}

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    _selectedTitleColor = selectedTitleColor;
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)view;
            [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
        }
    }
}


-(void)setSelectedViewColor:(UIColor *)selectedViewColor
{
    _selectedViewColor = selectedViewColor;
    
    self.selectedView.backgroundColor = selectedViewColor;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.selectedView.height = self.selectedViewHighly ? self.selectedViewHighly : 3;
    self.selectedView.y = self.height - self.selectedView.height;
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            if (self.index >= self.titles.count) {
                self.index = 0;
                self.temporaryX = 0;
            }
            
            
            UIButton *btn = (UIButton *)view;
            
            btn.y = 0;
            btn.height = self.height;
            btn.width = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleFont}].width + self.spacing;
        
            
                btn.x = self.temporaryX;
                self.temporaryX += btn.width;
         
            
            self.index++;
            
            
            if (self.index == self.titles.count) {
                
                //设置可视范围
                self.contentSize = CGSizeMake(btn.x + btn.width, 0);
                
            }
            
            if (self.temporaryVariable == NO) {
                
                if (btn.tag == 0) {
                    
                    [self btnClick:btn];
                }
               
                
            }
            
        }
    }
    
    
   
    
    self.temporaryVariable = YES;
}




@end
