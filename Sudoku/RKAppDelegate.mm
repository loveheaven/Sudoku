//
//  RKAppDelegate.m
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKAppDelegate.h"
#import "SudokuModel.h"

@interface RKAppDelegate (hidden)

-(void)setUpDifficultyMenu;

@end

@implementation RKAppDelegate

-(id)init
{
    self = [super init];
    
    if (self != nil)
    {
        _playerWindowController = [[SudokuWindowController alloc] init];
        [_playerWindowController.window setTitle:@"Player"];
        [_playerWindowController.window makeKeyAndOrderFront:nil];
    }
    return self;
}

- (void)dealloc
{
    [_playerWindowController release];
    [super dealloc];
}

-(void)setUpDifficultyMenu
{
    NSMenu* mainMenu = [NSApp mainMenu];
    NSMenuItem* viewMenu = [mainMenu itemWithTitle:@"View"];
    [mainMenu removeItem:viewMenu];
    NSMenuItem* difficultyTopMenuItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"Difficulty" action:nil keyEquivalent:@""];
    
    NSMenu* difficultyTopMenu = [[NSMenu alloc] initWithTitle:@"Difficulty"];
    [difficultyTopMenuItem setSubmenu:difficultyTopMenu];
    [mainMenu insertItem:difficultyTopMenuItem atIndex:4];
    
    NSMenuItem* difficultyMenuItem = [[NSMenuItem allocWithZone: [NSMenu menuZone]]
                                      initWithTitle: @"Random"
                                      action: @selector( menuSelected: )
                                      keyEquivalent: @"0"];
    [difficultyMenuItem setTarget: _playerWindowController];
    [difficultyTopMenu addItem: difficultyMenuItem];
    
    [difficultyTopMenu addItem: [NSMenuItem separatorItem]];
    
    difficultyMenuItem = [[NSMenuItem allocWithZone: [NSMenu menuZone]]
                                      initWithTitle: @"Simple"
                                      action: @selector( menuSelected: )
                                      keyEquivalent: @"1"];
    [difficultyMenuItem setTarget: _playerWindowController];
    [difficultyTopMenu addItem: difficultyMenuItem];
    
    difficultyMenuItem = [[NSMenuItem allocWithZone: [NSMenu menuZone]]
                          initWithTitle: @"Easy"
                          action: @selector( menuSelected: )
                          keyEquivalent: @"2"];
    [difficultyMenuItem setTarget: _playerWindowController];
    [difficultyTopMenu addItem: difficultyMenuItem];
    
    difficultyMenuItem = [[NSMenuItem allocWithZone: [NSMenu menuZone]]
                          initWithTitle: @"Intermediate"
                          action: @selector( menuSelected: )
                          keyEquivalent: @"3"];
    [difficultyMenuItem setTarget: _playerWindowController];
    [difficultyTopMenu addItem: difficultyMenuItem];
    
    difficultyMenuItem = [[NSMenuItem allocWithZone: [NSMenu menuZone]]
                          initWithTitle: @"Expert"
                          action: @selector( menuSelected: )
                          keyEquivalent: @"4"];
    [difficultyMenuItem setTarget: _playerWindowController];
    [difficultyTopMenu addItem: difficultyMenuItem];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _playerWindowController = [[SudokuWindowController alloc] initWithWindowNibName:@"SudokuWindow"];
    
    [_playerWindowController.window setTitle:@"Player"];
    [_playerWindowController.window makeKeyAndOrderFront:nil];
    
    [self setUpDifficultyMenu];
}

-(void)redrawWindows
{
    [_playerWindowController redrawWindow];
    [_playerWindowController.window makeKeyAndOrderFront:nil];
}

@end
