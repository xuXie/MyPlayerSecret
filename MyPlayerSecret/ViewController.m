//
//  ViewController.m
//  MyPlayerSecret
//
//  Created by xu xie on 12-4-27.
//  Copyright (c) 2012年 yek.me. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation ViewController
- (id)initWithDefaultViewControllers{
    FirstViewController* _viewCtrl_1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    SecondViewController* _viewCtrl_2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    
    
    UINavigationController* _navCtrl_1 = [[UINavigationController alloc] initWithRootViewController:_viewCtrl_1];	
    UINavigationController* _navCtrl_2 = [[UINavigationController alloc] initWithRootViewController:_viewCtrl_2];
    
    [_viewCtrl_1 release];
    [_viewCtrl_2 release];
    
    NSArray* _array_viewCtrl = [NSArray arrayWithObjects:
                                _navCtrl_1, _navCtrl_2, nil];
    
    [_navCtrl_1 release];
    [_navCtrl_2 release];
    
    // 设置图片
    NSMutableDictionary* imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic setObject:[UIImage imageNamed:@"TabBar_1.png"] forKey:@"Default"];
    [imgDic setObject:[UIImage imageNamed:@"TabBar_1_SEL.png"] forKey:@"Seleted"];
    
    NSMutableDictionary* imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
    [imgDic2 setObject:[UIImage imageNamed:@"TabBar_2.png"] forKey:@"Default"];
    [imgDic2 setObject:[UIImage imageNamed:@"TabBar_2_SEL.png"] forKey:@"Seleted"];
    
    NSMutableDictionary* imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic3 setObject:[UIImage imageNamed:@"TabBar_3.png"] forKey:@"Default"];
	[imgDic3 setObject:[UIImage imageNamed:@"TabBar_3_SEL.png"] forKey:@"Seleted"];
	
	NSMutableDictionary* imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic4 setObject:[UIImage imageNamed:@"TabBar_4.png"] forKey:@"Default"];
	[imgDic4 setObject:[UIImage imageNamed:@"TabBar_4_SEL.png"] forKey:@"Seleted"];
	
	NSMutableDictionary* imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic5 setObject:[UIImage imageNamed:@"TabBar_5.png"] forKey:@"Default"];
	[imgDic5 setObject:[UIImage imageNamed:@"TabBar_5_SEL.png"] forKey:@"Seleted"];
	
	NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,nil];
    
    CGFloat tabbarheight = [UIImage imageNamed:@"TabBar_1.png"].size.height;
    if (self) {
        
        self = [super initWithViewControllers:_array_viewCtrl imageArray:imgArr withHeight:tabbarheight];
//        NSMutableArray *l_array = [[NSMutableArray alloc] initWithObjects:
//                                   [NSNumber numberWithFloat:(29.0f-135.0)],
//                                   [NSNumber numberWithFloat:(94.0f-135.0)],
//                                   [NSNumber numberWithFloat:(158.0f-135.0)],
//                                   [NSNumber numberWithFloat:(221.0f-135.0)],
//                                   [NSNumber numberWithFloat:(286.0f-135.0)], nil];
//        self.array_tabBarX = l_array;
//        [l_array release];
        [self setTabBarTransparent:YES];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma -
#pragma mark 创建tabbar视图
-(void)createTabBarView{
    // 5个主页
	
}
@end
