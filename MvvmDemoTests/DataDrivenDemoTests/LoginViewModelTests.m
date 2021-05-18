//
//  LoginViewModelTests.m
//  MvvmDemoTests
//
//  Created by Luminixus on 2021/5/18.
//

#import <XCTest/XCTest.h>
#import "LoginViewModel.h"

@interface LoginViewModelTests : XCTestCase

@property(strong, nonatomic) LoginViewModel *viewModel;

@end

@implementation LoginViewModelTests

- (void)setUp {
    self.viewModel = [[LoginViewModel alloc] init];
}

- (void)tearDown {
    self.viewModel = nil;
}

- (void)testInit {
    XCTAssertNotNil(self.viewModel.username);
    XCTAssertNotNil(self.viewModel.password);
    XCTAssertNotNil(self.viewModel.usernameValid);
    XCTAssertNotNil(self.viewModel.passwordValid);
    XCTAssertNotNil(self.viewModel.instruction);
    XCTAssertNotNil(self.viewModel.loginEnabled);
}

- (void)testUsername {
    NSString *maruko = @"Maruko";
    
    Observer.create().handle(^(id  _Nonnull newValue) {
        XCTAssert([newValue isEqualToString:maruko]);
    }).subscribe(self.viewModel.username);
    
    self.viewModel.username.value = maruko;
}

- (void)testPassword {
    NSString *pwd = @"123456";
    
    Observer.create().handle(^(id  _Nonnull newValue) {
        XCTAssert([newValue isEqualToString:pwd]);
    }).subscribe(self.viewModel.password);
    
    self.viewModel.password.value = pwd;
}

- (void)testUsernameValid_usernameCantBeShorterThan6 {
    NSString *shortName = @"Tsu";
    
    Observer.create().handle(^(id  _Nonnull newValue) {
        XCTAssertFalse([newValue boolValue]);
    }).subscribe(self.viewModel.usernameValid);
    
    self.viewModel.username.value = shortName;
}

- (void)testUsernameValid_usernameCantBeLongerThan24 {
    NSString *longName = @"Tsu01234567890123456789Tsu";
    
    Observer.create().handle(^(id  _Nonnull newValue) {
        XCTAssertFalse([newValue boolValue]);
    }).subscribe(self.viewModel.usernameValid);
    
    self.viewModel.username.value = longName;
}

- (void)testUsernameDidChange_usernameChangeSynchronously {
    Observable *action = Observable.create(nil);
    self.viewModel.usernameDidChange.subscribe(action);
    
    action.value = @"Maruko";
    
    XCTAssertTrue([@"Maruko" isEqualToString:self.viewModel.username.value]);
}

- (void)testLoginTouched_instructionShowSuccess {
    Observable *action = Observable.create(nil);
    self.viewModel.loginTouched.subscribe(action);
    
    action.value = nil;
    
    XCTAssertTrue([@"登录成功(*^▽^*)" isEqualToString:self.viewModel.instruction.value]);
}

// And So On

@end
