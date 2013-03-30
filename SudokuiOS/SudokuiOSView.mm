//
//  SudokuiOSView.m
//  Sudoku
//
//  Created by Rishi Kapadia on 3/22/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "SudokuiOSView.h"
#import "SudokuiOSViewController.h"

@interface SudokuiOSView (hidden)

-(CGRect)drawHashInBounds:(CGRect)bounds usingColor:(UIColor*)color;
//-(void)paintSelectionRectangle;
-(void)drawValueAtCellX:(int)cellX andCellY:(int)cellY inBounds:(CGRect)bounds;

@end

@implementation SudokuiOSView (hidden)
/*
-(void)paintSelectionRectangle
{
    CGFloat thirdWidth = self.bounds.size.width / 3.0;
    CGFloat thirdHeight = self.bounds.size.height / 3.0;
    CGFloat ninthWidth = thirdWidth / 3.0;
    CGFloat ninthHeight = thirdHeight / 3.0;
    
    CGRect selectionRect = CGMakeRect(_selectionCellX * thirdWidth + _selectionX * ninthWidth,
                                      _selectionCellY * thirdHeight + _selectionY * ninthHeight,
                                      ninthWidth, ninthHeight);
    
    UIColor* selectionColor = [UIColor colorWithSRGBRed: 0.0 green: 0.0 blue: 1.0
                                                  alpha: 0.5];
    [selectionColor setFill];
    
    UIBezierPath* selectionPath = [UIBezierPath bezierPathWithRoundedRect: selectionRect
                                                                  xRadius: ( ninthWidth / 4.0 )
                                                                  yRadius: ( ninthHeight / 4.0 )];
    [selectionPath fill];
}
*/
-(CGRect)drawHashInBounds:(CGRect)bounds usingColor:( UIColor* )color
{
    CGFloat top = bounds.origin.y;
    CGFloat bottom = top + bounds.size.height;
    CGFloat left = bounds.origin.x;
    CGFloat right = left + bounds.size.width;
    
    CGFloat thirdWidth = bounds.size.width / 3.0;
    CGFloat thirdHeight = bounds.size.height / 3.0;
    CGFloat lineWidth = ( thirdWidth > thirdHeight ) ? thirdWidth / 30.0 : thirdHeight / 30.0;
    
    UIBezierPath* framePath = [UIBezierPath bezierPath];
    
    [framePath moveToPoint: CGPointMake(left + thirdWidth,top)];
    [framePath addLineToPoint: CGPointMake(left + thirdWidth,bottom)];
    [framePath moveToPoint: CGPointMake(right - thirdWidth,top)];
    [framePath addLineToPoint: CGPointMake(right - thirdWidth,bottom)];
    [framePath moveToPoint: CGPointMake(left,top + thirdHeight)];
    [framePath addLineToPoint: CGPointMake(right,top + thirdHeight)];
    [framePath moveToPoint: CGPointMake(left,bottom - thirdHeight)];
    [framePath addLineToPoint: CGPointMake(right,bottom - thirdHeight)];
    
    [color setStroke];
    
    [framePath setLineWidth: lineWidth];
    
    [framePath stroke];
    
    return( CGRectMake( bounds.origin.x, bounds.origin.y, thirdWidth, thirdHeight ) );
}

-(void)drawValueAtCellX:(int)cellX andCellY:(int)cellY inBounds:(CGRect)bounds
{
    if (self._viewController._model)
    {
        CGFloat thirdWidth = bounds.size.width / 3.0;
        CGFloat thirdHeight = bounds.size.height / 3.0;
        
        for (int y=0; y<3; y++)
        {
            for (int x=0; x<3; x++)
            {
                int value = [self._viewController getCurrentValueAtCellX:cellX andCellY:cellY
                                                                    xIndex:x yIndex:y];
                
                if ( value != 0 )
                {
                    CGPoint valueDrawPosition = CGPointMake(bounds.origin.x + x * thirdWidth + thirdWidth / 3,
                                                            bounds.origin.y + y * thirdHeight + thirdHeight / 6);
                    
                    NSString* valueString = [NSString stringWithFormat:@"%c",(char)value+'0'];
                    UIFont *font = [UIFont fontWithName:@"American Typewriter" size:thirdHeight/2.0*1.5];
                    
                    UIColor* color;
                    if ([self._viewController isOriginalValueAtCellX:cellX andCellY:cellY xIndex:x yIndex:y])
                    {
                        color = [UIColor blackColor];
                    }
                    else
                    {
                        color = [UIColor blueColor];
                    }
                    
                    //NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, color, NSForegroundColorAttributeName, nil];
                    [color set];
                    [valueString drawAtPoint:valueDrawPosition withFont:font];
                    //[valueString drawAtPoint:valueDrawPosition withAttributes:attrsDictionary];
                }
            }
        }
    }
}

@end

@implementation SudokuiOSView

@synthesize _viewController;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (gameOver)
    {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGFloat thirds = self.bounds.size.width / 3;
    CGFloat ninths = thirds / 3;
    
    UInt32 _selectionCellX = (UInt32)(location.x / thirds);
    UInt32 _selectionCellY = (UInt32)(location.y / thirds);
    UInt32 _selectionX = (UInt32)((location.x - (_selectionCellX * thirds)) / ninths);
    UInt32 _selectionY = (UInt32)((location.y - (_selectionCellY * thirds)) / ninths);
    
    UInt32 value = [_viewController getCurrentValueAtCellX:_selectionCellX andCellY:_selectionCellY xIndex:_selectionX yIndex:_selectionY];
    value = value + 1;
    if (value > 9)
        value = value - 10;
    
    [_viewController setCurrentValue:value atCellX:_selectionCellX andCellY:_selectionCellY xIndex:_selectionX yIndex:_selectionY];
    
    if ([_viewController isPuzzleSolved])
        gameOver = YES;
        
    [self setNeedsDisplay];
    [_viewController redrawWindow];
}


- (id)init
{
    self = [super init];
    if (self)
    {
        winStatus = @"SOLVED!";
        gameOver = NO;
    }
    return self;
}

-(void) dealloc
{
    [_viewController release];
    [super dealloc];
}

/*
@synthesize _windowController;
*/
- (void)drawRect:(CGRect)dirtyRect
{
    CGRect oneSquareBounds = [self drawHashInBounds:self.bounds usingColor:[UIColor blackColor]];
    for (UInt32 y = 0; y < 3; y++)
    {
        for (UInt32 x = 0; x < 3; x++)
        {
            CGRect smallBounds = CGRectOffset(oneSquareBounds, x * oneSquareBounds.size.width, y * oneSquareBounds.size.height );
            
            smallBounds = CGRectInset(smallBounds, 4.0, 4.0);
            
            [self drawHashInBounds: smallBounds usingColor: [UIColor lightGrayColor]];
            [self drawValueAtCellX:x andCellY:y inBounds:smallBounds];
        }
    }
    
    if ([_viewController isPuzzleSolved])
    {
        gameOver = YES;
        NSInteger fourth = self.bounds.size.height / 4;
        
        UIColor* winColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.33];
        
        UIFont *font = [UIFont fontWithName:@"Zapfino" size:50];
        
        //NSDictionary* attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, winColor, NSForegroundColorAttributeName, [NSNumber numberWithDouble:16.0], NSStrokeWidthAttributeName, nil];
        
        [winColor set];
        
        CGPoint solvedDrawPosition = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + fourth);
        
        [winStatus drawAtPoint:solvedDrawPosition withFont:font];
         //drawAtPoint:solvedDrawPosition withAttributes:attrsDictionary];
        winStatus = @"SOLVED!";
    }
}

-(void)giveUp
{
    winStatus = @"FAIL!";
}

-(void)newGame
{
    gameOver = NO;
}

/*
-(void)mouseDown:(UIEvent *)event
{
    CGPoint location = [event ];
    CGFloat thirds = self.bounds.size.width / 3;
    CGFloat ninths = thirds / 3;
    
    _selectionCellX = (UInt32)(location.x / thirds);
    _selectionCellY = (UInt32)(location.y / thirds);
    _selectionX = (UInt32)((location.x - (_selectionCellX * thirds)) / ninths);
    _selectionY = (UInt32)((location.y - (_selectionCellY * thirds)) / ninths);
    
    if ([self._viewController
         isOriginalValueAtCellX:_selectionCellX
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
    
    [self setNeedsDisplay: YES];
}

- (void)keyDown:(UIEvent *)theEvent
{
    BOOL handled = NO;
    if (_haveSelection)
    {
        NSString *theChars = [theEvent charactersIgnoringModifiers];
        unichar keyChar = [theChars characterAtIndex:0];
        if (keyChar>='1' && keyChar <='9')
        {
            [self._viewController setCurrentValue:keyChar-'0'
                                            atCellX:_selectionCellX
                                           andCellY:_selectionCellY
                                             xIndex:_selectionX
                                             yIndex:_selectionY];
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
*/
- (BOOL) acceptsFirstResponder
{
    return ( YES );
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
