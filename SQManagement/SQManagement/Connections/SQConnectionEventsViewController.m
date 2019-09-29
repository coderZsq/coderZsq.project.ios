//
//  SQAddConnectionViewController.m
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQConnectionEventsViewController.h"
#import "SQProfileHeaderView.h"
#import "SQConnectionPropertyCell.h"
#import "UIColor+SQExtension.h"
#import "UIView+SQExtension.h"
#import "SQConnectionModel.h"

@interface SQConnectionEventsViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) SQProfileHeaderView *headerView;
@end

@implementation SQConnectionEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.connection) {
        self.title = @"新增人脉";
        self.connection = [SQConnectionModel new];
    } else {
        self.title = self.connection.name;
    }
    self.dataSource = @[
        @[@"姓名", @"角色", @"职业", @"地区", @"行业", @"影响力", @"亲密程度", @"黄金人脉圈"],
        @[@"联系方式", @"社交记录"],
        @[@"特征", @"工作", @"爱好", @"特殊细节", @"给我的启发"],
    ];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SQConnectionPropertyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SQConnectionPropertyCell class])];
    self.headerView = [SQProfileHeaderView headerView];
    __weak typeof(self) weakSelf = self;
    [self.headerView whenTapped:^{
        UIImagePickerController *imagePickerVc = [[UIImagePickerController alloc] init];
        imagePickerVc.delegate = weakSelf;
        imagePickerVc.allowsEditing = YES;
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"立即拍摄照片" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                imagePickerVc.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickerVc.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            }
        }]];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"从相册中获取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
                imagePickerVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            }
        }]];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
        [weakSelf presentViewController:alertVc animated:YES completion:nil];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = self.dataSource[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQConnectionPropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SQConnectionPropertyCell class])];
    cell.titleLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        [self.connection map:indexPath.row bind:cell.inputLabel];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) return self.headerView;
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 100;
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"请输入 - %@", self.dataSource[indexPath.section][indexPath.row]] preferredStyle:(UIAlertControllerStyleAlert)];
        [alertVc addTextFieldWithConfigurationHandler:nil];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
        __weak typeof(alertVc) weakSelf = alertVc;
        [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self.connection map:indexPath.row bind:weakSelf.textFields.firstObject];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        }]];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.headerView.profileImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
