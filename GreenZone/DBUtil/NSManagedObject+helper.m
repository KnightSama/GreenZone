//
//  NSManagedObject+helper.m
//  agent
//
//  Created by LiMing on 14-6-24.
//  Copyright (c) 2014年 bangban. All rights reserved.
//

#import "NSManagedObject+helper.h"

@implementation NSManagedObject (helper)
//创建一个新的数据对象
+(id)createNew{
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    return [NSEntityDescription insertNewObjectForEntityForName:className inManagedObjectContext:[mmDAO instance].mainObjectContext];
}

//保存数据
+(NSError*)save:(OperationResult)handler{
    return [[mmDAO instance] save:handler];
}

//在指定上下文中、用对应谓词条件、顺序、数据偏移位置、查询上限
+(NSFetchRequest*)makeRequest:(NSManagedObjectContext*)ctx predicate:(NSString*)predicate orderby:(NSArray*)orders offset:(int)offset limit:(int)limit{
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:className inManagedObjectContext:ctx]];
    if (predicate) {
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:predicate]];
    }
    NSMutableArray *orderArray = [[NSMutableArray alloc] init];
    if (orders!=nil) {
        for (NSString *order in orders) {
            NSSortDescriptor *orderDesc = nil;
            if ([[order substringToIndex:1] isEqualToString:@"-"]) {
                orderDesc = [[NSSortDescriptor alloc] initWithKey:[order substringFromIndex:1]
                                                        ascending:NO];
            }else{
                orderDesc = [[NSSortDescriptor alloc] initWithKey:order
                                                        ascending:YES];
                [orderArray addObject:orderDesc];
            }
        }
        [fetchRequest setSortDescriptors:orderArray];
    }
    if (offset>0) {
        [fetchRequest setFetchOffset:offset];
    }
    if (limit>0) {
        //-setFetchLimit: 设置最大查询对象数目
        [fetchRequest setFetchLimit:limit];
    }
    return fetchRequest;
}

//根据指定条件查询数据,数据结果通过ListResult这个block把结果返回
+(void)filter:(NSString *)predicate orderby:(NSArray *)orders offset:(int)offset limit:(int)limit on:(ListResult)handler{

    NSLog(@"执行了");
    
    //创建一个私有上下文进行查询（不会堵塞主线程）
    NSManagedObjectContext *ctx = [[mmDAO instance] createPrivateObjectContext];
    [ctx performBlock:^{
        NSFetchRequest *fetchRequest = [self makeRequest:ctx predicate:predicate orderby:orders offset:offset limit:limit];
        NSError* error = nil;
        NSArray* results = [ctx executeFetchRequest:fetchRequest error:&error];
        if (error) {
            NSLog(@"error: %@", error);
            [[mmDAO instance].mainObjectContext performBlock:^{
                handler(@[], nil);
            }];
        }
//        if ([results count]<1) {
//            [[mmDAO instance].mainObjectContext performBlock:^{
//                handler(@[], nil);
//            }];
//        }
        //数据库模型对象不能跨线程访问，因此这里将数据库对象的id存起来，然后在主线程中根据这些id再恢复数据对象
        NSMutableArray *result_ids = [[NSMutableArray alloc] init];
        for (NSManagedObject *item  in results) {
            [result_ids addObject:item.objectID];
        }
        
        //查询完成后回到主线程把数据返回出去
        [[mmDAO instance].mainObjectContext performBlock:^{
            NSMutableArray *final_results = [[NSMutableArray alloc] init];
            for (NSManagedObjectID *oid in result_ids) {
                [final_results addObject:[[mmDAO instance].mainObjectContext objectWithID:oid]];
            }
            handler(final_results, nil);
        }];
    }];
}

//删除数据对象
+(void)delobject:(id)object{
    [[mmDAO instance].mainObjectContext deleteObject:object];
    [self save:^(NSError *error) {
        NSLog(@"删除成功");
    }];
}

//返回一个数据对象
+(id)one:(NSString*)predicate{
    NSManagedObjectContext *ctx = [mmDAO instance].mainObjectContext;
    NSFetchRequest *fetchRequest = [self makeRequest:ctx predicate:predicate orderby:nil offset:0 limit:1];
    NSError* error = nil;
    NSArray* results = [ctx executeFetchRequest:fetchRequest error:&error];
    if ([results count]!=1) {
        raise(1);
    }
    return results[0];
}



+(void)one:(NSString*)predicate on:(ObjectResult)handler{
    NSManagedObjectContext *ctx = [[mmDAO instance] createPrivateObjectContext];
    [ctx performBlock:^{
        NSFetchRequest *fetchRequest = [self makeRequest:ctx predicate:predicate orderby:nil offset:0 limit:1];
        NSError* error = nil;
        NSArray* results = [ctx executeFetchRequest:fetchRequest error:&error];
        if (error) {
            NSLog(@"error: %@", error);
            [[mmDAO instance].mainObjectContext performBlock:^{
                handler(@[], nil);
            }];
        }
        if ([results count]<1) {
            [[mmDAO instance].mainObjectContext performBlock:^{
                handler(@[], nil);
            }];
        }
        NSManagedObjectID *objId = ((NSManagedObject*)results[0]).objectID;
        [[mmDAO instance].mainObjectContext performBlock:^{
            handler([[mmDAO instance].mainObjectContext objectWithID:objId], nil);
        }];
    }];
}


//查询操作
+(NSArray*)filter:(NSString *)predicate orderby:(NSArray *)orders offset:(int)offset limit:(int)limit{

    NSManagedObjectContext *ctx = [mmDAO instance].mainObjectContext;
    NSFetchRequest *fetchRequest = [self makeRequest:ctx predicate:predicate orderby:orders offset:offset limit:limit];

    NSError* error = nil;
    NSArray* results = [ctx executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"error: %@", error);
        return @[];
    }
    return results;
}


+(void)async:(AsyncProcess)processBlock result:(ListResult)resultBlock{
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSManagedObjectContext *ctx = [[mmDAO instance] createPrivateObjectContext];
    [ctx performBlock:^{
        id resultList = processBlock(ctx, className);
        if (resultList) {
            if ([resultList isKindOfClass:[NSError class]]) {
                [[mmDAO instance].mainObjectContext performBlock:^{
                    resultBlock(nil, resultList);
                }];
            }
            if ([resultList isKindOfClass:[NSArray class]]) {
                NSMutableArray *idArray = [[NSMutableArray alloc] init];
                for (NSManagedObject *obj in resultList) {
                    [idArray addObject:obj.objectID];
                }
                NSArray *objectIdArray = [idArray copy];
                [[mmDAO instance].mainObjectContext performBlock:^{
                    NSMutableArray *objArray = [[NSMutableArray alloc] init];
                    for (NSManagedObjectID *robjId in objectIdArray) {
                        [objArray addObject:[[mmDAO instance].mainObjectContext objectWithID:robjId]];
                    }
                    if (resultBlock) {
                        resultBlock([objArray copy], nil);
                    }
                }];
            }

        }else{
            resultBlock(nil, nil);
        }
    }];
}

@end
