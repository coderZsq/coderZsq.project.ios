//
//  NavigationViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "NavigationViewController.h"
#import <MBProgressHUD.h>
#import "NavigationViewController2.h"

#define kAccount @"account"
#define kPassword @"password"
#define kRemember @"remember"
#define kAutoLogin @"auto-login"

@interface NavigationViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if 0
    NSLog(@"%@", NSHomeDirectory());
    //Documents
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString * filePath = [path stringByAppendingPathComponent:@"plist.plist"];
    NSLog(@"%@", path);
    [@[@6, @6, @6] writeToFile:filePath atomically:YES];
    NSArray * array = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@", array);
    [@{@"name":@"Castie!"} writeToFile:filePath atomically:YES];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"%@", dict);
    //Library/Preferences
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"coderZsq" forKey:@"Castie!"];
    [userDefault setInteger:666 forKey:@"integer"];
    [userDefault setBool:YES forKey:@"bool"];
    //[userDefault synchronize];
    NSString * name = [userDefault objectForKey:@"Castie!"];
    NSInteger integer = [userDefault integerForKey:@"integer"];
    BOOL b =  [userDefault boolForKey:@"bool"];
    NSLog(@"%@ - %ld - %d", name, integer, b);
#endif
    
#if 0
    self.accountTextField.delegate = self;
    self.passwordTextField.delegate = self;
#endif
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    self.rememberSwitch.on = [userDefault boolForKey:kRemember];
    self.autoLoginSwitch.on = [userDefault boolForKey:kAutoLogin];
    if (self.rememberSwitch.isOn) {
        self.accountTextField.text = [userDefault objectForKey:kAccount];
        self.passwordTextField.text = [userDefault objectForKey:kPassword];
        if (self.autoLoginSwitch.on) {
            [self loginButtonClick:self.loginButton];
        }
    }
    
    [self.accountTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self textChange:nil];
}

- (IBAction)backBarButtonItemClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)rememberSwitchValueChanged:(UISwitch *)sender {
    if (!self.rememberSwitch.isOn) {
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

- (IBAction)autoLoginSwitchValueChanged:(UISwitch *)sender {
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:sender.on forKey:kAutoLogin];
    if (self.autoLoginSwitch.isOn) {
        [self.rememberSwitch setOn:YES animated:YES];
    }
}

- (IBAction)loginButtonClick:(UIButton *)sender {
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading";

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([self.accountTextField.text isEqualToString:@"Cas"] &&
            [self.passwordTextField.text isEqualToString:@"666"]) {
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:self.accountTextField.text forKey:kAccount];
            [userDefault setObject:self.passwordTextField.text forKey:kPassword];
            [userDefault setBool:self.rememberSwitch.isOn forKey:kRemember];
            [userDefault setBool:self.autoLoginSwitch.isOn forKey:kAutoLogin];
            [self performSegueWithIdentifier:@"nav2segue" sender:nil];
        } else {
            MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"Account or password is error...";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NavigationViewController2 * vc = segue.destinationViewController;
    vc.accountName = self.accountTextField.text;
}

- (void)textChange:(UITextField *)sender {
    self.loginButton.enabled = self.accountTextField.text.length && self.passwordTextField.text.length;
}

#if 0
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.accountTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        self.loginButton.enabled = YES;
    } else {
        self.loginButton.enabled = NO;
    }
    return YES;
}
#endif
@end
