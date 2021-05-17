//
//  LoginView.h
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/4.
//

#import <UIKit/UIKit.h>
#import "Observable.h"
#import "Observer.h"

#define LightRed [UIColor colorWithRed:1.0*0xFF/0xFF green:1.0*0xCC/0xFF blue:1.0*0xCC/0xFF alpha:1.0]
#define LightGreen [UIColor colorWithRed:1.0*0xCC/0xFF green:1.0*0xFF/0xFF blue:1.0*0xCC/0xFF alpha:1.0]
#define LightBlue [UIColor colorWithRed:1.0*0xCC/0xFF green:1.0*0xCC/0xFF blue:1.0*0xFF/0xFF alpha:1.0]
#define LightYellow [UIColor colorWithRed:1.0*0xFF/0xFF green:1.0*0xFF/0xFF blue:1.0*0xCC/0xFF alpha:1.0]
#define LightMagenta [UIColor colorWithRed:1.0*0xFF/0xFF green:1.0*0xCC/0xFF blue:1.0*0xFF/0xFF alpha:1.0]
#define LightCyan [UIColor colorWithRed:1.0*0xCC/0xFF green:1.0*0xFF/0xFF blue:1.0*0xFF/0xFF alpha:1.0]
#define LightGray [UIColor colorWithRed:1.0*0xCC/0xFF green:1.0*0xCC/0xFF blue:1.0*0xCC/0xFF alpha:1.0]
#define ThemeColor [UIColor colorWithRed:1.0*0xFF/0xFF green:1.0*0x37/0xFF blue:1.0*0x00/0xFF alpha:1.0]

NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView

@property(strong, nonatomic) UITextField *usernameTextField;

@property(strong, nonatomic) UITextField *passwordTextField;

@property(strong, nonatomic) UILabel *instructionLabel;

@property(strong, nonatomic) UIButton *loginButton;

//MARK: 数据驱动UI刷新
@property(strong, nonatomic) Observer *username;

@property(strong, nonatomic) Observer *password;

@property(strong, nonatomic) Observer *instruction;

@property(strong, nonatomic) Observer *usernameValid;

@property(strong, nonatomic) Observer *passwordValid;

@property(strong, nonatomic) Observer *loginEnabled;

//MARK: 用户交互动作订阅
@property(strong, nonatomic) Observable *usernameDidChange;

@property(strong, nonatomic) Observable *passwordDidChange;

@property(strong, nonatomic) Observable *loginButtonTouched;

@end

NS_ASSUME_NONNULL_END
