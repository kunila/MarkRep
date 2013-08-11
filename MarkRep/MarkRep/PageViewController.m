//
//  PageViewController.m
//  MarkRep
//
//  Created by Akshay Kunila on 10/08/13.
//  Copyright (c) 2013 Karbens. All rights reserved.
//

#import "PageViewController.h"
#import "DataSource.h"
#import <QuartzCore/QuartzCore.h>

const CGFloat TEXT_VIEW_PADDING = 50.0;

@interface PageViewController ()

@end

@implementation PageViewController

@synthesize pageIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)setPageIndex:(NSInteger)newPageIndex
{
	pageIndex = newPageIndex;
	
	if (pageIndex >= 0 && pageIndex < [[DataSource sharedDataSource] numDataPages])
	{
		NSDictionary *pageData =[[DataSource sharedDataSource] dataForPage:pageIndex];
		label.text = [pageData objectForKey:@"pageName"];
		textView.text = [pageData objectForKey:@"pageText"];
		
		CGRect absoluteRect = [self.view.window
                               convertRect:textView.bounds
                               fromView:textView];
		if (!self.view.window ||
			!CGRectIntersectsRect(
                                  CGRectInset(absoluteRect, TEXT_VIEW_PADDING, TEXT_VIEW_PADDING),
                                  [self.view.window bounds]))
		{
			textViewNeedsUpdate = YES;
		}
	}
}

- (void)updateTextViews:(BOOL)force
{
	if (force ||
		(textViewNeedsUpdate &&
         self.view.window &&
         CGRectIntersectsRect(
                              [self.view.window
                               convertRect:CGRectInset(textView.bounds, TEXT_VIEW_PADDING, TEXT_VIEW_PADDING)
                               fromView:textView],
                              [self.view.window bounds])))
	{
		for (UIView *childView in textView.subviews)
		{
			[childView setNeedsDisplay];
		}
		textViewNeedsUpdate = NO;
	}
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
