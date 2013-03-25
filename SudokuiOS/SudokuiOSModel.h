//
//  SudokuiOSModel.h
//  Sudoku
//
//  Created by Rishi Kapadia on 3/22/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "qqwing.h"

@interface SudokuiOSModel : NSObject

{
@private
    SudokuBoard* _sudokuBoard;
    int* _playerPuzzleInProgress;
}

+(SudokuiOSModel*) sharedModel;
-(UInt32)getOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(UInt32)getCurrentValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(void)setCurrentValue:(UInt32)value atCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(BOOL)isOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY
    xIndex:(UInt32)x yIndex:(UInt32)y;

-(BOOL)isPuzzleSolved;

-(void)resetWithDifficulty:(SudokuBoard::Difficulty)level;
-(void)giveUp;


@end
