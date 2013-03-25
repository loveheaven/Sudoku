//
//  SudokuModel.m
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "SudokuModel.h"
#import "RKAppDelegate.h"

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
        
        _playerPuzzleInProgress = new int[81];
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
    _playerPuzzleInProgress[ mCellToArrayIndex(cellX,cellY,x,y) ] = value;
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
    
    //        _sudokuBoard->printSolution();
    
    [[NSApp delegate] redrawWindows];

}

@end
