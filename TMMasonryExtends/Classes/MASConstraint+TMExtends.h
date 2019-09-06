//
//  MASConstraint+TMExtends.h
//  TMMasonryExtends
//
//  Created by XiaobinLin on 2019/9/4.
//

#import <Masonry/Masonry.h>

@interface MASConstraint (TMExtends)

/**
 view 隐藏时自动将约束值设置为 0，显示时恢复原值
 */
- (MASConstraint * (^)(UIView *view))tm_collapseWhenHidden;

/**
 view 隐藏时安装此约束，反之卸载
 */
- (MASConstraint * (^)(UIView *view))tm_installWhenHidden;

/**
 view 显示时安装此约束，反之卸载
 */
- (MASConstraint * (^)(UIView *view))tm_installWhenShow;

@end
