//
//  UILabel+Height.m
//  LyricsAutoScroll
//
//  Created by Ada Kao on 20/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "UILabel+Height.h"

// sources: https://stackoverflow.com/questions/47772963/catextlayer-number-of-lines
@implementation UILabel (Height)

-(CGSize) sizeForWrappedText {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, CGFLOAT_MAX)];
    label.numberOfLines = 0;
    label.font = self.font;
    label.text = self.text;
    [label sizeToFit];
    return label.frame.size;
}

@end
