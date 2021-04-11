//
//  ViewModel.h
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/4.
//

#import "Observable.h"
#import "ObservableCombiner.h"
#import "Observer.h"

#define WS __weak typeof(self) weakSelf = self;
#define SS __strong typeof(weakSelf) self = weakSelf;

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

//MARK: 数据驱动UI刷新
@property(strong, nonatomic) Observable *username;

@property(strong, nonatomic) Observable *password;

@property(strong, nonatomic) Observable *instruction;

@property(strong, nonatomic) ObservableCombiner *usernameValid;

@property(strong, nonatomic) ObservableCombiner *passwordValid;

@property(strong, nonatomic) ObservableCombiner *loginEnabled;

//MARK: 用户交互动作订阅
@property(strong, nonatomic) Observer *usernameDidChange;

@property(strong, nonatomic) Observer *passwordDidChange;

@property(strong, nonatomic) Observer *loginTouched;

@end

NS_ASSUME_NONNULL_END
