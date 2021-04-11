//
//  MVCViewController.m
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/4.
//

#import "MVCLoginViewController.h"
#import "MVCLoginView.h"

@interface MVCLoginViewController ()

@property(strong, nonatomic) MVCLoginView *loginView;

@end

@implementation MVCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginView = [[MVCLoginView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.view addSubview:self.loginView];
    
    [self doBindings];
    
    [self initStates];
}

-(void)doBindings{
    [self.loginView.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.usernameTextField addTarget:self action:@selector(usernameChanged) forControlEvents:UIControlEventEditingChanged];
    [self.loginView.passwordTextField addTarget:self action:@selector(passwordChanged) forControlEvents:UIControlEventEditingChanged];
}

-(void)initStates{
    self.loginView.usernameTextField.text = @"maruko";
    self.loginView.passwordTextField.text = @"1234";
    
    [self usernameChanged];
    [self passwordChanged];
}

//MARK: Actions
-(void)login{
    self.loginView.instructionLabel.text = [NSString stringWithFormat:@"登录成功(*^▽^*)"];
}

-(void)usernameChanged{
    NSString *usernameInstruction = [self usernameValid];
    BOOL passwordValid = ![self passwordValid].length;
    self.loginView.usernameTextField.backgroundColor = !usernameInstruction.length ? [UIColor whiteColor] : LightRed;
    
    if(usernameInstruction.length){
        self.loginView.instructionLabel.text = usernameInstruction;
    }else{
        if(passwordValid){
            self.loginView.instructionLabel.text = @"";
        }
    }
    
    [self refreshLoginButton:!usernameInstruction.length && !passwordValid];
}

-(void)passwordChanged{
    NSString *passwordInstruction = [self passwordValid];
    self.loginView.passwordTextField.backgroundColor = !passwordInstruction.length ? [UIColor whiteColor] : LightRed;
    
    BOOL usernameValid = ![self usernameValid].length;
    if(usernameValid){
        self.loginView.instructionLabel.text = passwordInstruction;
    }
    
    [self refreshLoginButton:usernameValid && !passwordInstruction.length];
}

-(void)refreshLoginButton:(BOOL)loginEnabled{
    self.loginView.loginButton.enabled = loginEnabled;
    self.loginView.loginButton.backgroundColor = loginEnabled ? ThemeColor : LightGray;
    [self.loginView.loginButton setTitleColor:loginEnabled ? [UIColor whiteColor] : [UIColor darkGrayColor] forState:UIControlStateNormal];
}

-(NSString *)passwordValid{
    NSString *password = self.loginView.passwordTextField.text;
    NSString *passwordInstruction;
    if(!password.length){
        passwordInstruction = @"*密码不能为空";
    }else if(password.length < 6){
        passwordInstruction = @"*密码必须超过6个字符";
    }else if(password.length > 24){
        passwordInstruction = @"*密码不能超过24个字符";
    }else{
        passwordInstruction = @"";
    }
    return passwordInstruction;
}

-(NSString *)usernameValid{
    NSString *username = self.loginView.usernameTextField.text;
    NSString *usernameInstruction;
    if(!username.length){
        usernameInstruction = @"*用户名不能为空";
    }else if(username.length < 6){
        usernameInstruction = @"*用户名必须超过6个字符";
    }else if(username.length > 24){
        usernameInstruction = @"*用户名不能超过24个字符";
    }else{
        usernameInstruction = @"";
    }
    return usernameInstruction;
}

@end
