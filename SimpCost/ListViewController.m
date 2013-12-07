//
//  ListViewController.m
//  SimpCost
//
//  Created by sun on 13-10-20.
//  Copyright (c) 2013年 suu. All rights reserved.
//

#import "ListViewController.h"
#import "AppDelegate.h"

#import "DetailViewController.h"
#import "NavigationViewController.h"

@interface ListViewController ()
{
    NSMutableArray *values;
    NSMutableArray *dates;
    NSMutableArray *notes;
}

@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation ListViewController

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
    
    [self.listTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [values count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.listTableView = tableView;
    
    static NSString *CellIdentifier = @"ListTableViewCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
	}
    
    cell.textLabel.text = [notes objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text = [values objectAtIndex:indexPath.row];
    if ([[(NSString *)[values objectAtIndex:indexPath.row] substringWithRange:NSMakeRange(0,1)] isEqualToString:@"+"])
    {
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0f green:128.0f/256.0f blue:1.0f alpha:1.0f];
    }
    else
    {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    /*
    UITextField *dateText = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, 200, 10)];
    dateText.backgroundColor = [UIColor clearColor];
    dateText.font = [UIFont fontWithName:@"Helvetica Neue Light" size:2.0f];
    dateText.text = [dates objectAtIndex:indexPath.row];
    [cell addSubview:dateText];*/
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSUInteger row = [indexPath row];
        
        [[NSUserDefaults standardUserDefaults] setFloat:([[NSUserDefaults standardUserDefaults] floatForKey:@"Sum"] - [[[values objectAtIndex:row] substringFromIndex:2] floatValue]) forKey:@"Sum"];
        [[NSUserDefaults standardUserDefaults] setFloat:([[NSUserDefaults standardUserDefaults] floatForKey:@"Addition"] - [[[values objectAtIndex:row] substringFromIndex:2] floatValue]) forKey:@"Addition"];
        [[NSUserDefaults standardUserDefaults] setFloat:([[NSUserDefaults standardUserDefaults] floatForKey:@"Subtraction"] - [[[values objectAtIndex:row] substringFromIndex:2] floatValue]) forKey:@"Subtraction"];
        
        
        [values removeObjectAtIndex:row];
        [dates removeObjectAtIndex:row];
        [notes removeObjectAtIndex:row];
        
        if (!values)
        {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:values forKey:@"Values"];
        [[NSUserDefaults standardUserDefaults] setObject:dates forKey:@"Dates"];
        [[NSUserDefaults standardUserDefaults] setObject:notes forKey:@"Notes"];
        
        [self.listTableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"CurrentDetailID"];
    
    NavigationViewController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailNav"];
    [self presentViewController:nav animated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)cleanAll:(id)sender
{
    UIAlertView *cleanAll = [[UIAlertView alloc] initWithTitle:@"Clean All" message:@"Clean all the data" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    [cleanAll show];
}

#pragma mark UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [values removeAllObjects];
        [dates removeAllObjects];
        [notes removeAllObjects];
        [[NSUserDefaults standardUserDefaults] setObject:values forKey:@"Values"];
        [[NSUserDefaults standardUserDefaults] setObject:dates forKey:@"Dates"];
        [[NSUserDefaults standardUserDefaults] setObject:notes forKey:@"Notes"];
    
        [self.listTableView reloadData];
    
        [[NSUserDefaults standardUserDefaults] setFloat:0.0f forKey:@"Sum"];
        [[NSUserDefaults standardUserDefaults] setFloat:0.0f forKey:@"Addition"];
        [[NSUserDefaults standardUserDefaults] setFloat:0.0f forKey:@"Subtraction"];
    
        [self dismissViewControllerAnimated:YES completion:nil];
    
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [delegate cleanAll];
    }
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
