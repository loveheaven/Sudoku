//
//  Util.h
//  Sudoku
//
//  Created by William Zheng on 2021/1/5.
//  Copyright © 2021 Rishi Kapadia. All rights reserved.
//

#ifndef Util_h
#define Util_h
#import <Cocoa/Cocoa.h>
@interface Utility : NSObject
+( NSRect )drawHashInBounds:( NSRect )bounds usingColor:( NSColor* )color lineWidth:(CGFloat)lineWidth;

+(void)drawNumberString:(NSColor*)color :(NSFont*)font :(NSRect)bounds :(NSString*)valueString;

+(NSColor *)getColorFromRGB:(unsigned char)r green:(unsigned char)g blue:(unsigned char)b alpha:(float)a;

@end
#endif /* Util_h */
