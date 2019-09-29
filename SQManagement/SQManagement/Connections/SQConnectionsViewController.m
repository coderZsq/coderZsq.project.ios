//
//  SQConnectionsViewController.m
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQConnectionsViewController.h"
#import "SQH1TitleView.h"
#import "SQSearchInputView.h"
#import "SQAuthorizationTool.h"
#import "SQConnectionEventsViewController.h"
#import "SQConnectionModel.h"

@interface SQConnectionsViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation SQConnectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人脉";    
    self.dataSource = [NSMutableArray array];
    [SQAuthorizationTool fetchContacts:^(NSArray * _Nonnull contacts) {
        for (SQContact *contact in contacts) {
            SQConnectionModel *model = [SQConnectionModel new];
            model.profile = contact.imageData;
            model.name = [NSString stringWithFormat:@"%@%@", contact.familyName, contact.givenName];
            model.occupation = contact.jobTitle;
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
    }];
}

- (BOOL)isShowNavigationShadowImage {
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 0;
    else return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    SQConnectionModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) return [SQH1TitleView viewWithTitle:self.title];
    else return [SQSearchInputView inputView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 64;
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SQConnectionEventsViewController *connectionEventsVc = [[UIStoryboard storyboardWithName:NSStringFromClass(SQConnectionEventsViewController.class) bundle:nil] instantiateInitialViewController];
    connectionEventsVc.connection = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:connectionEventsVc animated:YES];
}

@end
