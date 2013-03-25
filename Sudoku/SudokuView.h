//
//  SudokuView.h
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class SudokuWindowController;

@interface SudokuView : NSView
{
    @private
    UInt32 _selectionCellX;
    UInt32 _selectionCellY;
    UInt32 _selectionX;
    UInt32 _selectionY;
    BOOL _haveSelection;
}


@property (assign, nonatomic) IBOutlet SudokuWindowController* _windowController;

@end
