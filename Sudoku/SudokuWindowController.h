//
//  SudokuWindowController.h
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SudokuModel.h"
#import "SudokuView.h"

@interface SudokuWindowController : NSWindowController
{
    @private
    SudokuModel* _model;
    SudokuView* _view;
}

@property (assign, nonatomic) SudokuModel* _model;
@property (assign, nonatomic) IBOutlet SudokuView* _view;

-(UInt32)getOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(UInt32)getCurrentValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(void)setCurrentValue:(UInt32)value atCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(BOOL)isOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY
                       xIndex:(UInt32)x yIndex:(UInt32)y;

-(BOOL)isPuzzleSolved;

-(IBAction)menuSelected:(NSMenuItem*)sender;
-(void)redrawWindow;

@end
