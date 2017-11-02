//
//  YYBubbleButton.m
//  tete
//
//  Created by 赵国进 on 2017/9/16.
//  Copyright © 2017年 上海途宝网络科技. All rights reserved.
//

#import "TBBubbleView.h"

@interface TBBubbleView()
@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,assign)CGFloat maxWidth;

@property(nonatomic,assign)CGPoint startPoint;

@property(nonatomic,strong) NSMutableArray *layerArray;

@property(nonatomic) NSUInteger bubbleNum;

@property(nonatomic) NSInteger tempNum;

@end


@implementation TBBubbleView


//初始化
-(instancetype)initWithFrame:(CGRect)frame folatMaxLeft:(CGFloat)maxLeft folatMaxRight:(CGFloat)maxRight folatMaxHeight:(CGFloat)maxHeight bubbleNum:(NSInteger)bubbleNum
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _maxLeft = maxLeft;
        _maxRight = maxRight;
        _maxHeight = maxHeight;
        _layerArray = [NSMutableArray array];
        _bubbleNum = bubbleNum;
        _tempNum = 0;
    }
    return self;
}
//外部方法 开始气泡
-(void)startBubble
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(generateBubble) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:UITrackingRunLoopMode];
}

-(void)generateBubble
{
    if (_tempNum == _bubbleNum) {
        [self.timer invalidate];
        return;
    }
    CALayer *layer =[CALayer layer];;
    UIImage *image = self.images[arc4random() % self.images.count];
    
    layer = [self createLayerWithImage:image];
    [self.layer addSublayer:layer];
    [self generateBubbleByLayer:layer];
    _tempNum += 1;
}

//创建带有Image的Layer
- (CALayer *)createLayerWithImage:(UIImage *)image
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CALayer *layer = [CALayer layer];
    layer.frame    = CGRectMake(0, 0, image.size.width / scale, image.size.height / scale);
    layer.contents = (__bridge id)image.CGImage;
    return layer;
}


-(void)generateBubbleByLayer:(CALayer*)layer
{
    _maxWidth = _maxLeft + _maxRight;
    _startPoint = CGPointMake(self.frame.size.width/2, 0);
    
    CGPoint endPoint = CGPointMake(_maxWidth * [self randomFloat] - _maxLeft, -_maxHeight);
    
    CGPoint controlPoint1 =
    CGPointMake(_maxWidth * [self randomFloat] - _maxLeft, -_maxHeight * 0.2);
    CGPoint controlPoint2 =
    CGPointMake(_maxWidth * [self randomFloat] - _maxLeft, -_maxHeight * 0.6);
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, _startPoint.x, _startPoint.y);
    CGPathAddCurveToPoint(curvedPath, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, endPoint.x, endPoint.y);
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:curvedPath];
    //[path addCurveToPoint:endPoint controlPoint1:_startPoint controlPoint2:controlPoint1];
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animation];
    keyFrame.keyPath = @"position";
    keyFrame.path = path.CGPath;
    keyFrame.duration = self.duration;
    keyFrame.calculationMode = kCAAnimationPaced;
    
    [layer addAnimation:keyFrame forKey:@"keyframe"];
    
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.toValue = @1;
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)];
    scale.duration = 0.5;
    
    CABasicAnimation *alpha = [CABasicAnimation animation];
    alpha.keyPath = @"opacity";
    alpha.fromValue = @1;
    alpha.toValue = @0.1;
    alpha.duration = self.duration * 0.4;
    alpha.beginTime = self.duration - alpha.duration;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[keyFrame, scale, alpha];
    group.duration = self.duration;
    group.delegate = self;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [layer addAnimation:group forKey:@"group"];
    
    [self.layerArray addObject:layer];
}
-(void)dealloc
{
    [self.layerArray removeAllObjects];
    [self.timer invalidate];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        CALayer *layer = [self.layerArray firstObject];
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
        [self.layerArray removeObject:layer];
        if (self.layerArray.count == 0) {
            [self removeFromSuperview];
        }
    }
    
}
- (CGFloat)randomFloat{
    return (arc4random() % 100)/100.0f;
}

@end

