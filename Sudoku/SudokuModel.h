//
//  SudokuModel.h
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "qqwing.h"
#include <stack>
struct step {
    int index;
    int value;
};
@interface SudokuModel : NSObject
{
@private
    SudokuBoard* _sudokuBoard;
    int* _playerPuzzleInProgress;
    int* noteInProcess;
    BOOL* _isPlayerPuzzleConflicted;
    stack<step>* _stack;
}

+(SudokuModel*) sharedModel;
-(UInt32)getOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(UInt32)getCurrentValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(void)setCurrentValue:(UInt32)value atCellX:(UInt32)cellX andCellY:(UInt32)cellY
                xIndex:(UInt32)x yIndex:(UInt32)y;
-(int*)getCurrentNote:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(void)setCurrentNote:(UInt32)value atCellX:(UInt32)cellX andCellY:(UInt32)cellY
                xIndex:(UInt32)x yIndex:(UInt32)y;
-(BOOL)undoCurrentValue;

-(BOOL)isOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY
                         xIndex:(UInt32)x yIndex:(UInt32)y;

-(BOOL)isConflicted:(UInt32)cellX andCellY:(UInt32)cellY
                       xIndex:(UInt32)x yIndex:(UInt32)y;
-(BOOL)checkConflicts;
-(BOOL)isPuzzleSolved;

-(void)resetWithDifficulty:(SudokuBoard::Difficulty)level;

@end
