//
//  DetailViewController.h
//  PRAM Scorer
//
//  Created by Ethan Hardy on 2014-05-12.
//  Copyright (c) 2014 Ethan Hardy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    int levelOfSeverity;
    IBOutlet UIScrollView *scroll;
    IBOutlet UILabel *titleLabel;
}

-(IBAction)done:(id)sender;
-(IBAction)toggleDetailDosage:(id)sender;
-(void)receiveLevel:(NSInteger)level;
-(void)swipeUp;

@end
