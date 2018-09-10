//
//  PickerViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/9.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "PickerViewController.h"
#import "CountryTextField.h"
#import "BirthdayTextField.h"
#import "CityTextField.h"
#import "UITextField+DefaultText.h"

@interface PickerViewController () </*UIPickerViewDataSource, UIPickerViewDelegate,*/ UITextFieldDelegate>
#if 0
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
@property (nonatomic, copy) NSArray * dataSource;
#endif
@property (weak, nonatomic) IBOutlet CountryTextField *countryTextField;
@property (weak, nonatomic) IBOutlet BirthdayTextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet CityTextField *cityTextField;
@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Picker View";
    self.view.backgroundColor = BackgroundColor;
#if 0
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
#endif
    self.countryTextField.delegate = self;
    self.birthdayTextField.delegate = self;
    self.cityTextField.delegate = self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"%s", __func__);
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"%s", __func__);
    [textField setDefaultText];
}
//
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    NSLog(@"%s", __func__);
//    return YES;
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    NSLog(@"%s", __func__);
//}
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSLog(@"%s", __func__);
//    return YES;
//}

#if 0
- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pickerview" ofType:@"plist"]];
    }
    return _dataSource;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataSource.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataSource[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataSource[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectLabel.text = self.dataSource[component][row];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {}
#endif

@end
