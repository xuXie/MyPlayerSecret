//
//  LeveyTabBarControllerViewController.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import "LeveyTabBarController.h"
#import "LeveyTabBar.h"
#import <mach/mach.h>
#import <mach/mach_time.h>

static LeveyTabBarController *leveyTabBarController;

@implementation UIViewController (LeveyTabBarControllerSupport)

- (LeveyTabBarController *)leveyTabBarController
{
	return leveyTabBarController;
}

- (void)setLeveyTabBarController:(LeveyTabBarController *)tabbar
{
    
}

@end

@interface UITranstNaviView : UIView
+(NSTimeInterval)systemUptime;
@end

@implementation UITranstNaviView

+(NSTimeInterval)systemUptime
{
	// get the timebase info -- different on phone and OSX
    mach_timebase_info_data_t info;
    mach_timebase_info(&info);
	
    // get the time
    uint64_t absTime = mach_absolute_time();
	
    // apply the timebase info
    absTime *= info.numer;
    absTime /= info.denom;
	
    // convert nanoseconds into seconds and return
    return (NSTimeInterval) ((double) absTime / 1000000000.0);
}

static CGPoint oldTranstPoint;

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	NSTimeInterval system = [[self class] systemUptime];
	
	CGPoint nowpoint = point;
	if (system - event.timestamp < 0.1 && [[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2)
	{
		nowpoint = oldTranstPoint;
	}
	oldTranstPoint = point;
	
	if ([self pointInside:nowpoint withEvent:event])
	{
		for (UIView* vi in self.subviews) 
		{		
			CGPoint realpoint = [self convertPoint:nowpoint toView:vi];
			UIView* realview = [vi hitTest:realpoint withEvent:event];
			if (realview)
			{
				return realview;
			}
		}
		return self;
	}
	
	return nil;
}

@end

@implementation LeveyTabBarController
//@synthesize tabBar = _tabBar;
@synthesize delegate = _delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize viewControllers = _viewControllers;
@synthesize imageArray = _imageArray;
@synthesize tabBarHidden = _tabBarHidden;
@synthesize tabBarArrowImage = _tabBarArrowImage;
@synthesize array_tabBarX = _array_tabBarX;
@synthesize tabBarHeight;
@synthesize tabBarTransOffset;
@synthesize mfontHeight;

#pragma mark -
#pragma mark lifecycle
- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr withHeight:(float)height;
{
	return [self initWithViewControllers:vcs imageArray:arr withHeight:height withFontHeight:13];
}

- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr withHeight:(float)height withFontHeight:(float)fontheight
{
	self = [super init];
	if (self != nil)
	{
		tabBarHeight = height;
		self.viewControllers = vcs;
		self.imageArray = arr;
		mfontHeight = fontheight;
		
		_containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
		[self createViewIfNeed];
	}
	return self;
}

- (void)loadView 
{
	[super loadView];
	
	self.view = _containerView;
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	[self createViewIfNeed];
	
	self.tabBarTransparent = _tabBarTransparent;
	[self hidesTabBar:_tabBarHidden animated:NO];
	
	[self addViewToContainer];
	int curindex = self.selectedIndex;
	
	if (curindex >= 0 && curindex <= 5)
	{
		//内存警告重置
		self.selectedIndex = curindex;
	}
	else
	{
		//第一次初始化
		self.selectedIndex = 0;
	}

}

-(void)createViewIfNeed
{
	//==================
	CGRect contentrect = [[UIScreen mainScreen] applicationFrame];
	_containerView.frame = contentrect;
	
	if (!_transitionView)
	{
		_transitionView = [[UITranstNaviView alloc] initWithFrame:CGRectZero];
		_transitionView.backgroundColor =  [UIColor clearColor];
		[_containerView addSubview:_transitionView];
	}
	
	
	//tabbar
	if (!_tabBar)
	{
		_tabBar = [[LeveyTabBar alloc] initWithFrame:CGRectMake(0, contentrect.size.height - tabBarHeight, 320.0f, tabBarHeight) buttonImages:self.imageArray withFontHeight:mfontHeight];
		_tabBar.delegate = self;
		[_containerView addSubview:_tabBar];
	}
	
}

-(void)addViewToContainer
{
	[_containerView addSubview:_transitionView];
	[_containerView addSubview:_tabBar];
    
    for (UIViewController* vc in self.viewControllers) 
	{
		[vc.view setFrame:self.view.bounds];
        [_transitionView addSubview:vc.view];
    }
}

- (void)viewDidUnload
{
	[super viewDidUnload];
}


- (void)dealloc 
{
	[_tabBar release];
	[_transitionView release];
	
	[_viewControllers release];
	[_tabBarArrowImage release];
	[_array_tabBarX release];
    [super dealloc];
}
#pragma mark -
#pragma mark methods
- (LeveyTabBar *)tabBar
{
	return _tabBar;
}
- (BOOL)tabBarTransparent
{
	if (self.tabBarHidden) {
		return YES;
	}
	return _tabBarTransparent;
}
- (void)setTabBarTransparent:(BOOL)yesOrNo
{
	_tabBarTransparent = yesOrNo;
	if (yesOrNo)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, 0, 320.0f, _containerView.frame.size.height - tabBarHeight + tabBarTransOffset);
	}

}
- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;
{
	_tabBarHidden = yesOrNO;
	if (yesOrNO)
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height)
		{
			return;
		}
	}
	else 
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height - tabBarHeight)
		{
			return;
		}
	}
	
	if (animated)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3f];
		if (yesOrNO)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + tabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else 
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - tabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		[UIView commitAnimations];
	}
	else 
	{
		if (yesOrNO)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + tabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else 
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - tabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
	}
	if (yesOrNO)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		[self setTabBarTransparent:_tabBarTransparent];
	}
	[self refreshCurrentViewController];
}

- (NSUInteger)selectedIndex
{
	return [self.viewControllers indexOfObject:self.selectedViewController];
}

-(void)doSelectedAction:(NSUInteger)index
{
	if(self.selectedIndex == index)
		return;

//	[self.selectedViewController.view setHidden:YES];
	[self.selectedViewController viewWillDisappear:YES];
	[self.selectedViewController viewDidDisappear:YES];
	self.selectedViewController = [self.viewControllers objectAtIndex:index];
	
	for (UIViewController *vc in self.viewControllers) 
	{
		vc.view.hidden = YES;
	}
	
	[self.selectedViewController.view setHidden:NO];
	[self refreshCurrentViewController];
	[self.selectedViewController viewWillAppear:YES];
	[self.selectedViewController viewDidAppear:YES];
}

- (void)refreshCurrentViewController
{
	self.selectedViewController.view.frame = _transitionView.frame;
	//if ([self.selectedViewController.view isDescendantOfView:_transitionView]) 
	{
		[_transitionView bringSubviewToFront:self.selectedViewController.view];
	}
//	else
//	{
//		[_transitionView addSubview:self.selectedViewController.view];
//	}
}

- (CGFloat)getViewShowHeight
{
	return _transitionView.frame.size.height;
}

-(void)setSelectedIndex:(NSUInteger)index
{
    [self doSelectedAction:index];
	[_tabBar selectTabInIndex:index];
}

#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index
{
	[self doSelectedAction:index];
	NSLog(@"[BIZ]change to index:%d",index);
	[_delegate onSelectedTabBar:index];
}

- (UIImage*) tabBarArrowImage{
	return _tabBarArrowImage;
}

- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex{
	return [[_array_tabBarX objectAtIndex:tabIndex] floatValue];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.selectedViewController viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.selectedViewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.selectedViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[self.selectedViewController viewDidDisappear:animated];
}

@end
