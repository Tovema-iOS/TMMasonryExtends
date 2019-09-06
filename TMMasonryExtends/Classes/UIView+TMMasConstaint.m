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

- (NSArray *)tm_autoInstallConstraints
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTm_autoInstallConstraints:(NSArray<MASConstraint *> *)constrains
{
    objc_setAssociatedObject(self, @selector(tm_autoInstallConstraints), constrains, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tm_addAutoInstallConstraint:(MASConstraint *)constraint
{
    if (!constraint) {
        return;
    }

    NSMutableArray *array = (self.tm_autoInstallConstraints ?: @[]).mutableCopy;
    [array addObject:constraint];
    self.tm_autoInstallConstraints = array;
    
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
    
    for (MASConstraint *cst in self.tm_autoInstallConstraints) {
        [cst tm_checkInstallViewHidden:self.hidden];
    }
}

@end
