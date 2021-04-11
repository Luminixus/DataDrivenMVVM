//
//  Observer.h
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Observable;
/// 观察者
@protocol Observer <NSObject>

/// 订阅可观察对象
@property(copy, nonatomic, readonly) void (^subscribe)(id<Observable> observable);

/// 触发值刷新
-(void)invoke:(id)newValue;

@end

/// 观察者所注册的操作
typedef void(^ObserverHandler)(id newValue);


/// 观察者
@interface Observer : NSObject <Observer>

/// 构建
@property(copy, nonatomic, class, readonly) Observer *(^create)(void);

/// 处理值刷新
@property(copy, nonatomic, readonly) Observer * (^handle)(ObserverHandler);

@end

NS_ASSUME_NONNULL_END
