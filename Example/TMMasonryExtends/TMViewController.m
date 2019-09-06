//
//  TMViewController.m
//  TMMasonryExtends
//
//  Created by lxb_0605@qq.com on 09/06/2019.
//  Copyright (c) 2019 lxb_0605@qq.com. All rights reserved.
//

#import "TMViewController.h"

@interface TMViewController ()

@end

@implementation TMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#if 0
#warning 测试
    self.autoClickIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
#endif
}

- (NSArray<TestSection*> *)createSections {
    NSMutableArray<TestSection *> *sections = [NSMutableArray array];
    
    [sections addObject:[self createTestSection]];
    
    return sections;
}

- (TestSection *)createTestSection {
    NSMutableArray<TestCell *> *array = [NSMutableArray array];
    [array addObject:[TestCell cellWithTitle:@"Test" operation:[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Hello Pod");
    }]]];
    
    return [TestSection sectionWithTitle:@"Test" items:array];
}

@end
