//
//  XRUnderlineButton.m
//  私人专科医生
//
//  Created by joanfen on 14-9-10.
//  Copyright (c) 2014年 Appcoda. All rights reserved.
//

#import "XRUnderlineButton.h"

@implementation XRUnderlineButton

+ (XRUnderlineButton *) underlinedButton {
    XRUnderlineButton* button = [[XRUnderlineButton alloc] init];
    return button ;
}

- (void) drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    
    // need to put the line at top of descenders (negative value)
    CGFloat descender = self.titleLabel.font.descender+2;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // set to same colour as text
    CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender);
    
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender);
    
    CGContextClosePath(contextRef);
    
    CGContextDrawPath(contextRef, kCGPathStroke);
}


@end
