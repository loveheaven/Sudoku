//
//  Util.m
//  Sudoku
//
//  Created by William Zheng on 2021/1/5.
//  Copyright © 2021 Rishi Kapadia. All rights reserved.
//

#import "Util.h"
@implementation Utility : NSObject

+( NSRect )drawHashInBounds:( NSRect )bounds usingColor:( NSColor* )color lineWidth:(CGFloat)lineWidth
{
    CGFloat top = bounds.origin.y;
    CGFloat bottom = top + bounds.size.height;
    CGFloat left = bounds.origin.x;
    CGFloat right = left + bounds.size.width;
    
    CGFloat thirdWidth = bounds.size.width / 3.0;
    CGFloat thirdHeight = bounds.size.height / 3.0;
    if (lineWidth == 0) {
        lineWidth = ( thirdWidth > thirdHeight ) ? thirdWidth / 30.0 : thirdHeight / 30.0;
    }
    
    NSBezierPath* framePath = [NSBezierPath bezierPath];
    
    [framePath moveToPoint: NSMakePoint(left + thirdWidth,top)];
    [framePath lineToPoint: NSMakePoint(left + thirdWidth,bottom)];
    [framePath moveToPoint: NSMakePoint(right - thirdWidth,top)];
    [framePath lineToPoint: NSMakePoint(right - thirdWidth,bottom)];
    [framePath moveToPoint: NSMakePoint(left,top + thirdHeight)];
    [framePath lineToPoint: NSMakePoint(right,top + thirdHeight)];
    [framePath moveToPoint: NSMakePoint(left,bottom - thirdHeight)];
    [framePath lineToPoint: NSMakePoint(right,bottom - thirdHeight)];
    
    [color setStroke];
    
    [framePath setLineWidth: lineWidth];
    
    [framePath stroke];
    
    return( NSMakeRect( bounds.origin.x, bounds.origin.y, thirdWidth, thirdHeight ) );
}

+(void)drawNumberString:(NSColor*)color :(NSFont*)font :(NSRect)bounds :(NSString*)valueString
{
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                     font, NSFontAttributeName,
                                     color, NSForegroundColorAttributeName,
                                     nil];
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:valueString attributes:attrsDictionary];
    NSSize txtSize = title.size;
    //double topGap = txtSize.height - (font.ascender + fabs(font.descender));
    NSPoint valueDrawPosition = NSMakePoint(bounds.origin.x  + bounds.size.width / 2 - txtSize.width/2,
                                            bounds.origin.y  +bounds.size.height/2  - txtSize.height/2);
    
    //                    NSBezierPath* boundPath = [NSBezierPath bezierPathWithRect: NSMakeRect(bounds.origin.x + x * thirdWidth + thirdWidth / 2, bounds.origin.y + y * thirdHeight +thirdHeight/2, 1, 30)];
    //                    [boundPath setLineWidth: 2.0];
    //                    [boundPath stroke];
    [title drawAtPoint:valueDrawPosition];
}

+(NSColor *)getColorFromRGB:(unsigned char)r green:(unsigned char)g blue:(unsigned char)b alpha:(float)a
{
    CGFloat rFloat = r/255.0;
    CGFloat gFloat = g/255.0;
    CGFloat bFloat = b/255.0;
    
    //  return [NSColor colorWithCalibratedRed:((float)r/255.0) green:((float)g/255.0) blue:((float)b/255.0) alpha:1.0];
    return [NSColor colorWithCalibratedRed:rFloat green:gFloat blue:bFloat alpha:a];
}
@end
