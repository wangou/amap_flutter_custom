//
//  CustomAnnotationView.m
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CustomAnnotationView.h"


@interface CustomAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CustomAnnotationView

@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;

#pragma mark - Handle Action

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
    [self.nameLabel sizeToFit]; // 尺寸适应文字内容
    CGRect labelFrame = self.nameLabel.frame;
    labelFrame.size.width += 14; // 增加宽度为内边距
    labelFrame.size.height = 20; // 固定高度
    self.nameLabel.frame = labelFrame;
}

- (void) setIconType:(NSString *)iconType{
    self.nameLabel.layer.cornerRadius = 10; // 设置圆角
    self.nameLabel.layer.borderColor=[UIColor blackColor].CGColor;
    self.nameLabel.layer.borderWidth=0.5;
    if([iconType isEqual: @"1"]){
        self.nameLabel.backgroundColor= [self colorWithHexString:@"#38BD4E"];
        self.portrait=[UIImage imageNamed:@"20-car1"];
    }else if([iconType isEqual: @"2"]){
        self.nameLabel.backgroundColor= [self colorWithHexString:@"#999999"];
        self.portrait=[UIImage imageNamed:@"20-car3"];
    }else if([iconType isEqual: @"3"]){
        self.nameLabel.backgroundColor= [self colorWithHexString:@"#E64CF8"];
        self.portrait=[UIImage imageNamed:@"20-car2"];
    }else if([iconType isEqual: @"4"]){
        self.nameLabel.backgroundColor= [self colorWithHexString:@"#C1333D"];
        self.portrait=[UIImage imageNamed:@"20-car4"];
    }else if([iconType isEqual: @"5"]){
        self.nameLabel.backgroundColor= [self colorWithHexString:@"#3ECAF6"];
        self.portrait=[UIImage imageNamed:@"20-car5"];
    }else if([iconType isEqual: @"6"]){
        self.nameLabel.backgroundColor= [self colorWithHexString:@"#FAC251"];
        self.portrait=[UIImage imageNamed:@"20-car6"];
    }
    self.nameLabel.layer.masksToBounds = YES;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
//        self.portraitImageView = [[UIImageView alloc] init];
//        [self addSubview:self.portraitImageView];
//        
//        /* Create name label. */
//        self.nameLabel = [[UILabel alloc] init];
//        self.nameLabel.backgroundColor  = [UIColor colorWithRed:68 green:201 blue:15 alpha:1];
//        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
//        self.nameLabel.textColor        = [UIColor whiteColor];
//        self.nameLabel.font             = [UIFont systemFontOfSize:12.f];
//        self.nameLabel.numberOfLines = 1;
//        self.nameLabel.layer.cornerRadius = 10; // 圆角半径
//        self.nameLabel.layer.masksToBounds = YES; // 裁剪超出圆角部分
//        [self addSubview:self.nameLabel];
        // 初始化车牌标签
                self.nameLabel = [[UILabel alloc] init];
                self.nameLabel.backgroundColor = [UIColor colorWithRed:68/255.0 green:201/255.0 blue:15/255.0 alpha:1]; // 设置背景颜色
                self.nameLabel.textColor = [UIColor whiteColor]; // 设置文字颜色
                self.nameLabel.font = [UIFont boldSystemFontOfSize:14]; // 设置字体
                self.nameLabel.textAlignment = NSTextAlignmentCenter; // 设置文字居中
                self.nameLabel.layer.cornerRadius = 10; // 设置圆角
                self.nameLabel.layer.borderColor=[UIColor blackColor].CGColor;
                self.nameLabel.layer.borderWidth=0.5;
                self.nameLabel.layer.masksToBounds = YES; // 允许圆角
                self.nameLabel.text = @"粤B3524A"; // 设置车牌号码
                [self.nameLabel sizeToFit]; // 尺寸适应文字内容
                CGRect labelFrame = self.nameLabel.frame;
                labelFrame.size.width += 14; // 增加宽度为内边距
                labelFrame.size.height = 20; // 固定高度
                self.nameLabel.frame = labelFrame;

                // 初始化车辆图像视图
                self.portraitImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"15-car"]];
            
                self.portraitImageView.contentMode = UIViewContentModeScaleAspectFit; // 设置内容模式
                CGRect imageFrame = CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame), 28, 28); // 定位车辆图标
                self.portraitImageView.frame = imageFrame;

                // 将标签和图像视图添加到自定义视图
                [self addSubview:self.nameLabel];
                [self addSubview:self.portraitImageView];

                // 设置自定义视图的尺寸以包含标签和图像视图
                self.frame = CGRectMake(0, 0, self.nameLabel.frame.size.width, CGRectGetMaxY(self.portraitImageView.frame));
    }
    
    return self;
}

- (UIColor *)colorWithHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0
                           green:((rgbValue & 0xFF00) >> 8) / 255.0
                            blue:(rgbValue & 0xFF) / 255.0
                           alpha:1.0];
}

@end
