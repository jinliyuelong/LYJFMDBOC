//
//  NSObject+TSStorageManager.h
//  FrehsLink
//
//  Created by Liyanjun on 2017/10/23.
//  Copyright © 2017年 liyanjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnnotationType.h"

@interface NSObject (TSStorageManager)

@property (nonatomic,strong) PrimaryKey * fmdbid;//如果有主键，则创建主键，没有主键，则以这个为主键

//返回主键名称，默认是fmdbid
+(NSString*)primaryKeyName;


//获取替换的类型
+ (NSDictionary *)fmdb_replaceType;


//获取忽略更新的字段 比如更新时 ，某一个字段不要更新
+ (NSArray *)fmdb_ignoreupdate;

/**
 *  创建表
 *
 *
 */
-(void)creatTable;
// MARK: 创建索引 目前注释掉了 因为本地数据不多，差别不大
-(BOOL)createIndex:(NSArray *)columns;

-(BOOL)insert;

- (BOOL)dropTable;
-(NSArray *)queryWithWhereStr:(NSString *)whereStr
                      orderBy:(NSString *)orderBy;

-(NSArray *)queryother:(NSString* )other WhereStr:(NSString *)whereStr
               orderBy:(NSString *)orderBy otherquery:(NSString *)otherquery;

-(NSArray *)query:(NSArray *)columns
         strWhere:(NSString *)strWhere
       strOrderby:(NSString *)strOrderby;

-(BOOL)deleteWithWhereStr:(NSString *)whereStr;

-(BOOL)updateWithWhereStr:(NSString *)whereStr;
/**
 *  判断表是否存在
 *
 */
-(BOOL)isTableExists;

/**
 *  判断数据是否存在，通过主键去查
 *
 */
-(BOOL)isDataExists;


/**
 *  判断表是否存在,不存在则自动创建
 *
 */
-(BOOL)checkTableExists;



/**
 执行多个sql
 
 
 @param sqls 数组
 @return 返回是否成功
 */
-(BOOL) executeArraySqls:(NSArray*)sqls;

/**
 执行多个sql
 
 类方法
 @param sqls 数组
 @return 返回是否成功
 */
+(BOOL) classexecuteArraySqls:(NSArray*)sqls;

// MARK:  获取即将要生成的数据的fmdbid,用于插入字表做外键用
- (NSInteger)getNewFmdbid;

// MARK:  返回插入语句的sqls
- (void)buildInsertSql:(NSObject* )obj sqls:(NSMutableArray*)sqls;

// MARK:  返回修改语句的sqls
- (void)buildUpdateSql:(NSObject* )obj  sqls:(NSMutableArray*)sqls;

// MARK:  返回修改语句的sqls
- (void)buildUpdateSql:(NSObject* )obj  withWhere:(NSString*)where sqls:(NSMutableArray*)sqls;


// MARK:  如果有数据返回插入表的sql，如果没有返回修改表的sql
- (void)buildSaveOrUpdateSql:(NSObject* )obj  sqls:(NSMutableArray*)sqls;

// MARK:  返回清空表语句的sqls
- (void)buildDeleteSql:(NSObject* )obj where:(NSString*)where sqls:(NSMutableArray*)sqls;

// MARK:  返回创建索引语句的sqls
- (void)buildcreateIndexSql:(NSObject* )obj  columns:(NSArray*)columns sqls:(NSMutableArray*)sqls;


// MARK:  返回修改表语句的sqls
- (void)buildAlterTable:(NSObject* )obj  column:(NSString*)column sqls:(NSMutableArray*)sqls;



@end

