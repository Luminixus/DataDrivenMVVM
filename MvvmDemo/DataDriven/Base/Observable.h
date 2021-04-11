//
//  Observable.h
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Observer;
/// 可观察对象，value 成员更新 setter 会驱动注册的观察者刷新。注册观察者后，观察者被可观察对象强持有
@protocol Observable <NSObject>

/// 值
@property(strong, nonatomic, nullable) id value;

/// 添加观察者
-(void)addObserver:(id<Observer>)observer;

/// 移除观察者
-(void)removeObserver:(id<Observer>)observer;

@end


/// 可观察对象
@interface Observable : NSObject<Observable>

/// 构建
@property(copy, nonatomic, class, readonly) Observable *(^create)(id _Nullable defaultValue);

@end

NS_ASSUME_NONNULL_END
