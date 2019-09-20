//
//  MASConstraint+_TMExtends.h
//  Masonry
//
//  Created by XiaobinLin on 2019/9/4.
//

#import <Masonry/Masonry.h>

@interface MASConstraint (_TMExtends)

@property (nonatomic, assign) CGFloat layoutConstant;
@property (nonatomic, assign, readonly) BOOL hasBeenInstalled;
@property (nonatomic, assign) BOOL updateExisting;

@property (nonatomic, assign) CGFloat _tm_originalConstant;
@property (nonatomic, assign) BOOL _tm_installWhenHiddenFlag;
@property (nonatomic, assign) BOOL _tm_installWhenShowFlag;
@property (nonatomic, assign) BOOL _tm_viewHidden;

- (void)tm_updateConstantViewHidden:(BOOL)hidden;
- (void)tm_checkInstallViewHidden:(BOOL)hidden;

@end


@interface MASViewConstraint (_TMExtends)

@property (nonatomic, weak) MASLayoutConstraint *layoutConstraint;
@property (nonatomic, assign) NSLayoutRelation layoutRelation;
@property (nonatomic, assign) MASLayoutPriority layoutPriority;
@property (nonatomic, assign) CGFloat layoutMultiplier;

- (BOOL)tm_layoutConstraintSimilarTo:(MASViewConstraint *)constraint;

@end
