//
//  SQSeeBigPictureViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSeeBigPictureViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDImageCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h>

@interface SQSeeBigPictureViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView * imageView;
@end

@implementation SQSeeBigPictureViewController

- (IBAction)dismissButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonClick:(UIButton *)sender {
//    UIImage * image = [[SDImageCache sharedImageCache] imageFromCacheForKey:self.image0];
//    UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                [self savePhoto];
            }
        }];
    } else if (status == PHAuthorizationStatusAuthorized) {
        [self savePhoto];
    } else {
        [SVProgressHUD showInfoWithStatus:@"进入设置界面->找到当前应用->打开允许访问相册"];
    }
}

- (PHAssetCollection *)fetchAssetCollection:(NSString *)albumTitle {
    PHFetchResult * result = [PHAssetCollection fetchAssetCollectionsWithType:(PHAssetCollectionTypeAlbum) subtype:(PHAssetCollectionSubtypeAlbumRegular) options:nil];
    for (PHAssetCollection * assetCollection in result) {
        if ([assetCollection.localizedTitle isEqualToString:albumTitle]) {
            return assetCollection;
        }
    }
    return nil;
}

- (void)savePhoto {
    UIImage * image = self.imageView.image;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCollection * assetCollection =[self fetchAssetCollection:@"Network"];
        PHAssetCollectionChangeRequest * assetCollectionChangeRequest;
        if (assetCollection) {
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else {
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"Network"];
            PHAssetChangeRequest * assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            PHObjectPlaceholder * objectPlaceholder = [assetChangeRequest placeholderForCreatedAsset];
            [assetCollectionChangeRequest addAssets:@[objectPlaceholder]];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
            } else {
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            }
        });
    }];
}

//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败"];
//    } else {
//        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * imageView = [UIImageView new];
    _imageView = imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.image0]];
    [_scrollView addSubview:imageView];
    CGFloat h = [UIScreen mainScreen].bounds.size.width / _width * _height;
    imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, h);
    if (_is_bigPicture) {
        _scrollView.contentSize = CGSizeMake(0, h);
        _scrollView.delegate = self;
        if (_height > h) {
            _scrollView.maximumZoomScale = _height / h;
        }
    } else {
        imageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width * .5, [UIScreen mainScreen].bounds.size.width * .5);
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

@end
