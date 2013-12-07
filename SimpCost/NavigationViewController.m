//
//  NavigationViewController.m
//  SimpCost
//
//  Created by sun on 12/7/13.
//  Copyright (c) 2013 suu. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

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
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.0f green:128.0f/256.0f blue:1.0f alpha:1.0f]];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor],NSForegroundColorAttributeName,
      [UIFont fontWithName:@"HelveticaNeue-Light" size:22.0], NSFontAttributeName,nil]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
