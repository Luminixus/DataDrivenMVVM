//
//  LoginView.m
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/4.
//

#import "LoginView.h"

#define WS __weak typeof(self) weakSelf = self;
#define SS __strong typeof(weakSelf) self = weakSelf;

@interface LoginView ()

@property(strong, nonatomic) UILabel *usernameLabel;

@property(strong, nonatomic) UILabel *passwordLabel;

@property(strong, nonatomic) UIImageView *avatarImageView;
 
@end

@implementation LoginView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self doLayout];
        
        [self addTargetActions];
        
        [self makeDataDrivenRefreshing];
        
        [self makeActionsEmittings];
    }
    return self;
}

-(void)doLayout{
    self.backgroundColor = [UIColor colorWithWhite:1.0*0x1A/0xFF alpha:1.0];
    [self addSubview:self.avatarImageView];
    [self addSubview:self.usernameTextField];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.loginButton];
    [self addSubview:self.instructionLabel];
    [self addSubview:self.usernameLabel];
    [self addSubview:self.passwordLabel];
}

-(void)addTargetActions{
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.usernameTextField addTarget:self action:@selector(usernameChanged) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(passwordChanged) forControlEvents:UIControlEventEditingChanged];
}

-(void)makeDataDrivenRefreshing{
    WS
    self.username = Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.usernameTextField.text = newValue;
    });
    
    self.password = Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.passwordTextField.text = newValue;
    });
    
    self.instruction = Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.instructionLabel.text = newValue;
    });
    
    self.usernameValid = Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.usernameTextField.backgroundColor = [newValue boolValue] ? [UIColor whiteColor] : LightRed;
    });
    
    self.passwordValid = Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.passwordTextField.backgroundColor = [newValue boolValue] ? [UIColor whiteColor] : LightRed;
    });
    
    self.loginEnabled = Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.loginButton.enabled = [newValue boolValue];
        self.loginButton.backgroundColor = [newValue boolValue] ? ThemeColor : LightGray;
        [self.loginButton setTitleColor:[newValue boolValue] ? [UIColor whiteColor] : [UIColor darkGrayColor] forState:UIControlStateNormal];
    });
}

-(void)makeActionsEmittings{
    self.usernameDidChange = Observable.create(nil);
    self.passwordDidChange = Observable.create(nil);
    self.loginButtonTouched = Observable.create(nil);
}

//MARK: Actions
-(void)login{
    self.loginButtonTouched.value = nil;
}

-(void)usernameChanged{
    self.usernameDidChange.value = self.usernameTextField.text;
}

-(void)passwordChanged{
    self.passwordDidChange.value = self.passwordTextField.text;
}

//MARK: Getters & Setters
-(UIImageView *)avatarImageView{
    if(!_avatarImageView){
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.5*UIScreen.mainScreen.bounds.size.width - 75, 90, 150, 150)];
        _avatarImageView.backgroundColor = LightBlue;
        _avatarImageView.layer.cornerRadius = 75;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.image = [UIImage imageNamed:@"avatar.jpg"];
    }
    return _avatarImageView;
}
-(UITextField *)usernameTextField{
    if(!_usernameTextField){
        _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(64, 280, UIScreen.mainScreen.bounds.size.width - 20 - 40 - 20, 40)];
        _usernameTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _usernameTextField.backgroundColor = [UIColor colorWithRed:1.0*0xCC/0xFF green:1.0*0xCC/0xFF blue:1.0*0xFF/0xFF alpha:1.0];
        _usernameTextField.layer.cornerRadius = 20;
        _usernameTextField.layer.masksToBounds = YES;
        _usernameTextField.placeholder = @"请输入用户名";
        _usernameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 10)];
        _usernameTextField.leftViewMode = UITextFieldViewModeAlways;
        _usernameTextField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 10)];
        _usernameTextField.rightViewMode = UITextFieldViewModeAlways;
        _usernameTextField.textColor = [UIColor colorWithWhite:1.0*0x1A/0xFF alpha:1.0];
    }
    return _usernameTextField;
}

-(UITextField *)passwordTextField{
    if(!_passwordTextField){
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(64, 340, UIScreen.mainScreen.bounds.size.width - 20 - 40 - 20, 40)];
        _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.backgroundColor = [UIColor colorWithRed:1.0*0xCC/0xFF green:1.0*0xCC/0xFF blue:1.0*0xFF/0xFF alpha:1.0];
        _passwordTextField.layer.cornerRadius = 20;
        _passwordTextField.layer.masksToBounds = YES;
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 10)];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 10)];
        _passwordTextField.rightViewMode = UITextFieldViewModeAlways;
        _passwordTextField.textColor = [UIColor colorWithWhite:1.0*0x1A/0xFF alpha:1.0];
    }
    return _passwordTextField;
}

-(UILabel *)instructionLabel{
    if(!_instructionLabel){
        _instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 420, UIScreen.mainScreen.bounds.size.width - 20, 24)];
        _instructionLabel.textColor = [UIColor systemRedColor];
        _instructionLabel.font = [UIFont systemFontOfSize:14];
    }
    return _instructionLabel;
}

-(UIButton *)loginButton{
    if(!_loginButton){
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.frame = CGRectMake(20, 450, UIScreen.mainScreen.bounds.size.width - 40, 40);
        _loginButton.backgroundColor = [UIColor systemBlueColor];
        [_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _loginButton.layer.cornerRadius = 20;
        _loginButton.layer.masksToBounds = YES;
    }
    return _loginButton;
}

-(UILabel *)usernameLabel{
    if(!_usernameLabel){
        _usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 280, 40, 40)];
        _usernameLabel.text = @"用户";
        _usernameLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        _usernameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _usernameLabel;
}

-(UILabel *)passwordLabel{
    if(!_passwordLabel){
        _passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 340, 40, 40)];
        _passwordLabel.text = @"密码";
        _passwordLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        _passwordLabel.font = [UIFont systemFontOfSize:16];
    }
    return _passwordLabel;
}

@end
