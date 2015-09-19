//
//  MainController.m
//  PRAM Scorer
//
//  Created by Ethan Hardy on 2014-05-12.
//  Copyright (c) 2014 Ethan Hardy. All rights reserved.
//

#import "MainController.h"
#import "DetailViewController.h"

@interface MainController ()

@end

@implementation MainController

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
    [supersternal setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [scaleneMuscle setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [airOne setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [airTwo setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [wheezeThree setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [wheezeFour setSelectedSegmentIndex:UISegmentedControlNoSegment];
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [scoreLabel setFrame:CGRectMake(scoreLabel.frame.origin.x, 20, scoreLabel.frame.size.width, scoreLabel.frame.size.height)];
        [swipeHelp setFrame:CGRectMake(swipeHelp.frame.origin.x, 442, swipeHelp.frame.size.width, swipeHelp.frame.size.height)];
        [refreshButton setFrame:CGRectMake(12, 29, 25, 25)];
        [infoButton setFrame:CGRectMake(infoButton.frame.origin.x, 453, infoButton.frame.size.width, infoButton.frame.size.height)];
        [bracketLabel setFrame:CGRectMake(bracketLabel.frame.origin.x, 442, bracketLabel.frame.size.width, bracketLabel.frame.size.height)];
        [scoreLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
    }
    oxygen.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [swiper addTarget:self action:@selector(swipeUp)];
    a = -1;
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)changeSegmentedControl:(id)sender
{
    switch ([sender tag]) {
        case 1:
            [airTwo setSelectedSegmentIndex:UISegmentedControlNoSegment];
            break;
        case 2:
            [airOne setSelectedSegmentIndex:UISegmentedControlNoSegment];
            break;
        case 3:
            [wheezeFour setSelectedSegmentIndex:UISegmentedControlNoSegment];
            break;
        case 4:
            [wheezeThree setSelectedSegmentIndex:UISegmentedControlNoSegment];
            break;
    }
    a = 0;
    
    if ([[oxygen text] intValue] > 100 || [[oxygen text] intValue] <= 0)
        a -= 100;
    else if ([[oxygen text] intValue] >= 95)
        a += 0;
    else if ([[oxygen text] intValue] >= 92)
        a += 1;
    else
        a += 2;
    
    if ([supersternal selectedSegmentIndex] == 1)
        a += 2;
    else if ([supersternal selectedSegmentIndex] == UISegmentedControlNoSegment)
        a -= 100;
    
    if ([scaleneMuscle selectedSegmentIndex] == 1)
        a += 2;
    else if ([scaleneMuscle selectedSegmentIndex] == UISegmentedControlNoSegment)
        a -= 100;
    
    if ([airOne selectedSegmentIndex] == 1)
        a += 1;
    else if ([airTwo selectedSegmentIndex] == 0)
        a += 2;
    else  if ([airTwo selectedSegmentIndex] == 1)
        a += 3;
    else if ([airOne selectedSegmentIndex] == -1 && [airOne selectedSegmentIndex] == -1)
        a -= 100;
    
    if ([wheezeThree selectedSegmentIndex] == 1)
        a += 1;
    else if ([wheezeFour selectedSegmentIndex] == 0)
        a += 2;
    else  if ([wheezeFour selectedSegmentIndex] == 1)
        a += 3;
    else if ([wheezeThree selectedSegmentIndex] == -1 && [wheezeFour selectedSegmentIndex] == -1)
        a -= 100;
    if (a < 0) {
        [scoreLabel setText:@"PRAM Score: Not enough info"];
        swipeHelp.hidden = YES;
    }
    else {
        NSString *level;
        if (a <= 3)
            level = @"Mild";
        else if (a <= 7)
            level = @"Moderate";
        else
            level = @"Severe";
        [scoreLabel setText:[NSString stringWithFormat:@"PRAM Score: %@ (%d)",level,a]];
        swipeHelp.hidden = NO;
    }
    [oxygen resignFirstResponder];
}

-(IBAction)refreshScreen:(id)sender
{
    [supersternal setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [scaleneMuscle setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [airOne setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [airTwo setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [wheezeThree setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [wheezeFour setSelectedSegmentIndex:UISegmentedControlNoSegment];
    a = -1;
    [oxygen setText:@""];
    swipeHelp.hidden = YES;
    [scoreLabel setText:@"PRAM Score: Not enough info"];
}

-(IBAction)resignFR:(id)sender
{
    [oxygen resignFirstResponder];
    [self changeSegmentedControl:sender];
}

-(IBAction)showInfo:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        backgroundCover.alpha = 0.7;
        infoLabel.alpha = 1;
    }];
    for (UIControl *v in [self.view subviews]) {
        v.enabled = NO;
    }
    infoLabel.enabled = YES;
    if ([sender tag] == 1) {
        [infoLabel setText:@"THE PRAM SCORE IS INTENDED TO BE USED IN THE CLINICAL ASSESSMENT OF THE SEVERITY OF AN EPISODE OF ACUTE AIRWAY OBSTRUCTION DUE TO ASTHMA. IT IS AN AID TO THE CLINICAL ASSESSMENT AND SHALL NOT BE USED TO REPLACE OR OVERRULE A LICENSED HEALTH CARE PROFESSIONAL'S JUDGEMENT ABOUT ASTHMA SEVERITY \n\nPRAM teaching module: http://www.chu-sainte-justine.org/pram/ \n\nPRAM is reproduced and adapted with the permission of Francine M. Ducharme"];
    }
    else {
        [infoLabel setText:@"*In case of asymmetry, the most severely affected (apex-base) lung field (right or left, anterior or posterior) will determine the rating of the criterion. \n\n** In case of asymmetry, the two most severely affected auscultation zones, irrespectively of their location (RUL, RML, RLL, LUL, LLL), will determine the rating of the criterion."];
    }
    [infoLabel sizeToFit];
    [infoLabel setFrame:CGRectMake(infoLabel.frame.origin.x, self.view.frame.size.height / 2 - infoLabel.frame.size.height / 2, infoLabel.frame.size.width, infoLabel.frame.size.height)];
}

-(void)swipeUp
{
    if (a >= 0) {
        DetailViewController *detail = [[DetailViewController alloc] init];
        [detail receiveLevel:a];
        [self presentViewController:detail animated:YES completion:NULL];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignFR:oxygen];
    [UIView animateWithDuration:0.5 animations:^{
        backgroundCover.alpha = 0.0;
        infoLabel.alpha = 0;
    }];
    if (!supersternal.enabled) {
        for (UIControl *v in [self.view subviews]) {
            v.enabled = YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
