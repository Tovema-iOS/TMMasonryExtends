//
//  MASConstraint+TMExtends.m
//  TMMasonryExtends
//
//  Created by XiaobinLin on 2019/9/4.
//

#import "MASConstraint+TMExtends.h"
#import "UIView+TMMasConstaint.h"
#import "MASConstraint+_TMExtends.h"

@implementation MASConstraint (TMExtends)

- (MASConstraint * (^)(UIView *view))tm_collapseWhenHidden
{
    return ^id(UIView *view) {
        if ([self isKindOfClass:[MASCompositeConstraint class]]) {
            for (MASConstraint *child in self.childConstraints) {
                child._tm_originalConstant = child.layoutConstant;
                [view tm_addAutoCollapseWhenHidden:child];
            }
        }
        
        if ([self isKindOfClass:[MASViewConstraint class]]) {
            self._tm_originalConstant = self.layoutConstant;
            [view tm_addAutoCollapseWhenHidden:self];
        }

        return self;
    };
}

- (MASConstraint * (^)(UIView *view))tm_installWhenHidden
{
    return ^id(UIView *view) {
        if ([self isKindOfClass:[MASCompositeConstraint class]]) {
            for (MASConstraint *child in self.childConstraints) {
                child._tm_installWhenHiddenFlag = YES;
                [view tm_addAutoInstallWhenHiddenConstraints:child];
            }
        }
        
        if ([self isKindOfClass:[MASViewConstraint class]]) {
            self._tm_installWhenHiddenFlag = YES;
            [view tm_addAutoInstallWhenHiddenConstraints:self];
        }
        
        return self;
    };
}

- (MASConstraint * (^)(UIView *view))tm_installWhenShow
{
    return ^id(UIView *view) {
        if ([self isKindOfClass:[MASCompositeConstraint class]]) {
            for (MASConstraint *child in self.childConstraints) {
                child._tm_installWhenShowFlag = YES;
                [view tm_addAutoInstallWhenShowConstraints:child];
            }
        }
        
        if ([self isKindOfClass:[MASViewConstraint class]]) {
            self._tm_installWhenShowFlag = YES;
            [view tm_addAutoInstallWhenShowConstraints:self];
        }
        
        return self;
    };
}

@end
