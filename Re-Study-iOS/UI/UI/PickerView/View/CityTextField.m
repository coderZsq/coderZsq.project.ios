//
//  CityTextField.m
//  UI
//
//  Created by 朱双泉 on 2018/9/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "CityTextField.h"
#import <MJExtension.h>

@interface ProvinceModel : NSObject
@property (nonatomic, copy) NSArray * cities;
@property (nonatomic, copy) NSString * name;
@end

@implementation ProvinceModel
@end

@interface CityTextField() <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, copy) NSArray * dataSource;
@property (nonatomic, assign) NSInteger selectIndex;
@end

@implementation CityTextField

- (void)setDefaultText {
//    ProvinceModel * model = [self.dataSource firstObject];
//    self.text = [NSString stringWithFormat:@"%@ %@", model.name, model.cities.firstObject];
    [self pickerView:(UIPickerView *)self.inputView didSelectRow:0 inComponent:0];
}

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [ProvinceModel mj_objectArrayWithFilename:@"pickerview3.plist"];
    }
    return _dataSource;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupKeyboard];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupKeyboard];
    }
    return self;
}

- (void)setupKeyboard {
    UIPickerView * pickerView = [UIPickerView new];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    self.inputView = pickerView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    ProvinceModel * model = self.dataSource[self.selectIndex];
    if (component == 0) return self.dataSource.count;
    else return model.cities.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        ProvinceModel * model = self.dataSource[row];
        return model.name;
    } else {
        ProvinceModel * model = self.dataSource[self.selectIndex];
        return model.cities[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectIndex = row;
        [pickerView reloadAllComponents];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    ProvinceModel * model = self.dataSource[self.selectIndex];
    self.text = [NSString stringWithFormat:@"%@ %@", model.name, model.cities[[pickerView selectedRowInComponent:1]]];
}

@end
