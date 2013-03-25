//
//  SudokuWindowController.m
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "SudokuWindowController.h"
#import "RKAppDelegate.h"

@interface SudokuWindowController ()

@end

@implementation SudokuWindowController

@synthesize _model;
@synthesize _view;


- (id)init
{
    self = [super initWithWindowNibName:@"SudokuWindow"];
    
    if (self)
    {
        [self showWindow:self];
    }
    
    return self;
}

-(UInt32)getOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y
{
    return ([self._model getOriginalValueAtCellX:cellX andCellY:cellY xIndex:x yIndex:y]);
}

-(UInt32)getCurrentValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y
{
    return ([self._model getCurrentValueAtCellX:cellX andCellY:cellY xIndex:x yIndex:y]);
}

-(void)setCurrentValue:(UInt32)value atCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y
{
    [self._model setCurrentValue:value atCellX:cellX andCellY:cellY xIndex:x yIndex:y];
}

-( BOOL )isOriginalValueAtCellX:( UInt32 )cellX andCellY:( UInt32 )cellY
                         xIndex:( UInt32 )x yIndex:( UInt32 )y
{
    return ([_model isOriginalValueAtCellX:cellX andCellY:cellY xIndex:x yIndex:y]);
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    _model = [SudokuModel sharedModel];
    [_view setNeedsDisplay:YES];
}

-(BOOL)isPuzzleSolved
{
    return ([_model isPuzzleSolved]);
}

-(IBAction)menuSelected:(NSMenuItem*)sender
{
    NSString *name = sender.title;
    
    if ([name isEqualToString:@"Simple"])
    {
        [_model resetWithDifficulty:SudokuBoard::SIMPLE];
    }
    else if ([name isEqualToString:@"Easy"])
    {
        [_model resetWithDifficulty:SudokuBoard::EASY];
    }
    else if ([name isEqualToString:@"Intermediate"])
    {
        [_model resetWithDifficulty:SudokuBoard::INTERMEDIATE];
    }
    else if ([name isEqualToString:@"Expert"])
    {
        [_model resetWithDifficulty:SudokuBoard::EXPERT];
    }
    else // Random
    {
        [_model resetWithDifficulty:SudokuBoard::UNKNOWN];
    }
}

-(void)redrawWindow
{
    [_view setNeedsDisplay:YES];
}

@end
