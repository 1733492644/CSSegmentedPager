//
//  ViewController.m
//  CSSegmentedPager
//
//  Created by 徐呈赛 on 16/5/5.
//  Copyright © 2016年 XuChengSai. All rights reserved.
//

#import "ViewController.h"
#import "CSSegnebtedPager.h"

@interface ViewController ()<CSSegnebtedPagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    ///
    //
    CSSegnebtedPager *segnebtedPager = [[CSSegnebtedPager alloc]initWithTitles:@[@"新闻",@"动态",@"动漫",@"电视剧",@"小说",@"朋友圈",@"资讯",@"电影",@"军事",@"朋友"]];
    segnebtedPager.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    [self.view addSubview:segnebtedPager];
    segnebtedPager.delegate = self;
    
    
    
    
}

-(void)SegnebtedPager:(CSSegnebtedPager *)SegnebtedPager didSelectIndex:(int)index
{
    NSLog(@"点击了第%d个位置",index);
}
@end
