//
//  SudokuView.h
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SudokuModel.h"
#import "NineGridButton.h"
#import "Util.h"
#import "Sudoku-Swift.h"//Product Module Name in Build-Settings


@interface SudokuView : NSView
{
    @private
    UInt32 _selectionCellX;
    UInt32 _selectionCellY;
    UInt32 _selectionX;
    UInt32 _selectionY;
    BOOL _haveSelection;
    NSRect _playAreaRect;
    
   
    BOOL _isInNoteMode;
    BOOL _isInHintMode;
    
    
}


- (IBAction)hintButtonClick:(FlatButton *)sender;
- (IBAction)eraseButtonClick:(FlatButton *)sender;

- (IBAction)noteButtonClick:(NSButton *)sender;
- (IBAction)undoButtonClick:(FlatButton *)sender;

- (IBAction)setClickNumber:(NineGridButton *)sender;
- (IBAction)menuSelected:(NSMenuItem*)sender;

@property (assign, nonatomic) SudokuModel* _model;
@property (nonatomic, strong) id <SelectionChangeDelegate> _selectionChangeDelegate;

@end
