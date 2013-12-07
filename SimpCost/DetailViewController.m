//
//  DetailViewController.m
//  SimpCost
//
//  Created by sun on 12/6/13.
//  Copyright (c) 2013 suu. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    NSMutableArray *values;
    NSMutableArray *dates;
    NSMutableArray *notes;
}

@property (strong, nonatomic) IBOutlet UILabel *value;
@property (strong, nonatomic) IBOutlet UILabel *note;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *location;

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
	// Do any additional setup after loading the view.
    
    values = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Values"]];
    dates = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Dates"]];
    notes = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Notes"]];
    
    NSInteger currentID = [[NSUserDefaults standardUserDefaults] integerForKey:@"CurrentDetailID"];
    self.value.text = [NSString stringWithFormat:@"%@¥%@",[[values objectAtIndex:currentID] substringToIndex:2],[[values objectAtIndex:currentID] substringFromIndex:2]];
    self.note.text = [notes objectAtIndex:currentID];
    self.time.text = [dates objectAtIndex:currentID];
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
