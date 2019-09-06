//
//  UIView+TMMasConstaint.m
//  TMMasonryExtends
//
//  Created by XiaobinLin on 2019/9/4.
//

#import "UIView+TMMasConstaint.h"
#import "MASConstraint+_TMExtends.h"
#import <objc/runtime.h>

#define TMSwizzling(originalSelector, swizzledSelector) \
    { \
        Class class = [self class]; \
        Method originalMethod = class_getInstanceMethod(class, originalSelector); \
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector); \
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)); \
        if (didAddMethod) { \
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod)); \
        } else { \
            method_exchangeImplementations(originalMethod, swizzledMethod); \
        } \
    }

@implementation UIView (TMMasConstaint)

- (NSArray *)tm_autoInstallWhenShowConstraints
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTm_autoInstallWhenShowConstraints:(NSArray<MASConstraint *> *)constrains
{
    objc_setAssociatedObject(self, @selector(tm_autoInstallWhenShowConstraints), constrains, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tm_addAutoInstallWhenShowConstraints:(MASConstraint *)constraint
{
    if (!constraint) {
        return;
    }

    NSMutableArray *array = (self.tm_autoInstallWhenShowConstraints ?: @[]).mutableCopy;
    [array addObject:constraint];
    self.tm_autoInstallWhenShowConstraints = array;
    
    [constraint tm_checkInstallViewHidden:self.hidden];
}

- (NSArray *)tm_autoInstallWhenHiddenConstraints
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTm_autoInstallWhenHiddenConstraints:(NSArray<MASConstraint *> *)tm_autoInstallWhenHiddenConstraints
{
    objc_setAssociatedObject(self, @selector(tm_autoInstallWhenHiddenConstraints), tm_autoInstallWhenHiddenConstraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tm_addAutoInstallWhenHiddenConstraints:(MASConstraint *)constraint
{
    if (!constraint) {
        return;
    }
    
    NSMutableArray *array = (self.tm_autoInstallWhenHiddenConstraints ?: @[]).mutableCopy;
    [array addObject:constraint];
    self.tm_autoInstallWhenHiddenConstraints = array;
    
    [constraint tm_checkInstallViewHidden:self.hidden];
}

- (NSArray *)tm_collapseWhenHidden
{
    return objc_getAssociatedObject(self, @selector(tm_collapseWhenHidden));
}

- (void)setTm_collapseWhenHidden:(NSArray<MASConstraint *> *)constrains
{
    objc_setAssociatedObject(self, @selector(tm_collapseWhenHidden), constrains, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tm_addAutoCollapseWhenHidden:(MASConstraint *)constraint
{
    if (!constraint) {
        return;
    }

    NSMutableArray *array = (self.tm_collapseWhenHidden ?: @[]).mutableCopy;
    [array addObject:constraint];
    self.tm_collapseWhenHidden = array;
    
    [constraint tm_updateConstantViewHidden:self.hidden];
}

+ (void)load
{
    TMSwizzling(@selector(setHidden:), @selector(tm_mas_setHidden:));
}

- (void)tm_mas_setHidden:(BOOL)hidden
{
    [self tm_mas_setHidden:hidden];
    
    for (MASConstraint *cst in self.tm_collapseWhenHidden) {
        [cst tm_updateConstantViewHidden:self.hidden];
    }
    
    /* 这里需要区分 hidden 情况
     * 保证先卸载旧的约束，再安装新的约束，避免系统控制台报警
     */
    if (self.hidden) {
        for (MASConstraint *cst in self.tm_autoInstallWhenShowConstraints) {
            [cst tm_checkInstallViewHidden:self.hidden];
        }
        
        for (MASConstraint *cst in self.tm_autoInstallWhenHiddenConstraints) {
            [cst tm_checkInstallViewHidden:self.hidden];
        }
    } else {
        for (MASConstraint *cst in self.tm_autoInstallWhenHiddenConstraints) {
            [cst tm_checkInstallViewHidden:self.hidden];
        }
        
        for (MASConstraint *cst in self.tm_autoInstallWhenShowConstraints) {
            [cst tm_checkInstallViewHidden:self.hidden];
        }
    }
}

@end
