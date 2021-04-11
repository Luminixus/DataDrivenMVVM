//
//  ObservableCombiner.m
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/3.
//

#import "ObservableCombiner.h"
#import "Observer.h"

@interface ObservableCombiner ()

@property(strong, nonatomic) NSMutableArray *observables;

@property(assign, nonatomic) CombineStrategy strategy;

@property(assign, nonatomic) NSUInteger accessFlags;

@property(copy, nonatomic) ObservableCombiner * (^combine)(id<Observable> observable);

@property(copy, nonatomic) ObservableCombiner * (^handle)(CombinerHandler);

@property(copy, nonatomic) CombinerHandler handler;

@end

@implementation ObservableCombiner

static ObservableCombiner *(^create)(CombineStrategy strategy) = ^ObservableCombiner *(CombineStrategy strategy){
    ObservableCombiner *combiner = [[ObservableCombiner alloc] init];
    combiner.strategy = strategy;
    return combiner;
};

+(ObservableCombiner *(^)(CombineStrategy))create{
    return create;
}

-(ObservableCombiner * (^)(id<Observable>))combine{
    if(!_combine){
        __weak typeof(self) weakSelf = self;
        _combine = ^ObservableCombiner * (id<Observable> observable){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            NSInteger index = strongSelf.observables.count;
            id<Observer> observer = Observer.create().handle(^(id  _Nonnull newValue) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf handleNewValue:newValue index:index];
            });
            
            [observable addObserver:observer];
            [strongSelf.observables addObject:observable];
            return strongSelf;
        };
    }
    return _combine;
}

-(ObservableCombiner * (^)(CombinerHandler))handle{
    if(!_handle){
        __weak typeof(self) weakSelf = self;
        _handle = ^ObservableCombiner *(CombinerHandler handler){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.handler = handler;
            return strongSelf;
        };
    }
    return _handle;
}

-(NSMutableArray *)observables{
    if(!_observables){
        _observables = [[NSMutableArray alloc] init];
    }
    return _observables;
}

-(void)handleNewValue:(id)newValue index:(NSInteger)index{
    //TODO: 根据不同的策略触发完成事件
    BOOL isFirst = !self.accessFlags;
    self.accessFlags |= (1 << index);
    switch (self.strategy) {
        case CombineStrategyFirst:{
            if(isFirst){
                self.value = self.handler([self getAllValues]);
            }
        }break;
        
        case CombineStrategyEvery:{
            self.value = self.handler([self getAllValues]);
        }break;
        
        case CombineStrategyAll:{
            NSUInteger allFlags = pow(2, self.observables.count) - 1;
            BOOL isAll = (allFlags & self.accessFlags) == allFlags;
            if(isAll){
                self.value = self.handler([self getAllValues]);
            }
        }break;
            
        default:
            break;
    }
}

-(NSArray *)getAllValues{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(id<Observable> observable in self.observables){
        [result addObject:observable.value ?: [NSNull null]];
    }
    return result;
}

static id _Nullable (^safeValue)(NSArray *, NSInteger) = ^id (NSArray *values, NSInteger index){
    return values[index] == [NSNull null] ? nil : values[index];
};

+(id  _Nullable (^)(NSArray * _Nonnull, NSInteger))safeValue{
    return safeValue;
}

@end
