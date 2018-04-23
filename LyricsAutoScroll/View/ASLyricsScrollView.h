//
//  ASLyricsScrollView.h
//  LyricsAutoScroll
//
//  Created by Ada Kao on 23/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^animationBlock) (CGRect bounds, CGFloat newY);

@interface ASLyricsScrollView : UIScrollView
@property (assign, nonatomic, readonly) NSInteger textLayersCount;
-(void) addTextLayersWithLyrics: (NSMutableArray *) lyrics font: (UIFont*) font;
-(void) scrollLyricsWithCounter: (NSInteger) counter lineNumber: (NSInteger) lineNumber animationBlock: (animationBlock) animationHandler;
@end
