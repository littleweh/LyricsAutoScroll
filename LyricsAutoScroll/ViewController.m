//
//  ViewController.m
//  LyricsAutoScroll
//
//  Created by Ada Kao on 19/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+Height.h"
#import "ASLyricsScrollView.h"

@interface ViewController ()
//@property (strong, nonatomic, readwrite) UIScrollView *scrollView;
@property (weak, nonatomic, readwrite) NSTimer *timer;
@property (assign, nonatomic, readwrite) NSInteger counter;
@property (assign, nonatomic, readwrite) NSInteger numberOfLines;
@property (nonatomic) CGFloat duration;
@property (strong, nonatomic, readwrite) ASLyricsScrollView *lyricsScrollView;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    NSMutableArray *lyrics = [NSMutableArray arrayWithObjects:@"Re重迴 - 何瑞康", @"詞 / 曲: 何瑞康", @"有ㄧ種去別的地方開始重新生活一樣", @"關上那些早已習慣卻放不下的許多許多", @"還沒完全失去卻已經開始努力地遺忘", @"沒了畫面沒了聲音沒了爭執也沒了原諒", @"直到某一天", @"生活的浪打在背上", @"痛得忘了原本的傷", @"直到某一天", @"各自的夜有了各自的家", @"誰的溫暖溫暖了誰的肩膀", @"日子一天一天迴圈", @"卻沒有一件事能真的重來一遍", @"退路一步一步走偏", @"已經失去過的又再失去一遍", @"一再地返回起點", @"直到某一天", @"生活的浪打在背上", @"痛得忘了原本的傷", @"直到某一天", @"各自的夜有了各自的家", @"誰的溫暖溫暖了誰的肩膀", nil];
    self.numberOfLines = lyrics.count;
   
    self.lyricsScrollView = [[ASLyricsScrollView alloc] initWithFrame:CGRectMake(0,
                                                                                 0,
                                                                                 self.view.frame.size.width,
                                                                                 self.view.frame.size.height)];
    [self.view addSubview:self.lyricsScrollView];
    [self setupLyricsScrollView];
    [self setupGradientLayer];

    CGFloat fontSize = 40.0;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    [self.lyricsScrollView addTextLayersWithLyrics:lyrics font:font];
    
    
    
    self.duration = 1.5;
    self.counter = self.numberOfLines;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration
                                                  target:self
                                                selector:@selector(showLyrics)
                                                userInfo:nil
                                                 repeats:YES];
    
}

// MARK: lyrics auto scroll
-(void)showLyrics {
    if (self.counter <= 0) {
        [self.timer invalidate];
        NSLog(@"timer retired");
    } else {
        
        [self.lyricsScrollView scrollLyricsWithCounter:self.counter
                                            lineNumber:self.numberOfLines
                                        animationBlock:^(CGRect bounds, CGFloat newY){
                                            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
                                            animation.duration = self.duration * 0.5;
                                            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
                                            animation.fromValue = [NSValue valueWithCGRect:bounds];
                                            
                                            bounds.origin.y = newY;
                                            animation.toValue = [NSValue valueWithCGRect:bounds];
                                            [self.lyricsScrollView.layer addAnimation:animation forKey:@"bounds"];
        }];
        
    }
    self.counter--;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc {
    [self.timer invalidate];
    NSLog(@"%@ dealloc@", NSStringFromClass([self class]) );
}

// MARK: UI setup

-(void)setupGradientLayer {
    // sources: https://stackoverflow.com/questions/24614691/fade-out-scrolling-uitextview-over-image/24614780#24614780
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.lyricsScrollView.superview.bounds;
    gradient.colors = @[(id) [UIColor clearColor].CGColor, (id)[UIColor blueColor].CGColor, (id)[UIColor blueColor].CGColor, (id) [UIColor clearColor].CGColor];
    gradient.locations = @[@0.05, @0.1, @0.85, @1.0];
    self.lyricsScrollView.superview.layer.mask = gradient;
}

-(void)setupLyricsScrollView {
    self.lyricsScrollView.backgroundColor = [UIColor blackColor];
    self.lyricsScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.lyricsScrollView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view.layoutMarginsGuide
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:10.0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.lyricsScrollView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view.layoutMarginsGuide
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:-10.0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.lyricsScrollView
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0
                                                                constant:0.0];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.lyricsScrollView
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:0.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.lyricsScrollView
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

@end
