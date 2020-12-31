//
//  NineGridButton.h
//  Sudoku
//
//  Created by William Zheng on 2021/1/5.
//  Copyright © 2021 Rishi Kapadia. All rights reserved.
//

#ifndef NineGridButton_h
#define NineGridButton_h

//
//  SudokuView.h
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "Util.h"

//@protocol NineGridClickDelegate
//
//-(void) setClickNumber:(int)number;
//@end

@interface NineGridButton : NSControl
{
@private
    
    
    NSRect _numberButtonAreaRect;
    NSTrackingArea* _numberButtonTrackingArea;
    UInt32 _selectionNumberX;
    UInt32 _selectionNumberY;
    BOOL _mouseDown;
    
    
}

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;                // Default:0.0  - Button's border width
@property (nonatomic, strong) IBInspectable NSColor *backgroundHoverColor;         // Default:nil  - Button's backgroud color when mouse hovers.
@property (nonatomic, strong) IBInspectable NSColor *backgroundActiveColor;         // Default:nil  - Button's backgroud color when mouse hovers.
@property (nonatomic, strong) IBInspectable NSColor *fontColor;         // Default:nil  - Button's font color when state off
@property (nonatomic, strong) IBInspectable NSColor *fontActiveColor;         // Default:nil  - Button's font color when state on
@property (nonatomic, strong) IBInspectable NSFont *numberFont;         // Default:nil  - Button's font when state off
//@property (nonatomic, copy) void(^buttonClick)(int number);
//@property (nonatomic, strong) id <NineGridClickDelegate> clickDelegate;
@property (nonatomic, assign) int clickedNumber;
@end

#endif /* NineGridButton_h */
