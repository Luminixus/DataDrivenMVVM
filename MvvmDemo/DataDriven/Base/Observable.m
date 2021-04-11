//
//  Observable.m
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/3.
//

#import "Observable.h"
#import "Observer.h"

@interface Observable ()

@property(strong, nonatomic) NSMutableArray *observers;

@end

@implementation Observable

@synthesize value = _value;

-(void)setValue:(id)value{
    if(![self.value isEqual:value]){
        _value = value;
        for(id<Observer> observer in self.observers){
            [observer invoke:value];
        }
    }
}

static Observable *(^create)(id) = ^Observable *(id defaultValue){
    Observable *observable = [[Observable alloc] init];
    observable.value = defaultValue;
    return observable;
};

+(Observable *(^)(id))create{
    return create;
}


-(void)addObserver:(id<Observer>)observer{
    [self.observers addObject:observer];
}

-(void)removeObserver:(id<Observer>)observer{
    [self.observers removeObject:observer];
}

-(NSMutableArray *)observers{
    if(!_observers){
        _observers = [[NSMutableArray alloc] init];
    }
    return _observers;
}

@end
