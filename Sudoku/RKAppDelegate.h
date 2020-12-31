//
//  RKAppDelegate.h
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SudokuView.h"
#import "NineGridButton.h"

@interface RKAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *_window;

@property (assign) IBOutlet SudokuView *_view;

@property (assign) IBOutlet NineGridButton *_nineGridButton;


@end
