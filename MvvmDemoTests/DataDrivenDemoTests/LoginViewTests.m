//
//  LoginViewTests.m
//  MvvmDemoTests
//
//  Created by Luminixus on 2021/5/18.
//

#import <XCTest/XCTest.h>
#import "LoginView.h"

@interface LoginViewTests : XCTestCase

@property(strong, nonatomic) LoginView *loginView;

@end

@implementation LoginViewTests

- (void)setUp {
    self.loginView = [[LoginView alloc] init];
}

- (void)tearDown {
    self.loginView = nil;
}

- (void)testUsername {
    Observable *username = Observable.create(nil);
    self.loginView.username.subscribe(username);
    
    username.value = @"maruko";
    
    XCTAssertTrue([@"maruko" isEqualToString:self.loginView.usernameTextField.text]);
}

- (void)testPassword {
    Observable *pwd = Observable.create(nil);
    self.loginView.password.subscribe(pwd);
    
    pwd.value = @"123456";
    
    XCTAssertTrue([@"123456" isEqualToString:self.loginView.passwordTextField.text]);
}

- (void)testUsernameValid_whenUsernameInvalid_backgroundLightRed {
    Observable *usernameValid = Observable.create(nil);
    self.loginView.usernameValid.subscribe(usernameValid);
    
    usernameValid.value = @(NO);
    
    CGFloat lightRedR, lightRedG, lightRedB, lightRedA;
    [LightRed getRed:&lightRedR green:&lightRedG blue:&lightRedB alpha:&lightRedA];
    CGFloat bgR, bgG, bgB, bgA;
    [self.loginView.usernameTextField.backgroundColor getRed:&bgR green:&bgG blue:&bgB alpha:&bgA];
    XCTAssertEqual(lightRedR, bgR);
    XCTAssertEqual(lightRedG, bgG);
    XCTAssertEqual(lightRedB, bgB);
    XCTAssertEqual(lightRedA, bgA);
}

- (void)testPasswordValid_whenPasswordInvalid_backgroundLightRed {
    Observable *passwordValid = Observable.create(nil);
    self.loginView.passwordValid.subscribe(passwordValid);
    
    passwordValid.value = @(NO);
    
    CGFloat lightRedR, lightRedG, lightRedB, lightRedA;
    [LightRed getRed:&lightRedR green:&lightRedG blue:&lightRedB alpha:&lightRedA];
    CGFloat bgR, bgG, bgB, bgA;
    [self.loginView.passwordTextField.backgroundColor getRed:&bgR green:&bgG blue:&bgB alpha:&bgA];
    XCTAssertEqual(lightRedR, bgR);
    XCTAssertEqual(lightRedG, bgG);
    XCTAssertEqual(lightRedB, bgB);
    XCTAssertEqual(lightRedA, bgA);
}

// And So On

@end
