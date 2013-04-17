//
//  LeveyTabBar.h
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeveyTabBarDelegate;

@interface LeveyTabBar : UIView
{
	UIImageView *_backgroundView;
	id<LeveyTabBarDelegate> _delegate;
	UIButton *_selectedButton;
	NSMutableArray *_buttons;
	
	UIColor *m_textColor;
	UIColor *m_selectedTextColor;
}
@property (nonatomic, retain) UIImageView *backgroundView;
@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, assign) id<LeveyTabBarDelegate> delegate;
@property (nonatomic, assign) UIButton *selectedButton;
@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) UIColor *m_textColor;
@property (nonatomic, retain) UIColor *m_selectedTextColor;


- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray;
- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray withFontHeight:(float)fontHeight;
- (void)selectTabInIndex:(NSInteger)index;

@end
@protocol LeveyTabBarDelegate<NSObject>
- (UIImage*) tabBarArrowImage;
- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex;
@optional
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index; 
@end
