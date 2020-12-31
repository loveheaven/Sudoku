//
//  NineGridButton.m
//  Sudoku
//
//  Created by William Zheng on 2021/1/5.
//  Copyright © 2021 Rishi Kapadia. All rights reserved.
//

#include "NineGridButton.h"

@implementation NineGridButton : NSControl

const int _numberButtonMatrix[9] = {7,8,9,4,5,6,1,2,3};
@synthesize borderWidth;
@synthesize backgroundHoverColor;
@synthesize backgroundActiveColor;
@synthesize fontActiveColor;
@synthesize fontColor;
@synthesize numberFont;


-(void)paintSelectionNumberRectangle
{
    if(_selectionNumberY == -1 || _selectionNumberX == -1) return;
    CGFloat thirdWidth = _numberButtonAreaRect.size.width / 3.0;
    CGFloat thirdHeight = _numberButtonAreaRect.size.height / 3.0;
    
    if(_mouseDown) {
        [self.backgroundActiveColor setFill];
    } else {
        [self.backgroundHoverColor setFill];
    }
    
    NSRect selectionRect = NSMakeRect(_numberButtonAreaRect.origin.x + _selectionNumberX * thirdWidth,
                                      _numberButtonAreaRect.origin.y + _selectionNumberY* thirdHeight,
                                      thirdWidth, thirdHeight);
    NSBezierPath* selectionPath = [NSBezierPath bezierPathWithRect: selectionRect];
    [selectionPath fill];
}

- (void)setup {
    // Setup layer
    self.backgroundHoverColor = [NSColor colorWithCalibratedRed:102/255.0 green:204/255.0 blue:255/255.0 alpha:0.2];
    self.backgroundActiveColor = self.backgroundHoverColor;
    self.borderWidth = 0.5;
    CGFloat fontSize = 32;
    //NSFont *font = [NSFont fontWithName:@"American Typewriter" size:thirdHeight/2.0];
    self.numberFont = [NSFont fontWithName:@"Arial" size:fontSize];
    self.fontColor = [NSColor grayColor];
    self.fontActiveColor = [NSColor orangeColor];
    
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
        
        
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self setup];
        
    }
    return self;
}

- (void)awakeFromNib {
    
    //setup code
    
    CGFloat w = MIN(self.bounds.size.width, self.bounds.size.height);
    
    
    
    
    _mouseDown = FALSE;
    _numberButtonAreaRect = NSMakeRect(0, 0 , w, w) ;
    
    _numberButtonTrackingArea = [[NSTrackingArea alloc] initWithRect:_numberButtonAreaRect
                                                             options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow )
                                                               owner:self userInfo:nil];
    [self addTrackingArea:_numberButtonTrackingArea];
    _selectionNumberX = -1;
    _selectionNumberY = -1;
    
    CGFloat fontSize = 32;
    //NSFont *font = [NSFont fontWithName:@"American Typewriter" size:thirdHeight/2.0];
    self.numberFont = [NSFont fontWithName:@"Arial" size:fontSize];
    
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor darkGrayColor] set];
    NSRect bounds = _numberButtonAreaRect;
    
    NSFrameRectWithWidth(bounds, 0.5);
    [Utility drawHashInBounds: bounds usingColor: [NSColor darkGrayColor] lineWidth:0.5];
    
    [self paintSelectionNumberRectangle];
    
    
    CGFloat thirdWidth = bounds.size.width / 3.0;
    CGFloat thirdHeight = bounds.size.height / 3.0;
    CGFloat fontSize = 32;
    numberFont = [NSFont fontWithName:@"Arial" size:fontSize];
    
    for (int y=0; y<3; y++)
    {
        for (int x=0; x<3; x++)
        {
            int value = _numberButtonMatrix[y*3+x];
            
            NSColor* color = ((value == self.clickedNumber) && _mouseDown)? self.fontActiveColor: self.fontColor;
            
            NSString* valueString = [NSString stringWithFormat:@"%c",(char)value+'0'];
            NSRect valueDrawRect = NSMakeRect(bounds.origin.x + x * thirdWidth,
                                              bounds.origin.y + y * thirdHeight, thirdWidth, thirdHeight);
            
            [Utility drawNumberString: color :numberFont :valueDrawRect :valueString];
            
        }
    }
}

- (void)updateTrackingAreas {
    
}

- (void)mouseEntered:(NSEvent *)theEvent {
    
}

- (void)mouseMoved:(NSEvent *)theEvent {
    NSPoint location = [theEvent locationInWindow];
    location = [self convertPoint:location fromView:nil];
    
    int nowX = (location.x - _numberButtonAreaRect.origin.x) *3 / _numberButtonAreaRect.size.width;
    int nowY = (location.y - _numberButtonAreaRect.origin.y) *3 / _numberButtonAreaRect.size.height;
    if (nowX != _selectionNumberX || nowY != _selectionNumberY) {
        _selectionNumberX = nowX;
        _selectionNumberY = nowY;
        [self setNeedsDisplayInRect:_numberButtonAreaRect];
        [self displayIfNeeded];
    }
    //NSLog(@"%d,%d, location:%f, %f, event:%ld, %ld!!!", nowX, nowY, location.x, location.y, theEvent.absoluteX, theEvent.absoluteY);
    
}

- (void)mouseExited:(NSEvent *)theEvent {
    _selectionNumberX = -1;
    _selectionNumberY = -1;
    _mouseDown = FALSE;
    [self setNeedsDisplayInRect:_numberButtonAreaRect];
    [self displayIfNeeded];
}


-(void)mouseUp:(NSEvent *)event
{
    _mouseDown = FALSE;
    [self setNeedsDisplay: YES];
}
-(void)mouseDown:(NSEvent *)event
{
    NSPoint location = [event locationInWindow];
    location = [self convertPoint:location fromView:nil];
    _mouseDown = FALSE;
    if(NSPointInRect(location, _numberButtonAreaRect) ) {
        //&& _haveSelection
        int x = (location.x - _numberButtonAreaRect.origin.x) *3 / _numberButtonAreaRect.size.width;
        int y = (location.y - _numberButtonAreaRect.origin.y) *3 / _numberButtonAreaRect.size.height;
        _clickedNumber = _numberButtonMatrix[y*3+x];
        [NSApp sendAction: [self action] to: [self target] from: self];
        //        if(_buttonClick != nil) {
        //            _buttonClick(_numberButtonMatrix[y*3+x]);
        //        }
        //        if ([_clickDelegate respondsToSelector:@selector(setClickNumber)])
        //        {
        //            
        //            [_clickDelegate setClickNumber:_numberButtonMatrix[y*3+x]];
        //        }
        _mouseDown = TRUE;
        
    }
    
    [self setNeedsDisplay: YES];
}
@end
