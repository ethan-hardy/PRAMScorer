//
//  DetailViewController.m
//  PRAM Scorer
//
//  Created by Ethan Hardy on 2014-05-12.
//  Copyright (c) 2014 Ethan Hardy. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    if ([UIScreen mainScreen].bounds.size.height == 480)
        [scroll setFrame:CGRectMake(scroll.frame.origin.x, scroll.frame.origin.y, scroll.frame.size.width, scroll.frame.size.height-10)];
    [self detailShow];
    // Do any additional setup after loading the view from its nib.
}

-(void)detailShow
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LevelDetails" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *title;
    if (levelOfSeverity <= 3)
        title = @"Mild";
    else if (levelOfSeverity <= 7)
        title = @"Moderate";
    else
        title = @"Severe";
    NSArray *lines = [dict objectForKey:title];
    float xVal = 0.0, yVal = 0.0, tabAmount = 10.0, bulletSpace = 20.0, buffer = 10.0;
    int brk = 0;
    for (NSString *description in lines) {
        UILabel *bLabel;
        if ([description characterAtIndex:0] > 127) {
            xVal += tabAmount;
            bLabel = [[UILabel alloc] initWithFrame:CGRectMake(xVal, yVal, 10, 100)];
            bLabel.text = @"•";
            [scroll addSubview:bLabel];
            xVal += bulletSpace;
            brk = 1;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xVal, yVal, scroll.frame.size.width-xVal, 100)];
        label.text = description;
        label.text = [label.text substringFromIndex:brk];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        [scroll addSubview:label];
        [label sizeToFit];
        [bLabel setFrame:CGRectMake(bLabel.frame.origin.x, label.frame.origin.y, 10, label.frame.size.height)];
        [bLabel sizeToFit];
        yVal += label.frame.size.height + buffer * 2;
        if ([description characterAtIndex:[description length]-1] == ':') {
            xVal += tabAmount - bulletSpace;
        }
        else
            xVal = 0.0;
        brk = 0;
    }
    scroll.contentSize = CGSizeMake(scroll.frame.size.width, yVal);
}

-(IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)receiveLevel:(NSInteger)level
{
    levelOfSeverity = level;
}

-(void)swipeUp
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)toggleDetailDosage:(id)sender
{
    if ([[[sender titleLabel] text]  isEqual:@"Medications"]) {
        //change to dosages
        for (UIView *view in [scroll subviews]) {
            [view removeFromSuperview];
        }
        UIImageView *picHolder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Top"]];
        [picHolder setFrame:CGRectMake(0, 0, 273, 624)];
        [picHolder setContentMode:UIViewContentModeScaleAspectFit];
        [scroll addSubview:picHolder];
        UIImageView *picHolder2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bottom"]];
        [picHolder2 setFrame:CGRectMake(0, 624, 273, 305)];
        [scroll addSubview:picHolder2];
        [scroll setContentSize:CGSizeMake(273, 624 + 305)];
        [(UIButton *)sender setTitle:@"Details" forState:UIControlStateNormal];
        [titleLabel setText:@"Medications"];
    }
    else {
        for (UIView *view in [scroll subviews]) {
            [view removeFromSuperview];
        }
        [self detailShow];
        [(UIButton *)sender setTitle:@"Medications" forState:UIControlStateNormal];
        [titleLabel setText:@"Details"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
