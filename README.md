# CSSegmentedPager
集成方便、扩展性高的分段选择类

![image](https://raw.githubusercontent.com/1733492644/CSSegmentedPager/master/Untitled.gif)
# 使用说明
    #import "CSSegnebtedPager.h"
    @interface ViewController ()<CSSegnebtedPagerDelegate>
    @end

    @implementation ViewController

    - (void)viewDidLoad {
        [super viewDidLoad];
    
        self.navigationController.navigationBar.translucent = NO;
    
        CSSegnebtedPager *segnebtedPager = [[CSSegnebtedPager alloc]initWithTitles:@[@"新闻",@"动态",@"动漫",@"电视剧",@"小说",@"朋友圈",@"资讯",@"电影",@"军事",@"朋友"]];
        segnebtedPager.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
        [self.view addSubview:segnebtedPager];
        segnebtedPager.delegate = self;
    
    }

    -(void)SegnebtedPager:(CSSegnebtedPager *)SegnebtedPager didSelectIndex:(int)index
    {
         NSLog(@"点击了第%d个位置",index);
    }
#自定义样式
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
    //横线移动速度(秒)
    @property (nonatomic,assign) CGFloat selectedViewMovementSpeed;
    //增加左右两边的额外滚动范围
    @property (nonatomic,assign) UIEdgeInsets edgeInsets;
