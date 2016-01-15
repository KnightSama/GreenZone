//
//  mmDAO.h
//  agent
//
//  Created by LiMing on 14-6-24.
//  Copyright (c) 2014年 bangban. All rights reserved.
//

//数据库基层类，初始化数据库存储的必要信息
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void(^OperationResult)(NSError* error);//返回错误信息的block

@interface mmDAO : NSObject
@property (readonly, strong, nonatomic) NSOperationQueue *queue;
@property (readonly ,strong, nonatomic) NSManagedObjectContext *bgObjectContext;//子线程上下文
@property (readonly, strong, nonatomic) NSManagedObjectContext *mainObjectContext;//主线程上下文

+(mmDAO*)instance;//当前类的单粒对象

//初始化数据库名字
-(void) setupEnvModel:(NSString *)model DbFile:(NSString*)filename;
//创建私有上下文
- (NSManagedObjectContext *)createPrivateObjectContext;
//保存数据，将错误通过block返回
-(NSError*)save:(OperationResult)handler;

@end
