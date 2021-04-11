//
//  ViewController.m
//  MvvmDemo
//
//  Created by Luminixus on 2021/3/14.
//

#import "ViewController.h"
#import "Observable.h"
#import "Observer.h"
#import "ObservableCombiner.h"
#import "LoginViewController.h"
#import "MVCLoginViewController.h"

@interface ViewController ()

@property(strong, nonatomic) Observable *observable1;

@property(strong, nonatomic) Observable *observable2;

@property(strong, nonatomic) ObservableCombiner *observableCombiner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.observable1 = [[Observable alloc] init];
//    self.observable2 = [[Observable alloc] init];
//    self.observableCombiner = ObservableCombiner.create(CombineStrategyAll)
//    .combine(self.observable1)
//    .combine(self.observable2)
//    .handle(^id _Nullable(NSArray * _Nonnull newValues) {
//        return [NSString stringWithFormat:@"(%@, %@)", newValues[0], newValues[1]];
//    });
//
//    Observer.create().handle(^(id newValue) {
//        NSLog(@"block new value: %@", newValue);
//    }).subscribe(self.observable1);
//
//    Observer.create().handle(^(id newValue) {
//        NSLog(@"combined new value: %@", newValue);
//    }).subscribe(self.observableCombiner);
//
//    self.observable1.value = @"咔咔咔";
//    self.observable2.value = @"嘻嘻嘻";
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    vc.view.frame = UIScreen.mainScreen.bounds;
    
//    MVCLoginViewController *vc = [[MVCLoginViewController alloc] init];
//    [self addChildViewController:vc];
//    [self.view addSubview:vc.view];
//    vc.view.frame = UIScreen.mainScreen.bounds;
}

//-(void)handle:(id)newValue{
//    NSLog(@"target action new value: %@", newValue);
//}

@end
