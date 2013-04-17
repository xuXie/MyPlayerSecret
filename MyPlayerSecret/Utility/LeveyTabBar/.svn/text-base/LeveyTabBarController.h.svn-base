//
//  LeveyTabBarControllerViewController.h
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeveyTabBar.h"
@class UITabBarController;
@protocol LeveyTabBarControllerDelegate;
@interface LeveyTabBarController : UIViewController <LeveyTabBarDelegate, UINavigationControllerDelegate>
{
	LeveyTabBar *_tabBar;
	UIView      *_containerView;
	UIView		*_transitionView;
	UIImage      *_tabBarArrowImage;
	NSMutableArray *_array_tabBarX;
	id<LeveyTabBarControllerDelegate> _delegate;
	NSMutableArray *_viewControllers;
	
	UIViewController  *_selectedViewController;
	NSArray *_imageArray;
	
	BOOL _tabBarTransparent;
	BOOL _tabBarHidden;
	
	float tabBarHeight;
	float tabBarTransOffset;
	float mfontHeight;
}

@property(nonatomic, copy) NSArray *viewControllers;
- (void)setViewControllers:(NSArray *)viewControllers;
-(void)createViewIfNeed;
-(void)addViewToContainer;

@property(nonatomic, assign) UIViewController *selectedViewController;
@property(nonatomic) NSUInteger selectedIndex;

//Apple is readonly
@property (nonatomic, retain, readonly) LeveyTabBar *tabBar;
@property(nonatomic,assign) id<LeveyTabBarControllerDelegate> delegate;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSMutableArray *array_tabBarX;

//default is NO, if set to YES, content will under tabbar
@property (nonatomic, assign) float tabBarTransOffset;//上面的视图与tabbar的偏移，用于tabbar有投影时
@property (nonatomic, assign) BOOL tabBarTransparent;//if tabBarHidden return YES;
@property (nonatomic, assign) BOOL tabBarHidden;

@property (nonatomic, retain) UIImage* tabBarArrowImage;
@property (nonatomic, assign) float tabBarHeight;
@property (nonatomic, assign) float mfontHeight;

- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr withHeight:(float)height;
- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr withHeight:(float)height withFontHeight:(float)fontheight;

- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;
- (void)refreshCurrentViewController;
- (CGFloat)getViewShowHeight;
@end


@protocol LeveyTabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(LeveyTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(LeveyTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
-(void)onSelectedTabBar:(NSUInteger)itemIndex;
@end

@interface UIViewController (LeveyTabBarControllerSupport)
@property(nonatomic, retain) LeveyTabBarController *leveyTabBarController;
//- (void)setLeveyTabBarController:(LeveyTabBarController *)tabbar;
@end

