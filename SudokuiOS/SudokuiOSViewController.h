//
//  SudokuiOSViewController.h
//  SudokuiOS
//
//  Created by Rishi Kapadia on 3/22/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SudokuiOSModel.h"
#import "SudokuiOSView.h"

@interface SudokuiOSViewController : UIViewController
{
@private
    SudokuiOSModel* _model;
    SudokuiOSView* _myView;
    UIButton* menu;
    UIButton* simple;
    UIButton* easy;
    UIButton* intermediate;
    UIButton* expert;
    UILabel* _chooseDifficulty;
    UILabel* _sudoku;
    UILabel* _level;
    UIButton* _giveUp;
}

@property (retain) SudokuiOSModel* _model;
@property (assign, nonatomic) IBOutlet SudokuiOSView* _myView;
@property (assign, nonatomic) IBOutlet UIButton* menu;
@property (assign, nonatomic) IBOutlet UIButton* simple;
@property (assign, nonatomic) IBOutlet UIButton* easy;
@property (assign, nonatomic) IBOutlet UIButton* intermediate;
@property (assign, nonatomic) IBOutlet UIButton* expert;
@property (assign, nonatomic) IBOutlet UILabel* _chooseDifficulty;
@property (assign, nonatomic) IBOutlet UILabel* _sudoku;
@property (assign, nonatomic) IBOutlet UILabel* _level;
@property (assign, nonatomic) IBOutlet UIButton* _giveUp;

-(IBAction)simpleClicked:(UIButton *)sender;
-(IBAction)easyClicked:(UIButton *)sender;
-(IBAction)intermediateClicked:(UIButton *)sender;
-(IBAction)expertClicked:(UIButton *)sender;
-(IBAction)menuClicked:(UIButton *)sender;
-(IBAction)giveUpClicked:(UIButton *)sender;

/*
@property (assign, nonatomic) SudokuiOSModel* _model;
@property (assign, nonatomic) IBOutlet SudokuiOSView* _view;
*/
-(UInt32)getOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(UInt32)getCurrentValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(void)setCurrentValue:(UInt32)value atCellX:(UInt32)cellX andCellY:(UInt32)cellY xIndex:(UInt32)x yIndex:(UInt32)y;

-(BOOL)isOriginalValueAtCellX:(UInt32)cellX andCellY:(UInt32)cellY
                       xIndex:(UInt32)x yIndex:(UInt32)y;

-(BOOL)isPuzzleSolved;

//-(IBAction)menuSelected:(UIButton*)sender;
-(void)redrawWindow;

@end
