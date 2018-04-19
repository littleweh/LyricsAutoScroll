//
//  ViewController.m
//  LyricsAutoScroll
//
//  Created by Ada Kao on 19/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic, readwrite) UIView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *lyrics = [NSMutableArray arrayWithObjects:@"Re重迴  詞/ 曲: 何瑞康", @"有ㄧ種去別的地方開始重新生活一樣", @"關上那些早已習慣卻放不下的許多許多", @"還沒完全失去卻已經開始努力地遺忘", @"沒了畫面沒了聲音沒了爭執也沒了原諒", @"直到某一天", @"生活的浪打在背上", @"痛得忘了原本的傷", @"直到某一天", @"各自的夜有了各自的家", @"誰的溫暖溫暖了誰的肩膀", @"日子一天一天迴圈", @"卻沒有一件事能真的重來一遍", @"退路一步一步走偏", @"已經失去過的又再失去一遍", @"一再的返回起點", @"直到某一天", @"生活的浪打在背上", @"痛得忘了原本的傷", @"直到某一天", @"各自的夜有了各自的家", @"誰的溫暖溫暖了誰的肩膀", nil];

    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  self.view.bounds.size.width,
                                                                  self.view.bounds.size.height)];
    [self.view addSubview:self.containerView];
    [self setupContainerView];
    
    // try to add two CATextLayer
    CATextLayer *textLayer1 = [CATextLayer layer];
    CATextLayer *textLayer2 = [CATextLayer layer];
    NSInteger rowNumber = 12;
    NSInteger initialRowNumber = 3;
    
    textLayer1.frame = CGRectMake(0,
                                  initialRowNumber * self.containerView.frame.size.height / rowNumber,
                                  self.containerView.frame.size.width,
                                  self.containerView.frame.size.height / rowNumber);
    textLayer2.frame = CGRectMake(0,
                                  (initialRowNumber + 1) * self.containerView.frame.size.height / rowNumber,
                                  self.containerView.frame.size.width,
                                  self.containerView.frame.size.height / rowNumber);
    
    textLayer1.string = lyrics[0];
    textLayer2.string = lyrics[1];
    
    textLayer1.fontSize = 20.0;
    textLayer2.fontSize = 20.0;
    
    textLayer1.foregroundColor = [UIColor whiteColor].CGColor;
    textLayer2.foregroundColor = [UIColor whiteColor].CGColor;
    
    textLayer1.contentsScale = [UIScreen mainScreen].scale;
    textLayer2.contentsScale = [UIScreen mainScreen].scale;
    
    [self.containerView.layer addSublayer:textLayer1];
    [self.containerView.layer addSublayer:textLayer2];
    
    
    textLayer1.backgroundColor = [UIColor grayColor].CGColor;
    textLayer1.foregroundColor = [UIColor whiteColor].CGColor;
    
}

-(void)setupContainerView {
    self.containerView.backgroundColor = [UIColor blackColor];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.containerView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view.layoutMarginsGuide
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0.0];

    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.containerView
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view.layoutMarginsGuide
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:0.0];

    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.containerView
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0
                                                            constant:0.0];

    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.containerView
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1.0
                                                                constant:0.0];
    
    [self.view addConstraint:top];
    [self.view addConstraint:bottom];
    [self.view addConstraint:leading];
    [self.view addConstraint:trailing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
