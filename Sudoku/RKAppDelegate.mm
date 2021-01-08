//
//  RKAppDelegate.m
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKAppDelegate.h"
#import "SudokuModel.h"

@interface RKAppDelegate (hidden)

-(void)setUpDifficultyMenu;

@end

@implementation RKAppDelegate
@synthesize _window;
@synthesize _view;

-(id)init
{
    self = [super init];
    
    if (self != nil)
    {
    }
    return self;
}

- (void)dealloc
{
    
    [super dealloc];
}



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self._view._selectionChangeDelegate = self._nineGridButton;
}



@end
