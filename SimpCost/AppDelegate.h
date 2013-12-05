//
//  AppDelegate.h
//  SimpCost
//
//  Created by sun on 13-10-20.
//  Copyright (c) 2013年 suu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

- (void)cleanAll;

@end
