//
//  PageViewController.h
//  MarkRep
//
//  Created by Akshay Kunila on 10/08/13.
//  Copyright (c) 2013 Karbens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PageViewController : UIViewController {

    NSInteger pageIndex;
    
    MPMoviePlayerController *theMovie;
    
    //BOOL textViewNeedsUpdate;
    //IBOutlet UILabel *label;
    //IBOutlet UITextView *textView;
    
    CGRect firstQuadFrame;
    CGRect secondQuadFrame;
    CGRect thirdQuadFrame;
    CGRect fourthQuadFrame;
    
    UIView *slideView;
    UIView *firstQuadView;
    UIView *secondQuadView;
    UIView *thirdQuadView;
    
    UIImageView *firstImgView;
    
    NSString *youtubeStr;
    UIWebView *secondQuadWebView;
    
  
    
}

@property NSInteger pageIndex;

//- (void)updateTextViews:(BOOL)force;

@end

