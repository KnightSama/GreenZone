//
//  NSManagedObject+helper.h
//  agent
//
//  Created by LiMing on 14-6-24.
//  Copyright (c) 2014年 bangban. All rights reserved.
//




//上下文分类，提供数据库增删查该方法
#import <CoreData/CoreData.h>
#import "mmDAO.h"
#import <Foundation/Foundation.h>

typedef void(^ListResult)(NSArray* result, NSError *error);
typedef void(^ObjectResult)(id result, NSError *error);
typedef id(^AsyncProcess)(NSManagedObjectContext *ctx, NSString *className);


@interface NSManagedObject (helper)

//创建一个数据对象
+(id)createNew;
//保存数据
+(NSError*)save:(OperationResult)handler;



//根据指定条件查询数据,数据结果通过ListResult  block返回
+(void)filter:(NSString *)predicate orderby:(NSArray *)orders offset:(int)offset limit:(int)limit on:(ListResult)handler;

+(void)delobject:(id)object;

+(id)one:(NSString*)predicate;

+(void)one:(NSString*)predicate on:(ObjectResult)handler;

+(NSArray*)filter:(NSString *)predicate orderby:(NSArray *)orders offset:(int)offset limit:(int)limit;

+(void)async:(AsyncProcess)processBlock result:(ListResult)resultBlock;
@end
