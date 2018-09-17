//
//  SecondaryViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SecondaryViewController.h"
#import "DrawView.h"

@interface SecondaryViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet DrawView5 *drawView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *colorButtonsArr;
@end

@implementation SecondaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)clearButtonClick:(UIButton *)sender {
    [self.drawView clear];
}

- (IBAction)undoButtonClick:(UIButton *)sender {
    [self.drawView undo];
}

- (IBAction)eraserButtonClick:(UIButton *)sender {
    [self.drawView eraser];
}

- (IBAction)photoButtonClick:(UIButton *)sender {
    UIImagePickerController * vc = [UIImagePickerController new];
#if 0
    typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
        UIImagePickerControllerSourceTypePhotoLibrary,
        UIImagePickerControllerSourceTypeCamera,
        UIImagePickerControllerSourceTypeSavedPhotosAlbum
    } __TVOS_PROHIBITED;
#endif
    vc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)saveButtonClick:(UIButton *)sender {
    UIGraphicsBeginImageContext(self.drawView.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.drawView.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    UIGraphicsEndImageContext();
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    HandleView * view = [[HandleView alloc]initWithFrame:self.drawView.bounds];
    view.image = image;
    view.delegate = self.drawView;
    [self.drawView addSubview:view];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)setLineColor:(UIButton *)sender {
    for (UIButton * button in self.colorButtonsArr)
        button.selected = NO;
    sender.selected = YES;
    [self.drawView setLineColor:sender.backgroundColor];
}

- (IBAction)setLineWidth:(UISlider *)sender {
    [self.drawView setLineWidth:sender.value];
}

@end

