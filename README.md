## 效果图
![2017-12-01 09_53_43.gif](http://upload-images.jianshu.io/upload_images/9242195-dfb02e32a279399b.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
## 原理
与系统的UITabBarController类似，现实自定义的类似功能，采用父子控制器架构来管理；
- 开发规划:如果A控制器的view添加到B控制器的view上,那么A控制器必须成为B控制器的子控制器；

- addSubview:把一个view加上去,先判断下这个view有没有父控件,如果有,会拿到这个view,先从父控件移除,在添加
## 步骤
1. 在main.storyboard中，使用两个UIView,一个原来头部的button ，另一个用来管理UIViewController子控制器
2. 然后在头部的view添加三个button,也可以用代码来生成；

![image](http://upload-images.jianshu.io/upload_images/9242195-ce619db2d964bb84.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3. 创建首页，搜索，个人，三个UIViewController，并使用addChildViewController添加到self中；
```
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
```
4. 为头部试图的button 分别添加文字，使用遍历控制器来实现;
```
//设置按钮的内容
- (void)setupButtions {
    NSInteger count = self.titleContraintView.subviews.count;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = self.titleContraintView.subviews[i];
        UIViewController *vcs = self.childViewControllers[i];
        [btn setTitle:vcs.title forState:UIControlStateNormal];
    }
}

```
5. 在viewDidLoad调用setupViewControllers， setupButtions 方法；
```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 开发规划:如果A控制器的view添加到B控制器的view上,那么A控制器必须成为B控制器的子控制器
    // addSubview:把一个view加上去,先判断下这个view有没有父控件,如果有,会拿到这个view,先从父控件移除,在添加
    
    // 设置子控制器
    [self setupViewControllers];
    
    [self setupButtions];
}
```
6. 为button 添加点击方法，点击时，切换控制器的view，达到切换控制器的效果;
```
- (IBAction)didClick:(UIButton*)sender {
    
    // addSubview:把一个view加上去,先判断下这个view有没有父控件,如果有,会拿到这个view,先从父控件移除,在添加
    // 所以 self.contentContraintView 最大只有三个子试图， 因为每次添加都会查找有没有父控件， 然后移除再添加
    
    UIViewController *vcs = self.childViewControllers[sender.tag];
    vcs.view.backgroundColor = sender.backgroundColor;
    vcs.view.frame = self.contentContraintView.bounds;
    [self.contentContraintView addSubview:vcs.view];
}

```

