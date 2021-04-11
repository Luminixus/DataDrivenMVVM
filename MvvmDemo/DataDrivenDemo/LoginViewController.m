//
//  LoginViewController.m
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/4.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "LoginViewModel.h"
#import "Observer.h"

@interface LoginViewController ()

@property(strong, nonatomic) LoginView *loginView;

@property(strong, nonatomic) LoginViewModel *loginViewModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginView = [[LoginView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.view addSubview:self.loginView];
    
    self.loginViewModel = [[LoginViewModel alloc] init];
    
    [self doDataBindings];
    
    [self doActionBindings];
    
    [self initStates];
}

/// 数据驱动UI刷新
-(void)doDataBindings{
    WS
    Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.loginView.usernameTextField.text = newValue;
    }).subscribe(self.loginViewModel.username);
    
    Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.loginView.passwordTextField.text = newValue;
    }).subscribe(self.loginViewModel.password);
    
    Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.loginView.instructionLabel.text = newValue;
    }).subscribe(self.loginViewModel.instruction);
    
    Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.loginView.usernameTextField.backgroundColor = [newValue boolValue] ? [UIColor whiteColor] : LightRed;
    }).subscribe(self.loginViewModel.usernameValid);
    
    Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.loginView.passwordTextField.backgroundColor = [newValue boolValue] ? [UIColor whiteColor] : LightRed;
    }).subscribe(self.loginViewModel.passwordValid);
    
    Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.loginView.loginButton.enabled = [newValue boolValue];
        self.loginView.loginButton.backgroundColor = [newValue boolValue] ? ThemeColor : LightGray;
        [self.loginView.loginButton setTitleColor:[newValue boolValue] ? [UIColor whiteColor] : [UIColor darkGrayColor] forState:UIControlStateNormal];
    }).subscribe(self.loginViewModel.loginEnabled);
}

/// 用户交互动作订阅
-(void)doActionBindings{
    self.loginViewModel.usernameDidChange.subscribe(self.loginView.usernameDidChange);
    
    self.loginViewModel.passwordDidChange.subscribe(self.loginView.passwordDidChange);
    
    self.loginViewModel.loginTouched.subscribe(self.loginView.loginButtonTouched);
}

/// 状态初始化
-(void)initStates{
    self.loginViewModel.username.value = @"maruko";
    self.loginViewModel.password.value = @"1234";
}

@end
