//
//  SQPhotoManager.m
//  Network
//
//  Created by 朱双泉 on 2018/10/29.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQPhotoManager.h"
#import <Photos/Photos.h>

@implementation SQPhotoManager

+ (void)savePhoto:(UIImage *)image albumTitle:(NSString *)albumTitle completionHandler:(void(^)(BOOL success, NSError * error))completionHandler {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCollection * assetCollection = [self fetchAssetCollection:albumTitle];
        PHAssetCollectionChangeRequest * assetCollectionChangeRequest;
        if (assetCollection) {
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else {
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumTitle];
            PHAssetChangeRequest * assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            PHObjectPlaceholder * objectPlaceholder = [assetChangeRequest placeholderForCreatedAsset];
            [assetCollectionChangeRequest addAssets:@[objectPlaceholder]];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionHandler) {
                completionHandler(success, error);
            }
        });
    }];
}

+ (PHAssetCollection *)fetchAssetCollection:(NSString *)albumTitle {
    PHFetchResult * result = [PHAssetCollection fetchAssetCollectionsWithType:(PHAssetCollectionTypeAlbum) subtype:(PHAssetCollectionSubtypeAlbumRegular) options:nil];
    for (PHAssetCollection * assetCollection in result) {
        if ([assetCollection.localizedTitle isEqualToString:albumTitle]) {
            return assetCollection;
        }
    }
    return nil;
}

@end
