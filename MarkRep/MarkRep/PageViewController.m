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
    firstQuadFrame = CGRectMake(10, 10,350, 400);
    secondQuadFrame = CGRectMake(370, 10,350, 400);
    thirdQuadFrame = CGRectMake(10, 420,350, 400);
    fourthQuadFrame = CGRectMake(370, 420,350, 400);
    
    youtubeStr = @"<iframe width=\"350\" height=\"400\" src=\"http://www.youtube.com/embed/lEWXasEdXpc\" frameborder=\"0\" allowfullscreen></iframe>";
    
    slideView = [[UIView alloc] initWithFrame:self.view.frame];
    
    /* --------------- First Quadrant -------------------- */
    
    firstQuadView = [[UIView alloc] initWithFrame:firstQuadFrame];
    firstImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 350, 400)];
    firstImgView.image = [UIImage imageNamed:@"bar_graph.png"];
    [firstQuadView addSubview:firstImgView];
    //[self.view addSubview:firstQuadView];
    [slideView addSubview:firstQuadView];
    
    /* --------------- Second Quadrant -------------------- */
    
    secondQuadView = [[UIView alloc] initWithFrame:secondQuadFrame];
    NSString *html = [NSString stringWithFormat:youtubeStr];
    secondQuadWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 350, 400)];
    [secondQuadWebView loadHTMLString:html baseURL:nil];
    [secondQuadView addSubview:secondQuadWebView];
    [slideView addSubview:secondQuadView];
    //[self.view addSubview:secondQuadView];
    
    /* --------------- Third Quadrant -------------------- */
    
    thirdQuadView = [[UIView alloc] initWithFrame:thirdQuadFrame];
    UIImageView *textImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 350, 380)];
    textImg.image = [UIImage imageNamed:@"pie_chart.png"];
    [thirdQuadView addSubview:textImg];
    [slideView addSubview:thirdQuadView];
    //[self.view addSubview:thirdQuadView];
    
    
    /* --------------- Fourth Quadrant -------------------- */
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"yeh_hasi_wadiyan" ofType:@"mp3"];
    NSURL *movieURL = [[NSURL fileURLWithPath:moviePath] retain];
    theMovie = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    //Place it in subview, else it won’t work
    theMovie.view.frame = fourthQuadFrame;
    //[self.view addSubview:theMovie.view];
    [slideView addSubview:theMovie.view];
    //Resize window – a bit more practical
    UIWindow *moviePlayerWindow = nil;
    moviePlayerWindow = [[UIApplication sharedApplication] keyWindow];
    [moviePlayerWindow setTransform:CGAffineTransformMakeScale(0.9, 0.9)];
    // Play the movie.
    //[theMovie play];
    
    [self.view addSubview:slideView];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
}

- (void)setPageIndex:(NSInteger)newPageIndex
{
	pageIndex = newPageIndex;
	
	if (pageIndex >= 0 && pageIndex < [[DataSource sharedDataSource] numDataPages])
	{
		NSDictionary *pageData =[[DataSource sharedDataSource] dataForPage:pageIndex];
		
        /*
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
        */
        
              
        
         switch (pageIndex) {
             case 0: 
                 
                 
         break;
         
         default:
         break;
         }
         
        
        
        
        
	}
}

- (void)updateTextViews:(BOOL)force
{
    /*
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
     */
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    
    [super dealloc];
    [theMovie release];
}

@end
