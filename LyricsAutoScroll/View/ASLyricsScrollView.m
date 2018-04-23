//
//  ASLyricsScrollView.m
//  LyricsAutoScroll
//
//  Created by Ada Kao on 23/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "ASLyricsScrollView.h"
#import "UILabel+Height.h"

@interface ASLyricsScrollView()
@property (assign, nonatomic, readwrite) CGFloat lineSpacing;
@end

@implementation ASLyricsScrollView
-(CGFloat) lineSpacing {
    return 1.4;
}

-(void) addTextLayersWithLyrics: (NSMutableArray *) lyrics font: (UIFont*) font {
    CGPoint originalPointInLine = CGPointMake(0, 10);
    CGFloat lyricsScrollViewWidth = self.frame.size.width;
    
    for (int i = 0; i < lyrics.count; i++) {
        NSString *lyricsText = lyrics[i];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  lyricsScrollViewWidth,
                                                                  self.frame.size.height)];
        
        [label setText:lyricsText];
        [label setFont:font];
        CGSize sizeFromLineBreakWrappedLabel = [label sizeForWrappedText];
        
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.frame = CGRectMake(originalPointInLine.x,
                                     originalPointInLine.y,
                                     lyricsScrollViewWidth,
                                     self.lineSpacing * sizeFromLineBreakWrappedLabel.height);
        textLayer.string = lyricsText;
        
        textLayer.font = (__bridge CFTypeRef)font.fontName;
        textLayer.fontSize = font.pointSize;
        textLayer.foregroundColor = [UIColor whiteColor].CGColor;
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.wrapped = YES;
        
        [self.layer addSublayer:textLayer];
        
        originalPointInLine.y += textLayer.frame.size.height;
    }
    [self setContentSize:CGSizeMake(self.frame.size.width, originalPointInLine.y)];
}

-(void) scrollLyricsWithCounter: (NSInteger) counter lineNumber: (NSInteger) lineNumber animationBlock: (animationBlock) animationHandler{
    
    NSAssert(lineNumber <= self.layer.sublayers.count, @"lyrics line number is larger than # of layers in lyricsScrollView");
    
    CGFloat centerY = self.frame.size.height / 2;
    NSInteger layerNumber = lineNumber - counter;
    if (layerNumber < lineNumber) {
        CALayer *layer = self.layer.sublayers[layerNumber];
        layer.backgroundColor = [UIColor grayColor].CGColor;
        if (centerY < layer.position.y) {
            CGRect bounds = self.bounds;
            CGFloat newY = layer.position.y - centerY;
            animationHandler(bounds, newY);
            bounds.origin.y = newY;
            self.bounds = bounds;
        }
        
        if (layerNumber > 0) {
            self.layer.sublayers[layerNumber - 1].backgroundColor = [UIColor blackColor].CGColor;
        }
    }
}

@end
