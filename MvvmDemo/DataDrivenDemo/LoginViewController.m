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
    self.loginView.username.subscribe(self.loginViewModel.username);
    
    self.loginView.password.subscribe(self.loginViewModel.password);
    
    self.loginView.instruction.subscribe(self.loginViewModel.instruction);
    
    self.loginView.usernameValid.subscribe(self.loginViewModel.usernameValid);
    
    self.loginView.passwordValid.subscribe(self.loginViewModel.passwordValid);
    
    self.loginView.loginEnabled.subscribe(self.loginViewModel.loginEnabled);
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
