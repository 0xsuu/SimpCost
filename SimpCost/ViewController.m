//
//  ViewController.m
//  SimpCost
//
//  Created by sun on 13-10-20.
//  Copyright (c) 2013年 suu. All rights reserved.
//

#define SHOW 1.0f
#define HIDE 0.0f

#define ADD 100
#define SUB 200

#import "ViewController.h"
#import "ListViewController.h"

@interface ViewController ()
{
    int status;
    
    float sumF;
    float additionF;
    float subtractionF;
    
    NSMutableArray *values;
    NSMutableArray *dates;
    NSMutableArray *notes;
}

@property (strong, nonatomic) IBOutlet UILabel *sum;
@property (strong, nonatomic) IBOutlet UILabel *addition;
@property (strong, nonatomic) IBOutlet UILabel *subtraction;

@property (strong, nonatomic) IBOutlet UITextField *value;
@property (strong, nonatomic) IBOutlet UITextField *note;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIView *tempView;
    
    for (tempView in self.view.subviews)
    {
        tempView.alpha = 0.0f;
    }
    
    [UIView animateWithDuration:0.5f animations:^
     {
         for (tempView in self.view.subviews)
         {
             if (![tempView isEqual:self.value] && ![tempView isEqual:self.note])
             {
                 tempView.alpha = 1.0f;
             }
         }
     }];
    
    sumF = [[NSUserDefaults standardUserDefaults] floatForKey:@"Sum"];
    additionF = [[NSUserDefaults standardUserDefaults] floatForKey:@"Addition"];
    subtractionF = [[NSUserDefaults standardUserDefaults] floatForKey:@"Subtraction"];
    
    self.sum.text = [NSString stringWithFormat:@"¥%.1f",sumF];
    self.addition.text = [NSString stringWithFormat:@"¥%.1f",additionF];
    self.subtraction.text = [NSString stringWithFormat:@"¥%.1f",subtractionF];
    
    values = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Values"]];
    dates = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Dates"]];
    notes = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Notes"]];
}

/*
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *tempView;
    
    for (tempView in self.view.subviews)
    {
        tempView.alpha = 0.0f;
    }
    
    [UIView animateWithDuration:0.5f animations:^
    {
         for (tempView in self.view.subviews)
         {
             if (![tempView isEqual:self.value] && ![tempView isEqual:self.note])
             {
                 tempView.alpha = 1.0f;
             }
         }
    }];
    
    sumF = [[NSUserDefaults standardUserDefaults] floatForKey:@"Sum"];
    additionF = [[NSUserDefaults standardUserDefaults] floatForKey:@"Addition"];
    subtractionF = [[NSUserDefaults standardUserDefaults] floatForKey:@"Subtraction"];
    
    self.sum.text = [NSString stringWithFormat:@"¥%.1f",sumF];
    self.addition.text = [NSString stringWithFormat:@"¥%.1f",additionF];
    self.subtraction.text = [NSString stringWithFormat:@"¥%.1f",subtractionF];
    
    values = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Values"]];
    dates = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Dates"]];
    notes = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Notes"]];
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)add:(id)sender
{
    [self setValueTextFieldStatus:SHOW];
    status = ADD;
    self.value.textColor = [UIColor colorWithRed:0.0f green:128.0f/256.0f blue:1.0f alpha:1.0f];
}

- (IBAction)minus:(id)sender
{
    [self setValueTextFieldStatus:SHOW];
    status = SUB;
    self.value.textColor = [UIColor redColor];
}

- (void)cleanAll
{
    sumF = 0.0f;
    additionF = 0.0f;
    subtractionF = 0.0f;
    
    [[NSUserDefaults standardUserDefaults] setFloat:sumF forKey:@"Sum"];
    [[NSUserDefaults standardUserDefaults] setFloat:additionF forKey:@"Addition"];
    [[NSUserDefaults standardUserDefaults] setFloat:subtractionF forKey:@"Subtraction"];
    
    self.sum.text = @"¥0.0";
    self.addition.text = @"¥0.0";
    self.subtraction.text = @"¥0.0";
}

- (IBAction)goToValue:(id)sender
{
    [self.value becomeFirstResponder];
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.value resignFirstResponder];
    [self setValueTextFieldStatus:HIDE];
    [self calculateAndSave];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.note resignFirstResponder];
    [self.value resignFirstResponder];
}

- (void)calculateAndSave
{
    switch (status)
    {
        case ADD:
        {
            [values insertObject:[NSString stringWithFormat:@"+ %.1f",[self.value.text floatValue]] atIndex:0];
            [[NSUserDefaults standardUserDefaults] setObject:values forKey:@"Values"];
            
            sumF += [self.value.text floatValue];
            additionF += [self.value.text floatValue];
            
            self.sum.text = [NSString stringWithFormat:@"¥%.1f",sumF];
            self.addition.text = [NSString stringWithFormat:@"¥%.1f",additionF];
            
            [[NSUserDefaults standardUserDefaults] setFloat:sumF forKey:@"Sum"];
            [[NSUserDefaults standardUserDefaults] setFloat:additionF forKey:@"Addition"];
            
        }
        break;
            
        case SUB:
        {
            [values insertObject:[NSString stringWithFormat:@"- %.1f",[self.value.text floatValue]] atIndex:0];
            [[NSUserDefaults standardUserDefaults] setObject:values forKey:@"Values"];
            
            sumF -= [self.value.text floatValue];
            subtractionF += [self.value.text floatValue];
            
            self.sum.text = [NSString stringWithFormat:@"¥%.1f",sumF];
            self.subtraction.text = [NSString stringWithFormat:@"¥%.1f",subtractionF];
            
            [[NSUserDefaults standardUserDefaults] setFloat:sumF forKey:@"Sum"];
            [[NSUserDefaults standardUserDefaults] setFloat:subtractionF forKey:@"Subtraction"];
            
        }
        break;
            
        default:
            break;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd-HH-mm-ss";
    [dates insertObject:[formatter stringFromDate:[NSDate new]] atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:dates forKey:@"Dates"];
    
    [notes insertObject:self.note.text atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:notes forKey:@"Notes"];
    
    self.value.text = @"";
    self.note.text = @"";
}

- (void)setValueTextFieldStatus:(float)alphaValue
{
    if (alphaValue == 1.0)
        [self.note becomeFirstResponder];
    
    [UIView animateWithDuration:0.3f animations:^
    {
        UIView *tempView;
    
        for (tempView in self.view.subviews)
        {
            if (![tempView isEqual:self.value] && ![tempView isEqual:self.note])
            {
                tempView.alpha = ABS(alphaValue - 1.0f);
            }
       }
    }];
    
    [UIView animateWithDuration:0.3f animations:^
    {
        self.value.alpha = alphaValue;
        self.note.alpha = alphaValue;
    }];
}

@end
