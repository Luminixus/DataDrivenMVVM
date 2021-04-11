//
//  Observer.m
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/3.
//

#import "Observer.h"
#import "Observable.h"

@interface Observer ()

@property(copy, nonatomic) Observer * (^handle)(ObserverHandler);

@property(copy, nonatomic) ObserverHandler handler;

@end

@implementation Observer

@synthesize subscribe = _subscribe;

-(void (^)(id<Observable>))subscribe{
    if(!_subscribe){
        __weak typeof(self) weakSelf = self;
        _subscribe = ^(id<Observable> observable){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [observable addObserver:strongSelf];
        };
    }
    return _subscribe;
}

-(void)invoke:(id)newValue{
    if(self.handler){
        self.handler(newValue);
    }
}

static Observer *(^create)(void) = ^Observer *(){
    Observer *observer = [[Observer alloc] init];
    return observer;
};

+(Observer *(^)(void))create{
    return create;
}

-(Observer * (^)(ObserverHandler))handle{
    if(!_handle){
        __weak typeof(self) weakSelf = self;
        _handle = ^Observer *(ObserverHandler handler){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.handler = handler;
            return strongSelf;
        };
    }
    return _handle;
}

@end
