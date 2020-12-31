//
//  SudokuView.m
//  Sudoku
//
//  Created by Rishi Kapadia on 3/14/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "SudokuView.h"



@interface SudokuView (hidden)


-(void)paintSelectionRectangle;
-(void)drawPlayAreaRect;
-(void)drawValueAtCellX:(int)cellX andCellY:(int)cellY inBounds:(NSRect)bounds;

@end

@implementation SudokuView (hidden)
 const UInt32 _playAreaOffsetX = 10;
 const UInt32 _playAreaOffsetY = 10;


-(void)paintConflictRectangle:(UInt32)cellX :(UInt32)cellY
{
    CGFloat thirdWidth = _playAreaRect.size.width / 3.0;
    CGFloat thirdHeight = _playAreaRect.size.height / 3.0;
    CGFloat ninthWidth = thirdWidth / 3.0;
    CGFloat ninthHeight = thirdHeight / 3.0;
    
    
    
    NSColor* selectionColor = [NSColor colorWithSRGBRed: 1.0 green: 0.0 blue: 1.0
                                                  alpha: 0.1];
    [selectionColor setFill];
    
    for(int x = 0; x<3;x++) {
        for(int y =0;y<3;y++) {
            if([self._model isConflicted:cellX andCellY:cellY xIndex:x yIndex:y] == TRUE) {
                NSRect selectionRect = NSMakeRect(cellX * thirdWidth + x*ninthWidth +_playAreaOffsetX,
                                                  cellY * thirdHeight + y*ninthHeight + _playAreaOffsetY,
                                                  ninthWidth, ninthHeight);
                selectionRect = NSInsetRect(selectionRect, 1.0, 1.0);
                NSBezierPath* selectionPath = [NSBezierPath bezierPathWithRect: selectionRect];
                [selectionPath fill];
            }
        }
    }
}

-(void)paintSelectionRectangle
{
    CGFloat thirdWidth = _playAreaRect.size.width / 3.0;
    CGFloat thirdHeight = _playAreaRect.size.height / 3.0;
    CGFloat ninthWidth = thirdWidth / 3.0;
    CGFloat ninthHeight = thirdHeight / 3.0;
    
    
    
    NSColor* selectionColor = [NSColor colorWithCalibratedRed:102/255.0 green:204/255.0 blue:255/255.0 alpha:0.2];
    [selectionColor setFill];
    
    //Draw square rectangle
    NSRect selectionRect = NSMakeRect(_selectionCellX * thirdWidth + _playAreaOffsetX,
                                      _selectionCellY * thirdHeight + _playAreaOffsetY,
                                      thirdWidth, thirdHeight);
    NSBezierPath* selectionPath = [NSBezierPath bezierPathWithRect: selectionRect];
    [selectionPath fill];
    
    selectionRect = NSMakeRect(_playAreaRect.origin.x,
                               _selectionCellY * thirdHeight + _selectionY * ninthHeight + _playAreaOffsetY,
                               _playAreaRect.size.width, ninthHeight);
    selectionPath = [NSBezierPath bezierPathWithRect: selectionRect];
    [selectionPath fill];
    
    selectionRect = NSMakeRect(_selectionCellX * thirdWidth + _selectionX *ninthWidth + _playAreaOffsetX,
                               _playAreaRect.origin.y,
                               ninthWidth, _playAreaRect.size.height);
    selectionPath = [NSBezierPath bezierPathWithRect: selectionRect];
    [selectionPath fill];
}




-(void)drawNoteAtRectangle:(UInt32)cellX :(UInt32)cellY
{
    CGFloat thirdWidth = _playAreaRect.size.width / 3.0;
    CGFloat thirdHeight = _playAreaRect.size.height / 3.0;
    CGFloat ninthWidth = thirdWidth / 3.0;
    CGFloat ninthHeight = thirdHeight / 3.0;
    
    CGFloat width27th = ninthWidth / 3.0;
    CGFloat height27th = ninthWidth / 3.0;
    
    CGFloat fontSize = 12;
    //NSFont *font = [NSFont fontWithName:@"American Typewriter" size:thirdHeight/2.0];
    NSFont *font = [NSFont fontWithName:@"Arial" size:fontSize];
    
    NSColor* color  = [Utility getColorFromRGB:51 green:147 blue:255 alpha:1.0];
    
    for(int y = 0; y<3;y++) {
        for(int x=0; x<3;x++) {
//            int value = [self._model getCurrentValueAtCellX:cellX andCellY:cellY
//                                                                xIndex:x yIndex:y];
//            if(value == 0) continue;
    //std::cout<<"===;"<<thirdWidth<<","<<thirdHeight<<","<<width27th<<std::endl;
            int* notes = [self._model getCurrentNote:cellX andCellY:cellY xIndex:x yIndex:y];
            
            for(int i =0;i<9;i++) {
                NSString* valueString = [NSString stringWithFormat:@"%c",(char)notes[i]+'0'];
                if(notes[i] == 0) continue;
                
                int dy=(notes[i]-1) /3;
                int dx = (notes[i]-1) - dy*3;
                if(dy == 2) dy=0; else if(dy==0) dy=2;
                NSRect selectionRect = NSMakeRect(cellX * thirdWidth + x*ninthWidth +_playAreaOffsetX + dx*width27th,
                                                  cellY * thirdHeight + y*ninthHeight + _playAreaOffsetY + dy*height27th,
                                                  width27th, height27th);
                //std::cout<<selectionRect.origin.x<<","<<selectionRect.origin.y<<","<<notes[i]<<","<<dy<<","<<dx<<std::endl;
                [Utility drawNumberString:color :font :selectionRect :valueString];
            }
        }
    }
}

-(void)drawValueAtCellX:(int)cellX andCellY:(int)cellY inBounds:(NSRect)bounds
{
    if (self._model)
    {
        CGFloat thirdWidth = bounds.size.width / 3.0;
        CGFloat thirdHeight = bounds.size.height / 3.0;
        
        for (int y=0; y<3; y++)
        {
            for (int x=0; x<3; x++)
            {
                int value = [self._model getCurrentValueAtCellX:cellX andCellY:cellY
                    xIndex:x yIndex:y];
                
                if ( value != 0 )
                {
                    
                    NSString* valueString = [NSString stringWithFormat:@"%c",(char)value+'0'];
                    
                    CGFloat fontSize = 32;
                    //NSFont *font = [NSFont fontWithName:@"American Typewriter" size:thirdHeight/2.0];
                    NSFont *font = [NSFont fontWithName:@"Arial" size:fontSize];
                    
                    NSColor* color;
                    if ([self._model isOriginalValueAtCellX:cellX andCellY:cellY xIndex:x yIndex:y])
                    {
                        color = [NSColor darkGrayColor];
                    }
                    else
                    {
                        color = [Utility getColorFromRGB:51 green:147 blue:255 alpha:1.0];
                    }
                    NSRect valueDrawRect = NSMakeRect(bounds.origin.x + x * thirdWidth,
                                                            bounds.origin.y + y * thirdHeight, thirdWidth, thirdHeight);
                    
                    [Utility drawNumberString:color :font :valueDrawRect :valueString];
                }
            }
        }
    }
}

- (void)drawPlayAreaRect {
    NSFrameRectWithWidth(_playAreaRect, 2.0);
    NSRect oneSquareBounds = [Utility drawHashInBounds:_playAreaRect usingColor:[NSColor blackColor] lineWidth:2.0];
    
    for (UInt32 cellY = 0; cellY < 3; cellY++)
    {
        for (UInt32 cellX = 0; cellX < 3; cellX++)
        {
            NSRect smallBounds = NSOffsetRect(oneSquareBounds, cellX * oneSquareBounds.size.width, cellY * oneSquareBounds.size.height );
            
            smallBounds = NSInsetRect(smallBounds, 1.0, 1.0);
            
            [Utility drawHashInBounds: smallBounds usingColor: [NSColor darkGrayColor] lineWidth:0.5];
            
            
        }
    }
    if (_haveSelection)
    {
        [self paintSelectionRectangle];
    }
    
    for (UInt32 cellY = 0; cellY < 3; cellY++)
    {
        for (UInt32 cellX = 0; cellX < 3; cellX++)
        {
            NSRect smallBounds = NSOffsetRect(oneSquareBounds, cellX * oneSquareBounds.size.width, cellY * oneSquareBounds.size.height );
        
            smallBounds = NSInsetRect(smallBounds, 1.0, 1.0);
            
            [self paintConflictRectangle:cellX :cellY];
            [self drawValueAtCellX:cellX andCellY:cellY inBounds:smallBounds];
            [self drawNoteAtRectangle:cellX :cellY];
        }
    }
}



@end

//=====================================================

@implementation SudokuView : NSView

@synthesize _model;

- (void)dealloc
{
    [super dealloc];
}

- (void)awakeFromNib {
    _model = [SudokuModel sharedModel];
    //setup code
    NSLog(@"hello there");
    CGFloat w = MIN(self.bounds.size.width, self.bounds.size.height);
    _playAreaRect = NSMakeRect(_playAreaOffsetX, _playAreaOffsetY, w - 2 * _playAreaOffsetX, w - 2 * _playAreaOffsetX);
    _isInNoteMode = FALSE;
}



- (void)drawRect:(NSRect)dirtyRect
{
    
    [self drawPlayAreaRect];
    
    
    
    if ([self._model isPuzzleSolved])
    {
        NSInteger fourth = self.bounds.size.height / 4;
        
        NSColor* winColor = [NSColor colorWithSRGBRed:1.0 green:0.0 blue:0.0 alpha:0.33];
        
        NSFont *font = [NSFont fontWithName:@"Zapfino" size:60];
        
        NSDictionary* attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                         font, NSFontAttributeName, winColor, NSForegroundColorAttributeName,
                                         [NSNumber numberWithDouble:16.0], NSStrokeWidthAttributeName, nil];
        
        NSPoint solvedDrawPosition = NSMakePoint(self.bounds.origin.x, self.bounds.origin.y + fourth);
        
        [@"SOLVED!" drawAtPoint:solvedDrawPosition withAttributes:attrsDictionary];
    }
}


-(void)mouseDown:(NSEvent *)event
{
    NSPoint location = [event locationInWindow];
    CGFloat thirds = _playAreaRect.size.width / 3;
    CGFloat ninths = thirds / 3;
    
    if (NSPointInRect(location, _playAreaRect)) {
        _selectionCellX = (UInt32)((location.x - _playAreaOffsetX) / thirds);
        _selectionCellY = (UInt32)((location.y- _playAreaOffsetY) / thirds);
        _selectionX = (UInt32)((location.x - _playAreaOffsetX - (_selectionCellX * thirds)) / ninths);
        _selectionY = (UInt32)((location.y - _playAreaOffsetY - (_selectionCellY * thirds)) / ninths);
        
        if ([self._model isOriginalValueAtCellX:_selectionCellX
             andCellY:_selectionCellY
             xIndex:_selectionX
             yIndex:_selectionY] == NO)
        {
            _haveSelection = YES;
        }
        else
        {
            _haveSelection = NO;
        }
    }
    
    
    [self setNeedsDisplay: YES];
}

- (void)keyDown:(NSEvent *)theEvent
{
    //NSLog(@"button clicked. %d, %d", theEvent.keyCode, ) ;
    BOOL handled = NO;
    if (_haveSelection)
    {
        NSString *theChars = [theEvent charactersIgnoringModifiers];
        unichar keyChar = [theChars characterAtIndex:0];
        if (keyChar>='1' && keyChar <='9')
        {
            [self._model setCurrentValue:keyChar-'0'
                                            atCellX:_selectionCellX
                                           andCellY:_selectionCellY
                                             xIndex:_selectionX
                                             yIndex:_selectionY];
            handled = YES;
        }
        else if(keyChar == '0' || theEvent.keyCode == 53) {
            [self._model setCurrentValue: 0
                                            atCellX:_selectionCellX
                                           andCellY:_selectionCellY
                                             xIndex:_selectionX
                                             yIndex:_selectionY];
            handled = YES;
        }
    }
    if (theEvent.keyCode ==6 && (theEvent.modifierFlags & NSEventModifierFlagCommand) != 0 ) {
        if([self._model undoCurrentValue]) {
            handled = YES;
        }
    }
    if (handled == NO)
    {
        [super keyDown:theEvent];
    }
    else
    {
        [self setNeedsDisplay:YES];
    }
}

- (BOOL) acceptsFirstResponder
{
    return ( YES );
}






- (IBAction)hintButtonClick:(FlatButton *)sender {
    NSLog(@"hint!!!!!!");
}

- (IBAction)eraseButtonClick:(FlatButton *)sender {
    NSLog(@"erase!!!!!!");
}

- (IBAction)noteButtonClick:(NSButton *)sender {
    _isInNoteMode = !_isInNoteMode;
    NSLog(@"%d", _isInNoteMode);
}

- (IBAction)undoButtonClick:(FlatButton *)sender {
    
    BOOL nonEmpty = [self._model undoCurrentValue];
    if(nonEmpty) {
        [self setNeedsDisplay:YES];
    }
}

- (IBAction)setClickNumber:(NineGridButton *)sender {
    if(_haveSelection) {
        if (_isInNoteMode) {
            [self._model setCurrentNote:sender.clickedNumber
                                 atCellX:_selectionCellX
                                andCellY:_selectionCellY
                                  xIndex:_selectionX
                                  yIndex:_selectionY];
        } else {
            [self._model setCurrentValue:sender.clickedNumber
                             atCellX:_selectionCellX
                            andCellY:_selectionCellY
                              xIndex:_selectionX
                              yIndex:_selectionY];
        }
        [self setNeedsDisplay: YES];
    }
}



- (IBAction)menuSelected:(NSMenuItem*)sender {
    NSString *name = sender.title;
    
    if ([name isEqualToString:@"Simple"])
    {
        [self._model resetWithDifficulty:SudokuBoard::SIMPLE];
    }
    else if ([name isEqualToString:@"Easy"])
    {
        [self._model resetWithDifficulty:SudokuBoard::EASY];
    }
    else if ([name isEqualToString:@"Intermediate"])
    {
        [self._model resetWithDifficulty:SudokuBoard::INTERMEDIATE];
    }
    else if ([name isEqualToString:@"Expert"])
    {
        [self._model resetWithDifficulty:SudokuBoard::EXPERT];
    }
    else // Random
    {
        [self._model resetWithDifficulty:SudokuBoard::UNKNOWN];
    }
    _haveSelection = FALSE;
    
    
    for(NSMenuItem* item in sender.parentItem.submenu.itemArray) {
        [item setState:NSControlStateValueOff];
        [item setAlternate:true];
    }
    [sender setState:NSControlStateValueOn];
    [self setNeedsDisplay:YES];
}



@end
