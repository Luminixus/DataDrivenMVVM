//
//  ViewModel.m
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/4.
//

#import "LoginViewModel.h"

#define WS __weak typeof(self) weakSelf = self;
#define SS __strong typeof(weakSelf) self = weakSelf;

@implementation LoginViewModel

-(instancetype)init{
    if(self = [super init]){
        self.username = Observable.create(nil);
        self.password = Observable.create(nil);

        self.usernameValid = ObservableCombiner.create(CombineStrategyEvery);
        self.passwordValid = ObservableCombiner.create(CombineStrategyEvery);
        self.instruction = ObservableCombiner.create(CombineStrategyEvery);
        self.loginEnabled = ObservableCombiner.create(CombineStrategyEvery);
        
        [self doDataWeaving];
        
        [self doActionProcessing];
    }
    return self;
}

-(void)doDataWeaving{
    //NOTE: 数据组织时尽量不要在handle中调用view model自身，尽量用传入handle的参数值去驱动
    self.usernameValid
        .combine(self.username)
        .handle(^id _Nullable(NSArray * _Nonnull newValues) {
            NSString *username = ObservableCombiner.safeValue(newValues, 0);
            return @(username.length && username.length >= 6 && username.length <= 24);
        });
    
    self.passwordValid
        .combine(self.password)
        .handle(^id _Nullable(NSArray * _Nonnull newValues) {
            NSString *password = ObservableCombiner.safeValue(newValues, 0);
            return @(password.length && password.length >= 6 && password.length <= 24);
        });
    
    self.instruction
        .combine(self.username)
        .combine(self.password)
        .handle(^id _Nullable(NSArray * _Nonnull newValues) {
            NSString *username = ObservableCombiner.safeValue(newValues, 0);
            if(!username.length){
                return @"*用户名不能为空";
            }
            if(username.length < 6){
                return @"*用户名必须超过6个字符";
            }
            if(username.length > 24){
                return @"*用户名不能超过24个字符";
            }
            
            NSString *password = ObservableCombiner.safeValue(newValues, 1);
            if(!password.length){
                return @"*密码不能为空";
            }
            if(password.length < 6){
                return @"*密码必须超过6个字符";
            }
            if(password.length > 24){
                return @"*密码不能超过24个字符";
            }
            
            return @"";
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

-(void)doActionProcessing{
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
        SS
        self.instruction.value = [NSString stringWithFormat:@"登录成功(*^▽^*)"];
    });
}

@end
