//
//  SudokuiOSViewController.m
//  SudokuiOS
//
//  Created by Rishi Kapadia on 3/22/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "SudokuiOSViewController.h"
//#import "SudokuiOSAppDelegate.h"

@interface SudokuiOSViewController ()

@end

@implementation SudokuiOSViewController

@synthesize _model;
@synthesize _myView;
@synthesize menu;
@synthesize simple;
@synthesize easy;
@synthesize intermediate;
@synthesize expert;
@synthesize _chooseDifficulty;
@synthesize _sudoku;
@synthesize _level;
@synthesize _giveUp;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil)
    {
        _model = [[SudokuiOSModel alloc] init];
        _myView = [[SudokuiOSView alloc] init];
                
        [self menuClicked:menu];
    }
    return self;
}

-(IBAction)simpleClicked:(UIButton *)sender
{
    [_model resetWithDifficulty:SudokuBoard::SIMPLE];
    _level.text = @"Difficulty Level: Simple";
    [self hideMenu];
}

-(IBAction)easyClicked:(UIButton *)sender
{
    [_model resetWithDifficulty:SudokuBoard::EASY];
    _level.text = @"Difficulty Level: Easy";
    [self hideMenu];
}

-(IBAction)intermediateClicked:(UIButton *)sender
{
    [_model resetWithDifficulty:SudokuBoard::INTERMEDIATE];
    _level.text = @"Difficulty Level: Intermediate";
    [self hideMenu];
}

-(IBAction)expertClicked:(UIButton *)sender
{
    [_model resetWithDifficulty:SudokuBoard::EXPERT];
    _level.text = @"Difficulty Level: Expert";
    [self hideMenu];
}

-(void)hideMenu
{
    _myView.hidden = NO;
    _level.hidden = NO;
    menu.hidden = NO;
    _giveUp.hidden = NO;
    
    _chooseDifficulty.hidden = YES;
    simple.hidden = YES;
    easy.hidden = YES;
    intermediate.hidden = YES;
    expert.hidden = YES;
    _sudoku.hidden = YES;
    [_myView setNeedsDisplay];
}

-(IBAction)menuClicked:(UIButton *)sender
{
    [_myView newGame];
    _myView.hidden = YES;
    _level.hidden = YES;
    menu.hidden = YES;
    _giveUp.hidden = YES;
    
    _chooseDifficulty.hidden = NO;
    simple.hidden = NO;
    easy.hidden = NO;
    intermediate.hidden = NO;
    expert.hidden = NO;
    _sudoku.hidden = NO;
}

-(IBAction)giveUpClicked:(UIButton *)sender
{
    if (![self isPuzzleSolved])
    {
        [_model giveUp];
        [_myView giveUp];
        [_myView setNeedsDisplay];
    }
}

/*
@synthesize _model;
@synthesize _view;


- (id)init
{
    self = [super init];
    
    if (self)
    {
        //[self showWindow:self];
    }
    
    return self;
}
*/
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
    if (![_model isOriginalValueAtCellX:cellX andCellY:cellY xIndex:x yIndex:y])
    {
        [self._model setCurrentValue:value atCellX:cellX andCellY:cellY xIndex:x yIndex:y];
        [_myView setNeedsDisplay];
    }
}

-( BOOL )isOriginalValueAtCellX:( UInt32 )cellX andCellY:( UInt32 )cellY
                         xIndex:( UInt32 )x yIndex:( UInt32 )y
{
    return ([_model isOriginalValueAtCellX:cellX andCellY:cellY xIndex:x yIndex:y]);
}

- (void)windowDidLoad
{
    [super viewDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    _model = [SudokuiOSModel sharedModel];
    [_myView setNeedsDisplay];
}

-(BOOL)isPuzzleSolved
{
    return ([_model isPuzzleSolved]);
}

/*
-(IBAction)menuSelected:(UIButton*)sender
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
 
    _view.hide = YES;
    
}
*/
-(void)redrawWindow
{
    [_myView setNeedsDisplay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_model release];
    [_myView release];
    [menu release];
    [simple release];
    [easy release];
    [intermediate release];
    [expert release];
    [_chooseDifficulty release];
    [_sudoku release];
    [_level release];
    [super dealloc];
}
@end
