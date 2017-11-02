//
//  YYBubbleButton.h
//  tete
//
//  Created by 赵国进 on 2017/9/16.
//  Copyright © 2017年 上海途宝网络科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBBubbleView : UIView

@property (nonatomic, assign)CGFloat maxLeft;//漂浮左边最大距离
@property (nonatomic, assign)CGFloat maxRight;//漂浮右边最大距离
@property (nonatomic, assign)CGFloat maxHeight;//漂浮最高距离
@property (nonatomic, assign)CGFloat duration;//一组图片播放完的时间
@property (nonatomic, copy)NSArray *images;//图片数组


//init
-(instancetype)initWithFrame:(CGRect)frame
                folatMaxLeft:(CGFloat)maxLeft
               folatMaxRight:(CGFloat)maxRight
              folatMaxHeight:(CGFloat)maxHeight
                bubbleNum:(NSInteger)bubbleNum;

//开始动画
-(void)startBubble;

@end
