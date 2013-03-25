//
//  SudokuiOSView.h
//  Sudoku
//
//  Created by Rishi Kapadia on 3/22/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SudokuiOSViewController;

@interface SudokuiOSView : UIView
{
@private
    NSString* winStatus;
    BOOL gameOver;
    /*
    UInt32 _selectionCellX;
    UInt32 _selectionCellY;
    UInt32 _selectionX;
    UInt32 _selectionY;
    BOOL _haveSelection;
     */
}

@property (assign, nonatomic) IBOutlet SudokuiOSViewController* _viewController;

-(void)giveUp;
-(void)newGame;

@end
