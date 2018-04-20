//
//  ViewController.m
//  LyricsAutoScroll
//
//  Created by Ada Kao on 19/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic, readwrite) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *lyrics = [NSMutableArray arrayWithObjects:@"Re重迴  詞/ 曲: 何瑞康", @"有ㄧ種去別的地方開始重新生活一樣", @"關上那些早已習慣卻放不下的許多許多", @"還沒完全失去卻已經開始努力地遺忘", @"沒了畫面沒了聲音沒了爭執也沒了原諒", @"直到某一天", @"生活的浪打在背上", @"痛得忘了原本的傷", @"直到某一天", @"各自的夜有了各自的家", @"誰的溫暖溫暖了誰的肩膀", @"日子一天一天迴圈", @"卻沒有一件事能真的重來一遍", @"退路一步一步走偏", @"已經失去過的又再失去一遍", @"一再的返回起點", @"直到某一天", @"生活的浪打在背上", @"痛得忘了原本的傷", @"直到某一天", @"各自的夜有了各自的家", @"誰的溫暖溫暖了誰的肩膀", nil];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  self.view.frame.size.width,
                                                                  self.view.frame.size.height)];
    [self.view addSubview:self.scrollView];
    [self setupScrollView];
    
    NSInteger rowNumber = 12;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
                                             lyrics.count * self.scrollView.frame.size.height / rowNumber);

    
    for (int i = 0; i < lyrics.count; i++) {
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.frame = CGRectMake(0,
                                     i * self.scrollView.frame.size.height / rowNumber,
                                     self.scrollView.frame.size.width,
                                     self.scrollView.frame.size.height / rowNumber);
        textLayer.string = lyrics[i];
        textLayer.font = (__bridge CFTypeRef)@"Helvetica";
        textLayer.fontSize = 20.0;
        textLayer.foregroundColor = [UIColor whiteColor].CGColor;
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.alignmentMode = kCAAlignmentCenter;
        [self.scrollView.layer addSublayer:textLayer];
    }
    
}

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
    // Dispose of any resources that can be recreated.
}


@end
