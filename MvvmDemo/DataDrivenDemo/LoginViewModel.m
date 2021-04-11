//
//  ViewModel.m
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/4.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

-(instancetype)init{
    if(self = [super init]){
        self.username = Observable.create(nil);
        self.password = Observable.create(nil);
        self.instruction = Observable.create(nil);

        self.usernameValid = ObservableCombiner.create(CombineStrategyEvery);
        self.passwordValid = ObservableCombiner.create(CombineStrategyEvery);
        self.loginEnabled = ObservableCombiner.create(CombineStrategyEvery);
        
        [self doDataBindings];
        
        [self doActionBindings];
    }
    return self;
}

-(void)doDataBindings{
    self.usernameValid
        .combine(self.username)
        .combine(self.passwordValid)
        .handle(^id _Nullable(NSArray * _Nonnull newValues) {
            NSString *username = ObservableCombiner.safeValue(newValues, 0);
            if(!username.length){
                self.instruction.value = @"*用户名不能为空";
                return @(NO);
            }
            
            if(username.length < 6){
                self.instruction.value = @"*用户名必须超过6个字符";
                return @(NO);
            }
            
            if(username.length > 24){
                self.instruction.value = @"*用户名不能超过24个字符";
                return @(NO);
            }
            
            BOOL passwordValid = [ObservableCombiner.safeValue(newValues, 1) boolValue];
            if(passwordValid){
                self.instruction.value = @"";
            }
            return @(YES);
        });
    
    self.passwordValid
        .combine(self.usernameValid)
        .combine(self.password)
        .handle(^id _Nullable(NSArray * _Nonnull newValues) {
            NSString *password = ObservableCombiner.safeValue(newValues, 1);
            BOOL usernameValid = [ObservableCombiner.safeValue(newValues, 0) boolValue];
            
            BOOL passwordValid;
            NSString *passwordInstruction;
            if(!password.length){
                passwordInstruction = @"*密码不能为空";
                passwordValid = NO;
            }else if(password.length < 6){
                passwordInstruction = @"*密码必须超过6个字符";
                passwordValid = NO;
            }else if(password.length > 24){
                passwordInstruction = @"*密码不能超过24个字符";
                passwordValid = NO;
            }else{
                passwordInstruction = @"";
                passwordValid = YES;
            }
            
            if(usernameValid){
                self.instruction.value = passwordInstruction;
            }
            return @(passwordValid);
        });
    
    self.loginEnabled
        .combine(self.usernameValid)
        .combine(self.passwordValid)
        .handle(^id _Nullable(NSArray * _Nonnull newValues) {
            BOOL usernameValid = [ObservableCombiner.safeValue(newValues, 0) boolValue];
            BOOL passworkValid = [ObservableCombiner.safeValue(newValues, 1) boolValue];
            return @(usernameValid && passworkValid);
        });
}

-(void)doActionBindings{
    WS
    // 用户交互处理
    self.usernameDidChange = Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.username.value = newValue;
    });
    self.passwordDidChange = Observer.create().handle(^(id  _Nonnull newValue) {
        SS
        self.password.value = newValue;
    });
    self.loginTouched = Observer.create().handle(^(id  _Nonnull newValue) {
        self.instruction.value = [NSString stringWithFormat:@"登录成功(*^▽^*)"];
    });
}

@end
