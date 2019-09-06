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
        self._tm_originalConstant = self.layoutConstant;
        [view tm_addAutoCollapseWhenHidden:self];

        return self;
    };
}

- (MASConstraint * (^)(UIView *view))tm_installWhenHidden
{
    return ^id(UIView *view) {
        self._tm_installWhenHiddenFlag = YES;
        [view tm_addAutoInstallConstraint:self];
        
        return self;
    };
}

- (MASConstraint * (^)(UIView *view))tm_installWhenShow
{
    return ^id(UIView *view) {
        self._tm_installWhenShowFlag = YES;
        [view tm_addAutoInstallConstraint:self];
        
        return self;
    };
}

@end
