//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import "LeveyTabBar.h"

#define TAB_ARROW_IMAGE_TAG 2394859
#define TAB_BTN_TEXT_TAG 2356854

@interface LeveyTabBar(PrivateMethods)

- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex;
- (void) addTabBarArrowAtIndex:(NSUInteger)itemIndex;
- (void)tabBarButtonClicked:(id)sender;
- (void)tabBarButtonDownClicked:(id)sender;
- (void)dealWithBtnText:(UIButton*)btn;
@end


@implementation LeveyTabBar
@synthesize backgroundView = _backgroundView;
@synthesize delegate = _delegate;
@synthesize selectedButton = _selectedButton;
@synthesize buttons = _buttons;
@synthesize backgroundImage;
@synthesize m_textColor;
@synthesize m_selectedTextColor;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray
{
	return [self initWithFrame:frame buttonImages:imageArray withFontHeight:13];
}

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray withFontHeight:(float)fontHeight
{
	self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[self addSubview:_backgroundView];
		
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
		UIButton *btn;
		CGFloat width = 320.0f / [imageArray count];
		self.m_textColor = [UIColor whiteColor];
		
		for (int i = 0; i < [imageArray count]; i++)
		{
			btn = [UIButton buttonWithType:UIButtonTypeCustom];
			//btn.showsTouchWhenHighlighted = YES;
			btn.tag = i;
			btn.frame = CGRectMake(width * i, 0, width, frame.size.height);
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
			//			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[btn addTarget:self action:@selector(tabBarButtonDownClicked:) forControlEvents:UIControlEventTouchDown];
			[btn addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchUpOutside];
			[btn addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchDragOutside];
			[btn addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchDragInside];
			
			if ([[imageArray objectAtIndex:i] objectForKey:@"Title"])
			{
				UILabel* _label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 20.0, width, 20.0f)];
				_label.tag = TAB_BTN_TEXT_TAG;
				[_label setBackgroundColor:[UIColor clearColor]];
				[_label setTextAlignment:UITextAlignmentCenter];
				[_label setFont:[UIFont fontWithName:@"STHeitiTC-Medium" size:fontHeight]];
				
				[_label setTextColor:self.m_textColor];
				[_label setText:[[imageArray objectAtIndex:i] objectForKey:@"Title"]];
				[btn addSubview:_label];
				[_label release];
			}

			[self.buttons addObject:btn];
			[self addSubview:btn];
		}
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
	[_backgroundView setImage:img];
}


#pragma mark -
#pragma mark buttonsclick


// modify by zwh

- (void)tabBarButtonClicked:(UIButton*)button
{
	[self selectTabInIndex:button.tag];
	//[_delegate tabBar:self didSelectIndex:btn.tag];
}

- (void)tabBarButtonDownClicked:(UIButton*)button
{
	[self selectTabInIndex:button.tag];
	[_delegate tabBar:self didSelectIndex:button.tag];
}

- (void)otherTouchesAction:(UIButton*)button
{
	[self selectTabInIndex:button.tag];
}


#pragma mark -
#pragma mark ---------

// modify by zwh
- (void)selectTabInIndex:(NSInteger)index
{
	UIButton *btn = [self.buttons objectAtIndex:index];
	btn.selected = YES;
	btn.highlighted = NO;
	[self dealWithBtnText:btn];
	self.selectedButton = btn;
	
	for (UIButton* b in self.buttons)
	{
		if (b.tag != index)
		{
			b.selected = NO;
			b.highlighted = NO;
			[self dealWithBtnText:b];
		}
	}

	
	UIImageView* tabBarArrow = (UIImageView*)[self viewWithTag:TAB_ARROW_IMAGE_TAG];
	NSUInteger selectedIndex = index;
	if (tabBarArrow)
	{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        CGRect frame = tabBarArrow.frame;
		frame.origin.x = [_delegate horizontalLocationFor:selectedIndex];
        tabBarArrow.frame = frame;
        [UIView commitAnimations];
	}
	else
	{
        [self addTabBarArrowAtIndex:selectedIndex];
	}
}

-(void)dealWithBtnText:(UIButton*)btn
{
	UILabel* textlabel = (UILabel*)[btn viewWithTag:TAB_BTN_TEXT_TAG];
	textlabel.textColor = m_textColor;
	textlabel.highlightedTextColor = m_selectedTextColor;
	textlabel.highlighted = btn.selected;
}

- (void) addTabBarArrowAtIndex:(NSUInteger)itemIndex
{
	UIImage* tabBarArrowImage = [_delegate tabBarArrowImage];
	if (!tabBarArrowImage)
	{
		return;
	}
	
	UIImageView* tabBarArrow = [[[UIImageView alloc] initWithImage:tabBarArrowImage] autorelease];
	tabBarArrow.tag = TAB_ARROW_IMAGE_TAG;
	// To get the vertical location we go up by the height of arrow and then come back down 2 pixels so the arrow is slightly on top of the tab bar.
	CGFloat verticalLocation = -tabBarArrowImage.size.height + self.frame.size.height + 1.0;
	tabBarArrow.alpha = 0.8f;
	[self addSubview:tabBarArrow];
	[self insertSubview:tabBarArrow aboveSubview:self.backgroundView];
	tabBarArrow.frame = CGRectMake([_delegate horizontalLocationFor:itemIndex], verticalLocation, tabBarArrowImage.size.width, tabBarArrowImage.size.height);
}

- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
	UIImageView* tabBarArrow = (UIImageView*)[self viewWithTag:TAB_ARROW_IMAGE_TAG];
	
	// A single tab item's width is the entire width of the tab bar divided by number of items
	CGFloat tabItemWidth = self.frame.size.width /_buttons.count;
	// A half width is tabItemWidth divided by 2 minus half the width of the arrow
	CGFloat halfTabItemWidth = (tabItemWidth / 2.0) - (tabBarArrow.frame.size.width / 2.0);
	
	// The horizontal location is the index times the width plus a half width
	CGFloat _h = (tabIndex * tabItemWidth) + halfTabItemWidth;
	return _h;
}

- (void)dealloc
{
	self.backgroundView = nil;
	self.backgroundImage = nil;
	self.buttons = nil;
	self.m_textColor = nil;
	self.m_selectedTextColor = nil;
    [super dealloc];
}

@end
