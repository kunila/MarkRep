//
//  DetailViewController.m
//  MarkRep
//
//  Created by Akshay Kunila on 10/08/13.
//  Copyright (c) 2013 Karbens. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "PageViewController.h"
#import "DataSource.h"

@interface DetailViewController ()

- (void)configureView;

@end

@implementation DetailViewController

@synthesize toolbar, detailItem, detailDescriptionLabel;

#pragma mark -
#pragma mark Managing the detail item

- (void)applyNewIndex:(NSInteger)newIndex pageController:(PageViewController *)pageController
{
	NSInteger pageCount = [[DataSource sharedDataSource] numDataPages];
	BOOL outOfBounds = newIndex >= pageCount || newIndex < 0;
    
	if (!outOfBounds)
	{
		CGRect pageFrame = pageController.view.frame;
		pageFrame.origin.y = 0;
		pageFrame.origin.x = scrollView.frame.size.width * newIndex;
		pageController.view.frame = pageFrame;
	}
	else
	{
		CGRect pageFrame = pageController.view.frame;
		pageFrame.origin.y = scrollView.frame.size.height;
		pageController.view.frame = pageFrame;
	}
    
	pageController.pageIndex = newIndex;
}


- (void)viewDidLoad{
    
    currentPage = [[PageViewController alloc] initWithNibName:@"PageView" bundle:nil];
	nextPage = [[PageViewController alloc] initWithNibName:@"PageView" bundle:nil];
	[scrollView addSubview:currentPage.view];
	[scrollView addSubview:nextPage.view];
    
	NSInteger widthCount = [[DataSource sharedDataSource] numDataPages];
	if (widthCount == 0)
	{
		widthCount = 1;
	}
	
    scrollView.contentSize =
    CGSizeMake(
               scrollView.frame.size.width * widthCount,
               scrollView.frame.size.height);
	scrollView.contentOffset = CGPointMake(0, 0);
    
	pageControl.numberOfPages = [[DataSource sharedDataSource] numDataPages];
	pageControl.currentPage = 0;
	
	[self applyNewIndex:0 pageController:currentPage];
	[self applyNewIndex:1 pageController:nextPage];

    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    
    //[recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    [self.view addGestureRecognizer:recognizer];
    
}

-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe received.");
}


// When setting the detail item, update the view and dismiss the popover controller if it's showing.
- (void)setDetailItem:(id)newDetailItem
{
    if (detailItem != newDetailItem) {
        [detailItem release];
        detailItem = [newDetailItem retain];
        
        // Update the view.
        [self configureView];
    }
	
    /*
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }
    */
}


- (void)configureView
{
    // Update the user interface for the detail item.
    detailDescriptionLabel.text = [detailItem description];
	toggleItem.title = ([splitController isShowingMaster]) ? @"Hide Index" : @"Show Index"; // "I... AM... THE MASTER!" Derek Jacobi. Gave me chills.
	//verticalItem.title = (splitController.vertical) ? @"Horizontal Split" : @"Vertical Split";
	dividerStyleItem.title = (splitController.dividerStyle == MGSplitViewDividerStyleThin) ? @"Enable Drag" : @"Disable Drag";
	//masterBeforeDetailItem.title = (splitController.masterBeforeDetail) ? @"Detail First" : @"Master First";
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
	
	NSInteger lowerNumber = floor(fractionalPage);
	NSInteger upperNumber = lowerNumber + 1;
	
	if (lowerNumber == currentPage.pageIndex)
	{
		if (upperNumber != nextPage.pageIndex)
		{
			[self applyNewIndex:upperNumber pageController:nextPage];
		}
	}
	else if (upperNumber == currentPage.pageIndex)
	{
		if (lowerNumber != nextPage.pageIndex)
		{
			[self applyNewIndex:lowerNumber pageController:nextPage];
		}
	}
	else
	{
		if (lowerNumber == nextPage.pageIndex)
		{
			[self applyNewIndex:upperNumber pageController:currentPage];
		}
		else if (upperNumber == nextPage.pageIndex)
		{
			[self applyNewIndex:lowerNumber pageController:currentPage];
		}
		else
		{
			[self applyNewIndex:lowerNumber pageController:currentPage];
			[self applyNewIndex:upperNumber pageController:nextPage];
		}
	}
	
	[currentPage updateTextViews:NO];
	[nextPage updateTextViews:NO];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)newScrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
	NSInteger nearestNumber = lround(fractionalPage);
    
	if (currentPage.pageIndex != nearestNumber)
	{
		PageViewController *swapController = currentPage;
		currentPage = nextPage;
		nextPage = swapController;
	}
    
	[currentPage updateTextViews:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)newScrollView
{
	[self scrollViewDidEndScrollingAnimation:newScrollView];
	pageControl.currentPage = currentPage.pageIndex;
}

- (IBAction)changePage:(id)sender
{
	NSInteger pageIndex = pageControl.currentPage;
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageIndex;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}

-(void)goToSlide:(NSInteger)newIndex
{
    NSInteger pageIndex = newIndex;//pageControl.currentPage;
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageIndex;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
}


#pragma mark -
#pragma mark Split view support


- (void)splitViewController:(MGSplitViewController*)svc
	 willHideViewController:(UIViewController *)aViewController
		  withBarButtonItem:(UIBarButtonItem*)barButtonItem
	   forPopoverController: (UIPopoverController*)pc
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
	/*
	if (barButtonItem) {
		barButtonItem.title = @"Popover";
		NSMutableArray *items = [[toolbar items] mutableCopy];
		[items insertObject:barButtonItem atIndex:0];
		[toolbar setItems:items animated:YES];
		[items release];
	}
    self.popoverController = pc;
     */
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(MGSplitViewController*)svc
	 willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
	/*
	if (barButtonItem) {
		NSMutableArray *items = [[toolbar items] mutableCopy];
		[items removeObject:barButtonItem];
		[toolbar setItems:items animated:YES];
		[items release];
	}
    self.popoverController = nil;
     */
}


- (void)splitViewController:(MGSplitViewController*)svc
		  popoverController:(UIPopoverController*)pc
  willPresentViewController:(UIViewController *)aViewController
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc willChangeSplitOrientationToVertical:(BOOL)isVertical
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc willMoveSplitToPosition:(float)position
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (float)splitViewController:(MGSplitViewController *)svc constrainSplitPosition:(float)proposedPosition splitViewSize:(CGSize)viewSize
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
	return proposedPosition;
}


#pragma mark -
#pragma mark Actions


- (IBAction)toggleMasterView:(id)sender
{
	[splitController toggleMasterView:sender];
	[self configureView];
}


- (IBAction)toggleVertical:(id)sender
{
	[splitController toggleSplitOrientation:self];
	[self configureView];
}


- (IBAction)toggleDividerStyle:(id)sender
{
	MGSplitViewDividerStyle newStyle = ((splitController.dividerStyle == MGSplitViewDividerStyleThin) ? MGSplitViewDividerStylePaneSplitter : MGSplitViewDividerStyleThin);
	[splitController setDividerStyle:newStyle animated:YES];
	[self configureView];
}


- (IBAction)toggleMasterBeforeDetail:(id)sender
{
	[splitController toggleMasterBeforeDetail:sender];
	[self configureView];
}


#pragma mark -
#pragma mark Rotation support


// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self configureView];
}


- (void)dealloc
{
    //[popoverController release];
    
    [currentPage release];
	[nextPage release];
    [toolbar release];
    
    [detailItem release];
    [detailDescriptionLabel release];
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
