//
//  ViewController.m
//  父子控制器
//
//  Created by huangbiyong on 2017/11/30.
//  Copyright © 2017年 com.chase. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "ProfileViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *titleContraintView;
@property (weak, nonatomic) IBOutlet UIView *contentContraintView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 开发规划:如果A控制器的view添加到B控制器的view上,那么A控制器必须成为B控制器的子控制器
    // addSubview:把一个view加上去,先判断下这个view有没有父控件,如果有,会拿到这个view,先从父控件移除,在添加
    
    // 设置子控制器
    [self setupViewControllers];
    
    [self setupButtions];
}

- (void)setupViewControllers {
    
    HomeViewController *homeVCS = [[HomeViewController alloc]init];
    homeVCS.title = @"首页";
    [self addChildViewController:homeVCS];
    //如果不添加，homeVCS将被销毁只留下homeVCS.view，无法在HomeViewController 中的处理逻辑，HomeViewController控制器的相关方法不起作用
    
    
    SearchViewController *searchVCS = [[SearchViewController alloc]init];
    searchVCS.title = @"搜索";
    [self addChildViewController:searchVCS];
    
    
    ProfileViewController *profileVCS = [[ProfileViewController alloc]init];
    profileVCS.title = @"个人";
    [self addChildViewController:profileVCS];
}

//设置按钮的内容
- (void)setupButtions {
    NSInteger count = self.titleContraintView.subviews.count;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = self.titleContraintView.subviews[i];
        UIViewController *vcs = self.childViewControllers[i];
        [btn setTitle:vcs.title forState:UIControlStateNormal];
    }
}



- (IBAction)didClick:(UIButton*)sender {
    
    // addSubview:把一个view加上去,先判断下这个view有没有父控件,如果有,会拿到这个view,先从父控件移除,在添加
    // 所以 self.contentContraintView 最大只有三个子试图， 因为每次添加都会查找有没有父控件， 然后移除再添加
    
    UIViewController *vcs = self.childViewControllers[sender.tag];
    vcs.view.backgroundColor = sender.backgroundColor;
    vcs.view.frame = self.contentContraintView.bounds;
    [self.contentContraintView addSubview:vcs.view];
}




@end
