//
//  SudokuModel.m
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "SudokuModel.h"
#import "RKAppDelegate.h"
#import <iostream>
#define mCellToArrayIndex(cx,cy,x,y) ((cy)*27 + (y)*9 + (cx)*3 + (x))

static SudokuModel* gSharedModel;

@implementation SudokuModel


-(id)init
{
    self =[super init];
    if (self)
    {
        //_sudokuBoard = new SudokuBoard();
        //_sudokuBoard->setRecordHistory(true);
        //_sudokuBoard->generatePuzzle();
        //bool haveSolution = false;
        //while( haveSolution == false)
        //{
        //    haveSolution = _sudokuBoard->solve();
        //}
         _stack = new stack<step>();

        _playerPuzzleInProgress = new int[81];
        _isPlayerPuzzleConflicted = new BOOL[81];
        noteInProcess = new int[81*9];
        
        srandom((unsigned)clock());
        [self resetWithDifficulty:SudokuBoard::UNKNOWN];
        
        //memcpy(_playerPuzzleInProgress,_sudokuBoard->getPuzzle(),81*sizeof(int));
        //_sudokuBoard->printSolution();
        //_playerPuzzleInProgress[mCellToArrayIndex(1,1,1,1)]=0;
        //int argc=3;
        //char* argv[]={"qqwing", "--generate", "10"};
        //qqwing(argc,argv);
    }
    return self;
}

-( UInt32 )getCurrentValueAtCellX:( UInt32 )cellX andCellY:( UInt32 )cellY
                           xIndex:( UInt32 )x yIndex:( UInt32 )y
{
    return( _playerPuzzleInProgress[ mCellToArrayIndex(cellX,cellY,x,y) ] );
}

-( void )setCurrentValue:( UInt32 )value atCellX:( UInt32 )cellX andCellY:( UInt32 )cellY
                  xIndex:( UInt32 )x yIndex:( UInt32 )y
{
    if (value == _playerPuzzleInProgress[ mCellToArrayIndex(cellX,cellY,x,y)]) {
        return;
    }
    struct step s;
    s.index = mCellToArrayIndex(cellX,cellY,x,y);
    s.value = _playerPuzzleInProgress[ mCellToArrayIndex(cellX,cellY,x,y) ];
    _stack->emplace(s);
    _playerPuzzleInProgress[ mCellToArrayIndex(cellX,cellY,x,y) ] = value;
    for(int i =0;i<9;i++) {
        noteInProcess[mCellToArrayIndex(cellX, cellY, x, y)*9 + i] = 0;
    }
    [self checkConflicts];
}
-( void )setCurrentNote:( UInt32 )value atCellX:( UInt32 )cellX andCellY:( UInt32 )cellY
                  xIndex:( UInt32 )x yIndex:( UInt32 )y
{
    if(_playerPuzzleInProgress[ mCellToArrayIndex(cellX,cellY,x,y) ] != 0) {
        return;
    }
    if (noteInProcess[mCellToArrayIndex(cellX,cellY,x,y)*9 + (value - 1)] == value) {
        noteInProcess[mCellToArrayIndex(cellX,cellY,x,y)*9 + (value - 1)] = 0;
    } else {
        noteInProcess[mCellToArrayIndex(cellX,cellY,x,y)*9 + (value - 1)] = value;
    }
}

-(int*)getCurrentNote:( UInt32 )cellX andCellY:( UInt32 )cellY
               xIndex:( UInt32 )x yIndex:( UInt32 )y
{
    return &noteInProcess[mCellToArrayIndex(cellX,cellY,x,y)*9];
}

-(BOOL)isConflicted:(UInt32)cellX andCellY:(UInt32)cellY
             xIndex:(UInt32)x yIndex:(UInt32)y {
    return _isPlayerPuzzleConflicted[mCellToArrayIndex(cellX,cellY,x,y)];
}

-(BOOL)checkValueConflictAtCell:( UInt32 )cellX andCellY:( UInt32 )cellY xIndex:( UInt32 )x yIndex:( UInt32 )y value:(int)value setFlag:(BOOL)check
{
    BOOL isConflicted = FALSE;
    for(int x1 = 0; x1<3;x1++) {
        for(int y1=0;y1<3;y1++) {
            int value1 = _playerPuzzleInProgress[ mCellToArrayIndex(cellX,cellY,x1,y1) ];
            if( value == value1 && (x !=x1 || y!=y1))
            {
                if(check) {
                    _isPlayerPuzzleConflicted[mCellToArrayIndex(cellX,cellY,x,y)] = TRUE;
                    _isPlayerPuzzleConflicted[mCellToArrayIndex(cellX,cellY,x1,y1)] = TRUE;
                }
                isConflicted = TRUE;
            }
        }
    }
    
    for(int cellY1=0;cellY1<3;cellY1++) {
        for(int y1=0;y1<3;y1++) {
            int value1 = _playerPuzzleInProgress[ mCellToArrayIndex(cellX,cellY1,x,y1) ];
            if( value == value1 && (cellY !=cellY1 || y!=y1))
            {
                if(check) {
                    _isPlayerPuzzleConflicted[mCellToArrayIndex(cellX,cellY,x,y)] = TRUE;
                    _isPlayerPuzzleConflicted[mCellToArrayIndex(cellX,cellY1,x,y1)] = TRUE;
                }
                isConflicted = TRUE;
            }
        }
    }
    
    for(int cellX1=0;cellX1<3;cellX1++) {
        for(int x1=0;x1<3;x1++) {
            int value1 = _playerPuzzleInProgress[ mCellToArrayIndex(cellX1,cellY,x1,y) ];
            if( value == value1 && (cellX !=cellX1 || x!=x1))
            {
                if(check) {
                    _isPlayerPuzzleConflicted[mCellToArrayIndex(cellX,cellY,x,y)] = TRUE;
                    _isPlayerPuzzleConflicted[mCellToArrayIndex(cellX1,cellY,x1,y)] = TRUE;
                }
                isConflicted = TRUE;
            }
        }
    }
    return isConflicted;
}
-(BOOL)checkConflicts {
    memset(_isPlayerPuzzleConflicted, FALSE, 81);
    BOOL isConflicted = FALSE;
    for(int cellX =0; cellX<3; cellX++) {
        for(int cellY = 0; cellY<3;cellY++) {
            for(int x = 0; x<3;x++) {
                for(int y=0; y<3;y++) {
                    int value = _playerPuzzleInProgress[ mCellToArrayIndex(cellX,cellY,x,y) ];
                    if(_isPlayerPuzzleConflicted[mCellToArrayIndex(cellX,cellY,x,y)] == FALSE && value > 0) {
                        isConflicted = [self checkValueConflictAtCell:cellX andCellY:cellY xIndex:x yIndex:y value:value setFlag:TRUE];
                    }
                }
            }
        }
    }

    return isConflicted;
}

-(BOOL)undoCurrentValue {
    if (_stack->size()) {
        struct step s = _stack->top();
        _playerPuzzleInProgress[s.index]=s.value;
        _stack->pop();
        
        [self checkConflicts];
        
        return TRUE;
        
    } else {
        return FALSE;
    }
}

+(SudokuModel*)sharedModel
{
    if (gSharedModel == nil)
    {
        gSharedModel = [[SudokuModel alloc] init];
    }
    return gSharedModel;
}

-(UInt32)getOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY
                          xIndex:(UInt32)x yIndex:(UInt32)y
{
    int* puzzle = _sudokuBoard->getPuzzle();
    
    return( puzzle[ mCellToArrayIndex( cellX, cellY, x, y) ] );
}

-( BOOL )isOriginalValueAtCellX:( UInt32 )cellX andCellY:( UInt32 )cellY
                         xIndex:( UInt32 )x yIndex:( UInt32 )y
{
    if ([self getOriginalValueAtCellX: cellX andCellY: cellY xIndex: x yIndex: y] != 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL)isPuzzleSolved
{
    return ( memcmp( _playerPuzzleInProgress, _sudokuBoard->getSolution(), 81 * sizeof(int) ) == 0 );
}

-(void)resetWithDifficulty:(SudokuBoard::Difficulty)level
{
    if (_sudokuBoard)
    {
        delete _sudokuBoard;
    }
    
    _sudokuBoard = new SudokuBoard();
    
    _sudokuBoard->setRecordHistory(true);
    
    bool haveLevelPuzzle = false;
    
    NSLog(@"Generating Sudoku (level=%d)...",level);
    
    while (haveLevelPuzzle == false)
    {
        bool havePuzzle = _sudokuBoard->generatePuzzle();
        
        if (havePuzzle)
        {
            bool haveSolution = _sudokuBoard->solve();
            
            if ((haveSolution) && ((level == SudokuBoard::UNKNOWN) || (_sudokuBoard->getDifficulty() == level)))
            {
                haveLevelPuzzle = true;
            }
        }
    }
    
    NSLog(@"...done!");
    
    memcpy(_playerPuzzleInProgress,_sudokuBoard->getPuzzle(),81*sizeof(int));
    
    //    memcpy(_playerPuzzleInProgress,_sudokuBoard->getSolution(),81*sizeof(int));
    //    _playerPuzzleInProgress[2]=0;
    
    _sudokuBoard->printPuzzle();
    memset(_isPlayerPuzzleConflicted, FALSE, 81);
    if(_stack) {
        while(!_stack->empty()) {
            _stack->pop();
        }
    }
    memset(noteInProcess, 0, 81*9*sizeof(int));
    //        _sudokuBoard->printSolution();
    
    

}

@end
