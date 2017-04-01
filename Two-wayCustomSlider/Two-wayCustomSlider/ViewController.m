//
//  ViewController.m
//  Two-wayCustomSlider
//
//  Created by lixiang on 2017/4/1.
//  Copyright © 2017年 lixiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize  leftSlideImageView;
@synthesize  rightSlideImageView;
@synthesize  pmgressbarView;
@synthesize  resultLabel;
@synthesize  leftValue;
@synthesize  rightValue;


- (void)viewDidLoad {
    [super viewDidLoad];
    leftValue=0;
    rightValue=100;
    [self setUpView];
}

-(void)setUpView
{
    
    resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREENW, 60)];
    [resultLabel setTextAlignment:NSTextAlignmentCenter];
    [resultLabel setFont:[UIFont systemFontOfSize:18]];
    resultLabel.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:resultLabel];
    
    
    
    
    //进度条背景图片
    UIImageView *priceBg = [[UIImageView alloc] initWithFrame:CGRectMake(PRICEBGX, PRICEBGY, PRICEBGW, PRICEBGH)];
    [priceBg setImage:[UIImage imageNamed:@"priceBg"]];
    [self.view addSubview:priceBg];
    
    //进度条颜色
    pmgressbarView = [[UIView alloc] initWithFrame:CGRectMake(PRICEBGX, CGRectGetMaxY(priceBg.frame)-2, PRICEBGW, 2.f)];
    [pmgressbarView setBackgroundColor:[UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [self.view addSubview:pmgressbarView];
    
    
    //左滑块
    CGFloat commonHandImageViewW = 20.f;
    CGFloat commonHandImageViewH = 25.f;
    CGFloat leftHandImageViewX = PRICEBGX - commonHandImageViewW*0.5;
    CGFloat leftHandImageViewY = PRICEBGY + commonHandImageViewH;
    leftSlideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftHandImageViewX, leftHandImageViewY, commonHandImageViewW, commonHandImageViewH)];
    [leftSlideImageView setImage:[UIImage imageNamed:@"xiabashou"]];
    [self.view addSubview:leftSlideImageView];
    
    //右滑块
    CGFloat rightHandImageViewX = CGRectGetMaxX(priceBg.frame) - commonHandImageViewW*0.5;
    CGFloat rightHandImageViewY = leftHandImageViewY;
    rightSlideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(rightHandImageViewX, rightHandImageViewY, commonHandImageViewW, commonHandImageViewH)];
    [rightSlideImageView setImage:[UIImage imageNamed:@"xiabashou"]];
    [self.view addSubview:rightSlideImageView];
    
    
    //左滑块添加滑动手势
    UIPanGestureRecognizer *leftPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftSliderMove:)];
    [leftPanRecognizer setMinimumNumberOfTouches:1];
    [leftPanRecognizer setMaximumNumberOfTouches:1];
    [leftSlideImageView setUserInteractionEnabled:YES];
    [leftSlideImageView addGestureRecognizer:leftPanRecognizer];
    
    //右滑块添加滑动手势
    UIPanGestureRecognizer *rightPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightSliderMove:)];
    [rightSlideImageView setUserInteractionEnabled:YES];
    [rightSlideImageView addGestureRecognizer:rightPanRecognizer];
    
    
}

-(void)leftSliderMove:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:leftSlideImageView];
    
    CGFloat x = leftSlideImageView.center.x + point.x;
    if(x > PRICEMAX){
        x = PRICEMAX;
    }else if (x< PRICEBGX ){
        x = PRICEBGX;
    }
    
    leftValue = [self x2price:ceilf(x)];
    leftSlideImageView.center = CGPointMake(ceilf(x), leftSlideImageView.center.y);
    
    if (rightValue-leftValue <= 1) {
        rightValue = leftValue + 1;
        rightSlideImageView.center = CGPointMake([self price2x:rightValue], rightSlideImageView.center.y);
    }
    
    [pan setTranslation:CGPointZero inView:self.view];
    [self updateData];
}

-(void)rightSliderMove:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:rightSlideImageView];
    CGFloat x = rightSlideImageView.center.x + point.x;
    NSLog(@"x:%f",x);
    
    if(x>PRICEBGX+PRICEBGW){
        x = PRICEBGX+PRICEBGW;
    }else if (x<PRICEMIN){
        x = PRICEMIN;
    }
    
    rightValue = [self x2price:ceilf(x)];
    rightSlideImageView.center = CGPointMake(ceilf(x), rightSlideImageView.center.y);
    
    if (rightValue-leftValue <= 1) {
        leftValue = rightValue - 1;
        leftSlideImageView.center = CGPointMake([self price2x:leftValue], leftSlideImageView.center.y);
    }
    
    [pan setTranslation:CGPointZero inView:self.view];
    [self updateData];
}

-(void)updateData{
    [resultLabel setText:[NSString stringWithFormat:@"%.0f~%.0f",leftValue,rightValue]];
    
    CGRect progressRect = CGRectMake(leftSlideImageView.center.x, pmgressbarView.frame.origin.y, rightSlideImageView.center.x - leftSlideImageView.center.x, pmgressbarView.frame.size.height);
    pmgressbarView.frame = progressRect;
    resultLabel.backgroundColor=[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    resultLabel.textColor=[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    
    
}

//坐标->数字
-(CGFloat)x2price:(CGFloat)x{
    
    CGFloat price = 0.f;
    
    NSLog(@"x=====%f",x);
    
    
    //5-
    if(x < PRICEMIN){
        price = 0;
    }
    //5~25
    else if (x < PRICEBGX + 133){
        price = (x - PRICEMIN) / 120 * 20 + 5;
    }
    //25~40
    else if (x < PRICEBGX +  163){
        price = (x - PRICEBGX - 133) *0.5 + 25;
    }
    //40~100
    else if (x < PRICEBGX + 253){
        price = (x - PRICEBGX - 163) * 2 / 3 + 40;
    }
    //100+
    else{
        price = 100;
    }
    
    return price;
}

//数字->坐标
-(CGFloat)price2x:(CGFloat)price{
    
    
    NSLog(@"price=====%f",price);
    
    CGFloat x;
    //  <5
    if (price<5) {
        x = PRICEBGX;
    }
    //5~25
    else if (price >= 5 && price < 25) {
        x = (price-5) * 6 + PRICEMIN;
    }
    //25~40
    else if (price >= 25 && price <40) {
        x = (price-25) * 2 + 133 + PRICEBGX;
    }
    //40~100
    else if (price >=40 && price <100){
        x = (price-40) * 3/2 +163 + PRICEBGX;
    }else if(price >= 100){
        x = PRICEBGX + PRICEBGW;
    }
    
    return x;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
