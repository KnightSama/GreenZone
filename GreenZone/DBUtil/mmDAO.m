//
//  mmDAO.m
//  agent
//
//  Created by LiMing on 14-6-24.
//  Copyright (c) 2014年 bangban. All rights reserved.
//

#import "mmDAO.h"

static mmDAO *onlyInstance;

@interface mmDAO ()
@property (nonatomic, copy)NSString *modelName;
@property (nonatomic, copy)NSString *dbFileName;
@end

@implementation mmDAO
+(mmDAO*)instance{
    //只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        onlyInstance = [[mmDAO alloc] init];
    });
    return onlyInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void) setupEnvModel:(NSString *)model DbFile:(NSString*)filename{
    _modelName = model;
    _dbFileName = filename;
    [self initCoreDataStack];
}

//初始化上下文
//NSConfinementConcurrencyType (或者不加参数，默认就是这个)
//NSMainQueueConcurrencyType (表示只会在主线程中执行)
//NSPrivateQueueConcurrencyType (表示可以在子线程中执行)
- (void)initCoreDataStack
{
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];//创建持续化存储区
    if (coordinator != nil) {
        _bgObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_bgObjectContext setPersistentStoreCoordinator:coordinator];
        _mainObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_mainObjectContext setParentContext:_bgObjectContext];
    }
}


//创建私有上下文，做一些查询操作
- (NSManagedObjectContext *)createPrivateObjectContext
{
    NSManagedObjectContext *ctx = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [ctx setParentContext:_mainObjectContext];

    return ctx;
}


- (NSManagedObjectModel *)managedObjectModel
{
    NSManagedObjectModel *managedObjectModel;
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:_modelName withExtension:@"momd"];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    NSPersistentStoreCoordinator *persistentStoreCoordinator = nil;
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:_dbFileName];
   
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


//保存数据
-(NSError*)save:(OperationResult)handler{
    NSError *error;
    //_mainObjectContext主线程的上下文变动了
    if ([_mainObjectContext hasChanges]) {
        //子级上下文save了，父级上下文也得save一次
        [_mainObjectContext save:&error];
        //_bgObjectContext最底层的上下文，专门用于执行数据库的变动操作
        [_bgObjectContext performBlock:^{
            __block NSError *inner_error = nil;
            [_bgObjectContext save:&inner_error];
            //保存完后重新回到主线程_mainObjectContext上下文，把error传出去
            if (handler){
                [_mainObjectContext performBlock:^{
                    handler(error);
                }];
            }
        }];
    }
    return error;
}


@end
