//
//  MainController.h
//  PRAM Scorer
//
//  Created by Ethan Hardy on 2014-05-12.
//  Copyright (c) 2014 Ethan Hardy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainController : UIViewController
{
    IBOutlet UISegmentedControl *airOne;
    IBOutlet UISegmentedControl *airTwo;
    IBOutlet UISegmentedControl *wheezeThree;
    IBOutlet UISegmentedControl *wheezeFour;
    IBOutlet UISegmentedControl *supersternal;
    IBOutlet UISegmentedControl *scaleneMuscle;
    IBOutlet UITextField *oxygen;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *swipeHelp;
    IBOutlet UISwipeGestureRecognizer *swiper;
    IBOutlet UIButton *refreshButton;
    IBOutlet UIImageView *backgroundCover;
    IBOutlet UILabel *infoLabel;
    IBOutlet UILabel *bracketLabel;
    IBOutlet UIButton *infoButton;
    int a;
}

-(IBAction)changeSegmentedControl:(id)sender;
-(IBAction)refreshScreen:(id)sender;
-(IBAction)resignFR:(id)sender;
-(IBAction)showInfo:(id)sender;
-(void)swipeUp;

@end
