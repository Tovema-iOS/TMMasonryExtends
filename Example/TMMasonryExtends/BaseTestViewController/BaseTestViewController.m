//
//  BaseTestViewController.m
//  WeGamers
//
//  Created by XiaobinLin on 2019/1/22.
//  Copyright © 2019 IGG. All rights reserved.
//

#import "BaseTestViewController.h"

@interface BaseTestViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sections;

@end

@implementation BaseTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sections = [self createSections];
    [self createViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.autoClickIndexPath) {
        NSIndexPath *indexPath = self.autoClickIndexPath;
        self.autoClickIndexPath = nil;
        if (indexPath.section < [self numberOfSectionsInTableView:self.tableView]
            && indexPath.row < [self tableView:self.tableView numberOfRowsInSection:indexPath.section]) {
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
        }
    }
}


- (NSArray<TestSection*> *)createSections {
    return nil;
}

- (void)createViews {
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = UIScreen.mainScreen.bounds;
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DefaultCellIDentifier"];
        
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TestSection *sectionData = [self.sections objectAtIndex:section];
    if ([sectionData isKindOfClass:[TestSection class]]) {
        return sectionData.title;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TestSection *sectionData = [self.sections objectAtIndex:section];
    if ([sectionData isKindOfClass:[TestSection class]]) {
        return sectionData.items.count;
    }
    return 0;
}

- (TestCell *)itemAtIndexPath:(NSIndexPath *)indexPath {
    TestSection *sectionData = [self.sections objectAtIndex:indexPath.section];
    if ([sectionData isKindOfClass:[TestSection class]]) {
        NSArray *items = sectionData.items;
        TestCell *item = items[indexPath.row];
        return item;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCellIDentifier" forIndexPath:indexPath];
    
    TestCell *item = [self itemAtIndexPath:indexPath];
    if ([item isKindOfClass:[TestCell class]]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%zd-%zd %@", indexPath.section, indexPath.row, item.title];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TestCell *item = [self itemAtIndexPath:indexPath];
    NSBlockOperation *operation = item.operation;
    for (void (^block)(void)  in operation.executionBlocks) {
        block();
    }
}

@end


@implementation TestCell

+ (instancetype)cellWithTitle:(NSString *)title operation:(NSBlockOperation *)operation {
    TestCell *item = [[TestCell alloc] init];
    item.title = title;
    item.operation = operation;
    return item;
}

@end

@implementation TestSection

+ (instancetype)sectionWithTitle:(NSString *)title items:(NSArray<TestCell *> *)items; {
    TestSection *section = [[TestSection alloc] init];
    section.title = title;
    section.items = items;
    return section;
}

@end
