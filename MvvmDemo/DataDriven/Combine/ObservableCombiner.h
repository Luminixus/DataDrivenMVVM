//
//  ObservableCombiner.h
//  MvvmDemo
//
//  Created by Luminixus on 2021/4/3.
//

#import "Observable.h"

NS_ASSUME_NONNULL_BEGIN

/// 合成可观察对象的触发策略
typedef NS_ENUM(NSUInteger, CombineStrategy) {
    /// 第一次值更新才刷新
    CombineStrategyFirst,
    /// 所有值更新才刷新
    CombineStrategyAll,
    /// 任何值更新均刷新
    CombineStrategyEvery,
};

/// 合成可观察对象处理值刷新
typedef _Nullable id (^CombinerHandler)(NSArray *newValues);

/// 合成多个可观察对象
@interface ObservableCombiner : Observable

/// 安全获取值
@property(copy, nonatomic, readonly, class) id _Nullable (^safeValue)(NSArray *, NSInteger);

/// 构建
@property(copy, nonatomic, readonly, class) ObservableCombiner *(^create)(CombineStrategy strategy);

/// 合并可观察对象
@property(copy, nonatomic, readonly) ObservableCombiner * (^combine)(id<Observable> observable);

/// 处理值刷新
@property(copy, nonatomic, readonly) ObservableCombiner * (^handle)(CombinerHandler);

@end

NS_ASSUME_NONNULL_END
