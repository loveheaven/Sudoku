//
//  SudokuiOSAppDelegate.h
//  SudokuiOS
//
//  Created by Rishi Kapadia on 3/22/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SudokuiOSViewController.h"

@class SudokuiOSViewController;

@interface SudokuiOSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SudokuiOSViewController *viewController;

/*
{
@private
    SudokuiOSViewController* _playerViewController;
}

//@property (assign) IBOutlet SudokuiOSView* _view;

//@property (strong, nonatomic) UIWindow* _window;
@property (strong, nonatomic) SudokuiOSViewController* _viewController;

-(void)redrawWindows;
*/
@end
