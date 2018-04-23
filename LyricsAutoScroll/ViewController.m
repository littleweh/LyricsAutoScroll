//
//  ViewController.m
//  LyricsAutoScroll
//
//  Created by Ada Kao on 19/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+Height.h"

@interface ViewController ()
@property (strong, nonatomic, readwrite) UIScrollView *scrollView;
@property (weak, nonatomic, readwrite) NSTimer *timer;
@property (assign, nonatomic, readwrite) NSInteger counter;
@property (assign, nonatomic, readwrite) NSInteger numberOfLines;

@end

@implementation ViewController

// ToDo: MVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *lyrics = [NSMutableArray arrayWithObjects:@"Re重迴 - 何瑞康", @"詞 / 曲: 何瑞康", @"有ㄧ種去別的地方開始重新生活一樣", @"關上那些早已習慣卻放不下的許多許多", @"還沒完全失去卻已經開始努力地遺忘", @"沒了畫面沒了聲音沒了爭執也沒了原諒", @"直到某一天", @"生活的浪打在背上", @"痛得忘了原本的傷", @"直到某一天", @"各自的夜有了各自的家", @"誰的溫暖溫暖了誰的肩膀", @"日子一天一天迴圈", @"卻沒有一件事能真的重來一遍", @"退路一步一步走偏", @"已經失去過的又再失去一遍", @"一再地返回起點", @"直到某一天", @"生活的浪打在背上", @"痛得忘了原本的傷", @"直到某一天", @"各自的夜有了各自的家", @"誰的溫暖溫暖了誰的肩膀", nil];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  self.view.frame.size.width,
                                                                  self.view.frame.size.height)];
    [self.view addSubview:self.scrollView];
    [self setupScrollView];
    
    CGFloat scrollViewContentSizeHeight = [self heightForLyricsTextLayersWithLyrcis:lyrics fontSize:30.0];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, scrollViewContentSizeHeight);
    
    // ToDo: use lyrics.count ?
    self.counter = self.scrollView.layer.sublayers.count;
    self.numberOfLines = self.counter;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                  target:self
                                                selector:@selector(showLyrics)
                                                userInfo:nil
                                                 repeats:YES];
    
}

-(void)showLyrics {
    // ToDo: rewrite autoscroll logic if-else statement
    NSInteger minUpLines = 3;
    NSInteger scrollViewCenterY = self.scrollView.frame.size.height / 2;
    
    if (self.counter <= 0) {
        [self.timer invalidate];
        NSLog(@"timer retired");
    } else {
        NSInteger layerNum = self.numberOfLines - self.counter;
        if (layerNum < self.numberOfLines) {
            CALayer *layer = self.scrollView.layer.sublayers[layerNum];
            layer.backgroundColor = [UIColor grayColor].CGColor;
            if (scrollViewCenterY < layer.position.y
                && layerNum > minUpLines) {
                CGPoint contentOffset = self.scrollView.contentOffset;
                CGFloat newY = layer.position.y - scrollViewCenterY;
                contentOffset.y = newY;
                [self.scrollView setContentOffset:contentOffset];
                
            }
            
            if (layerNum > 0) {
                self.scrollView.layer.sublayers[layerNum -1].backgroundColor = [UIColor blackColor].CGColor;
            }
        }
    }
    self.counter--;
}

-(void)dealloc {
    [self.timer invalidate];
    NSLog(@"%@ dealloc@", NSStringFromClass([self class]) );
}

// ToDo: rename or MVC, return height and add TextLayer should be separate

-(CGFloat) heightForLyricsTextLayersWithLyrcis: (NSMutableArray*) lyrics fontSize: (CGFloat) fontSize {
    CGPoint originalPointInLine = CGPointZero;
    CGFloat lineSpacing = 1.4;
    CGFloat width = self.scrollView.frame.size.width;

    for (int i = 0; i < lyrics.count; i++) {
        NSString *lyricsText = lyrics[i];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  width,
                                                                  self.scrollView.frame.size.height)];
        [label setText:lyricsText];
        [label setFont:[UIFont systemFontOfSize:fontSize]];
        CGSize sizeFromLineBreakWrappedLabel = [label sizeForWrappedText];
        
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.frame = CGRectMake(originalPointInLine.x,
                                     originalPointInLine.y,
                                     width,
                                     lineSpacing * sizeFromLineBreakWrappedLabel.height);
        
        textLayer.string = lyricsText;
        
        textLayer.font = (__bridge CFTypeRef)@"Helvetica";
        textLayer.fontSize = fontSize;
        textLayer.foregroundColor = [UIColor whiteColor].CGColor;
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.wrapped = YES;
        
        [self.scrollView.layer addSublayer:textLayer];
        
        originalPointInLine.y += textLayer.frame.size.height ;
    }
    return originalPointInLine.y;
}

// MARK: UI setup

-(void)setupScrollView {
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.scrollView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                              toItem:self.view.layoutMarginsGuide
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:100.0];

    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.scrollView
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                              toItem:self.view.layoutMarginsGuide
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:-100.0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.scrollView
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0
                                                                constant:0.0];

    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.scrollView
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0
                                                            constant:0.0];

    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.scrollView
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1.0
                                                                constant:0.0];
    
    [self.view addConstraint:top];
    [self.view addConstraint:bottom];
    [self.view addConstraint:centerY];
    [self.view addConstraint:leading];
    [self.view addConstraint:trailing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
