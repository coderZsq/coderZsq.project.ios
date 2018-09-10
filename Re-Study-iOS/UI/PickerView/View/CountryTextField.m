//
//  CountryTextField.m
//  UI
//
//  Created by 朱双泉 on 2018/9/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "CountryTextField.h"
#import <MJExtension.h>

@interface FlagModel : NSObject
@property (nonatomic, copy) NSString * name;
@property (nonatomic, strong) UIImage * icon;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end

@implementation FlagModel

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    FlagModel * model = [self new];
    [model setValuesForKeysWithDictionary:dict];
//    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        [model setValue:obj forKeyPath:key];
//    }];
    return model;
}

- (void)setIcon:(UIImage *)icon {
    if ([icon isKindOfClass:[NSString class]])
        _icon = [UIImage imageNamed:(NSString *)icon];
    else _icon = icon;
}

@end

@interface FlagView : UIView
+ (instancetype)flagView;
@end

@interface FlagView()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) FlagModel * model;
@end

@implementation FlagView

+ (instancetype)flagView {
    return [[[NSBundle mainBundle]loadNibNamed:@"FlagView" owner:nil options:nil] lastObject];
}

- (void)setModel:(FlagModel *)model {
    _model = model;
    self.nameLabel.text = model.name;
    self.iconImageView.image = model.icon;
}

@end

@interface CountryTextField() <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, copy) NSArray * dataSource;
@end

@implementation CountryTextField

- (void)setDefaultText {
    FlagModel * model = [self.dataSource firstObject];
    self.text = model.name;
}

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        NSArray * data = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"pickerview2" ofType:@"plist"]];
        NSMutableArray * dataSource = [NSMutableArray array];
        for (NSDictionary * dict in data) {
            [dataSource addObject:[FlagModel modelWithDict:dict]];
        }
        _dataSource = dataSource;
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
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    FlagView * flagView = (FlagView *)view;
    if (!flagView) {
        flagView = [FlagView flagView];
        flagView.bounds = view.bounds;
    }
    flagView.model = self.dataSource[row];
    return flagView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 72;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    FlagModel * model = self.dataSource[row];
    self.text = model.name;
}

@end
