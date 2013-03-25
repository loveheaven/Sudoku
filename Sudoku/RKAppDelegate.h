//
//  RKAppDelegate.h
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SudokuWindowController.h"

@interface RKAppDelegate : NSObject <NSApplicationDelegate>
{
    @private
    SudokuWindowController* _playerWindowController;
}

@property (assign) IBOutlet NSWindow *window;

-(void)redrawWindows;

@end