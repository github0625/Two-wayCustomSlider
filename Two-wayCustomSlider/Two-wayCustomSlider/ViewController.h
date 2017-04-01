//
//  ViewController.h
//  Two-wayCustomSlider
//
//  Created by lixiang on 2017/4/1.
//  Copyright © 2017年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define PRICEBGW  271.0
#define PRICEBGH  21.0
#define PRICEBGX (SCREENW - PRICEBGW)*0.5
#define PRICEBGY (SCREENH - PRICEBGH)*0.5
#define PRICEMAX (SCREENW*0.5 + PRICEBGW*0.44)
#define PRICEMIN (SCREENW*0.5 - PRICEBGW*0.45)
#define NODE1  (PRICEBGX + 103)
@interface ViewController : UIViewController

@property(nonatomic,strong)UIImageView *leftSlideImageView;
@property(nonatomic,strong)UIImageView *rightSlideImageView;
@property(nonatomic,strong)UIView * pmgressbarView;
@property(nonatomic,strong)UILabel * resultLabel;
@property(nonatomic,assign)CGFloat leftValue;
@property(nonatomic,assign)CGFloat rightValue;

@end

