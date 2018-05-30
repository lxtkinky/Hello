//
//  TXDiscView.m
//  HelloWorld
//
//  Created by ken on 2018/5/26.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "TXDiscView.h"

@interface TXDiscView()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIImageView *circleImageV;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconOne;

@property (weak, nonatomic) IBOutlet UIImageView *iconTwo;
@property (weak, nonatomic) IBOutlet UIImageView *iconThree;
@property (weak, nonatomic) IBOutlet UIImageView *iconFour;
@property (weak, nonatomic) IBOutlet UIImageView *iconFive;
@property (weak, nonatomic) IBOutlet UIImageView *iconSix;
@property (weak, nonatomic) IBOutlet UIImageView *iconEle;
@property (weak, nonatomic) IBOutlet UIImageView *iconEight;

@end

@implementation TXDiscView

+ (instancetype)discViewWithFrame:(CGRect)frame{
    TXDiscView *discView = [[[NSBundle mainBundle] loadNibNamed:@"TXDiscView" owner:self options:nil] firstObject];
    discView.frame = frame;
    [discView initSubview];
    return discView;
}


- (void)initSubview{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"turntable_l"];
    imageView.bounds = CGRectMake(0, 0, 316, 316);
    [self addSubview:imageView];
    imageView.center = self.center;
    self.iconArray = [NSMutableArray array];
    CGFloat radius = 90;
    for (int i = 0; i < 8; i++) {
        CGFloat radian = M_PI_4 * 0.5 + M_PI_4 * i;
        [self addPrizeIcon:radian radius:radius];
    }
    
    [self tx_addTextLayers];
}

- (void)addPrizeIcon:(CGFloat)radian radius:(CGFloat)radius{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w_2 = self.frame.size.width * 0.5;
    CGFloat h_2 = self.frame.size.width * 0.5;
    CGFloat rotation = 0;
    UIImageView *icon = [[UIImageView alloc] init];
    [self.iconArray addObject:icon];
    icon.image = PLACE_HOLDER_IMAGE;
    icon.frame = CGRectMake(0, 0, 45, 45);
    if (radian > 0 && radian < M_PI_2) {
        x = w_2 + radius * cos(radian);
        y = h_2 - radius * sin(radian);
        rotation = M_PI_2 - radian;
    }
    else if (radian > M_PI_2 && radian < M_PI){
        CGFloat tmpRadian = M_PI - radian;
        x = w_2 - radius * cos(tmpRadian);
        y = h_2 - radius * sin(tmpRadian);
        rotation = -(M_PI_2 + radian - M_PI);
    }
    else if (radian > M_PI && radian < M_PI_2 * 3){
        CGFloat tmpRadian = M_PI_2 * 3 - radian;
        x = w_2 - sin(tmpRadian) * radius;
        y = w_2 + cos(tmpRadian) * radius;
        rotation = tmpRadian + M_PI;
    }
    else{
        CGFloat tmpRadian = M_PI * 2 - radian;
        x = w_2 + radius * cos(tmpRadian);
        y = h_2 + radius * sin(tmpRadian);
        rotation = -(M_PI_2 - tmpRadian + M_PI);
    }
    icon.center = CGPointMake(x, y);
    icon.layer.transform = CATransform3DMakeRotation(rotation, 0, 0, 1);
    [self addSubview:icon];
    
    
}

- (void)tx_addTextLayers{
    CGFloat radius = 145;
    CGFloat radian = 0;
    CGFloat strRadius = M_PI * 6 / 180.0;
    NSArray *array = @[@"1*HAND", @"25*积分", @"1*ETH", @"再来一次", @"1*BTC", @"1*LTC", @"谢谢参与", @"1*INT"];
    UIColor *color = [UIColor whiteColor];
    
    for (int i = 0; i < array.count; i++) {
        NSString *string = array[i];
        for (int j = 0; j < string.length; j++) {
            NSString *tmpStr = [string substringWithRange:NSMakeRange(string.length - j - 1, 1)];
            if ([self IsChinese:tmpStr]) {
                strRadius = 6 * M_PI / 180;
            }
            else{
                strRadius = 4 * M_PI / 180;
            }
            radian = i * M_PI_4 + (M_PI_4 - string.length * strRadius) * 0.5 + strRadius * j + strRadius * 0.5;
            if (i % 2 == 0) {
                color = UIColorFromRGB(0x663300);
            }
            else{
                color = [UIColor whiteColor];
            }
            
            
            [self tx_addLayer:tmpStr radian:radian radius:radius color:color];
        }
    }
}

-(BOOL)IsChinese:(NSString *)str
{
    NSInteger count = str.length;
    NSInteger result = 0;
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            result++;
        }
    }
    if (count == result) {//当字符长度和中文字符长度相等的时候
        return YES;
    }
    return NO;
}

/**
 *@param radian 弧度
 *param radius 半径
 */
- (void)tx_addLayer:(NSString *)string radian:(CGFloat)radian radius:(CGFloat)radius color:(UIColor *)color{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.bounds = CGRectMake(0, 0, 14, 20);
    textLayer.anchorPoint = CGPointMake(0.5, 0.5);
    textLayer.string = string;
    textLayer.foregroundColor = color.CGColor;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    UIFont *font = [UIFont fontWithName:PingFang_SC_Regular size:14.0];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    textLayer.font = fontName;
    textLayer.fontSize = font.pointSize;
    
//    CGFloat y = self.frame.size.width * 0.5 - radius * 0.5 * sin(radian);
//    CGFloat x = self.frame.size.width * 0.5 - radius * 0.5 * cos(radian);
    CGFloat w_2 = self.frame.size.width * 0.5;
    CGFloat h_2 = self.frame.size.width * 0.5;
    CGFloat y = 0;
    CGFloat x = 0;
    CGFloat rotation = 0;
    if (radian > 0 && radian < M_PI_2) {
        x = w_2 + radius * cos(radian);
        y = h_2 - radius * sin(radian);
        rotation = M_PI_2 - radian;
    }
    else if (radian > M_PI_2 && radian < M_PI){
        CGFloat tmpRadian = M_PI - radian;
        x = w_2 - radius * cos(tmpRadian);
        y = h_2 - radius * sin(tmpRadian);
        rotation = -(M_PI_2 + radian - M_PI);
    }
    else if (radian > M_PI && radian < M_PI_2 * 3){
        CGFloat tmpRadian = M_PI_2 * 3 - radian;
        x = w_2 - sin(tmpRadian) * radius;
        y = w_2 + cos(tmpRadian) * radius;
        rotation = tmpRadian + M_PI;
    }
    else{
        CGFloat tmpRadian = M_PI * 2 - radian;
        x = w_2 + radius * cos(tmpRadian);
        y = h_2 + radius * sin(tmpRadian);
        rotation = -(M_PI_2 - tmpRadian + M_PI);
    }
    
    
    textLayer.position = CGPointMake(x, y);
    textLayer.transform = CATransform3DMakeRotation( rotation, 0, 0, 1);
    [self.layer addSublayer:textLayer];
}

- (IBAction)startButtonClick:(id)sender {
}

- (void)drawRect:(CGRect)rect {
    
    /*画弧形
    CGContextAddArc(CGContextRef context, CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise);
     x,y 弧形的中心点
     radius弧形的半径
     startAngle弧形开始弧度
     endAngle弧形结束弧度
     clockwise：0，逆时针，1：顺时针
     */
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddArc(context, rect.size.width * 0.5, rect.size.width * 0.5, rect.size.width * 0.5 -20, -M_PI_4, -M_PI_2, 1);
//    [[UIColor redColor] set];
//    CGContextSetLineWidth(context, 10);
//    CGContextDrawPath(context, kCGPathStroke);
//
//    //画直线
//    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
//    CGContextSetLineWidth(context, 2.0);
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
//    CGContextStrokePath(context);
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIImage *image = [UIImage imageNamed:@"turntable_btc"];
//    CGRect imageRect = CGRectMake(rect.size.width * 0.5 - 50, rect.size.height * 0.2, 50, 50);
//    [image drawInRect:imageRect];
//    CGContextDrawImage(context, imageRect, image.CGImage);
}


@end
