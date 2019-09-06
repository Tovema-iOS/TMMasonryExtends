//
//  BaseTestViewController.h
//  WeGamers
//
//  Created by XiaobinLin on 2019/1/22.
//  Copyright © 2019 IGG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCell : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSBlockOperation *operation;

+ (instancetype)cellWithTitle:(NSString *)title operation:(NSBlockOperation *)operation;

@end

@interface TestSection : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<TestCell *> *items;

+ (instancetype)sectionWithTitle:(NSString *)title items:(NSArray<TestCell *> *)items;

@end

@interface BaseTestViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, strong) NSIndexPath *autoClickIndexPath;

- (NSArray<TestSection*> *)createSections;

@end
