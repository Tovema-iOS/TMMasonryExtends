//
//  UIView+TMMasConstaint.h
//  TMMasonryExtends
//
//  Created by XiaobinLin on 2019/9/4.
//

@class MASConstraint;

@interface UIView (TMMasConstaint)

@property (nonatomic, strong) NSArray<MASConstraint *> *tm_autoInstallWhenShowConstraints;
- (void)tm_addAutoInstallWhenShowConstraints:(MASConstraint *)constraint;

@property (nonatomic, strong) NSArray<MASConstraint *> *tm_autoInstallWhenHiddenConstraints;
- (void)tm_addAutoInstallWhenHiddenConstraints:(MASConstraint *)constraint;

@property (nonatomic, strong) NSArray<MASConstraint *> *tm_collapseWhenHidden;
- (void)tm_addAutoCollapseWhenHidden:(MASConstraint *)constraint;

@end
