//
//  DetailViewController.h
//  MarkRep
//
//  Created by Akshay Kunila on 10/08/13.
//  Copyright (c) 2013 Karbens. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MGSplitViewController.h"
@class PageViewController;

@interface DetailViewController : UIViewController <MGSplitViewControllerDelegate> {
    
    IBOutlet MGSplitViewController *splitController;
	IBOutlet UIBarButtonItem *toggleItem;
	//IBOutlet UIBarButtonItem *verticalItem;
	IBOutlet UIBarButtonItem *dividerStyleItem;
	//IBOutlet UIBarButtonItem *masterBeforeDetailItem;
    //UIPopoverController *popoverController;
    UIToolbar *toolbar;
    
    id detailItem;
    UILabel *detailDescriptionLabel;
    
    
    IBOutlet UIScrollView *scrollView;
	IBOutlet UIPageControl *pageControl;
	
	PageViewController *currentPage;
	PageViewController *nextPage;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) id detailItem;
@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;
@property (nonatomic, retain) PageViewController *currentPage;
@property (nonatomic, retain) PageViewController *nextPage;

- (IBAction)toggleMasterView:(id)sender;
- (IBAction)toggleVertical:(id)sender;
- (IBAction)toggleDividerStyle:(id)sender;
- (IBAction)toggleMasterBeforeDetail:(id)sender;
- (IBAction)changePage:(id)sender;

- (void)applyNewIndex:(NSInteger)newIndex pageController:(PageViewController *)pageController;

@end
