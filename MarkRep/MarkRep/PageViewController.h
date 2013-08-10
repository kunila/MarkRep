//
//  PageViewController.h
//  MarkRep
//
//  Created by Akshay Kunila on 10/08/13.
//  Copyright (c) 2013 Karbens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController {

    NSInteger pageIndex;
    BOOL textViewNeedsUpdate;
    IBOutlet UILabel *label;
    IBOutlet UITextView *textView;
    
}

@property NSInteger pageIndex;

- (void)updateTextViews:(BOOL)force;

@end

