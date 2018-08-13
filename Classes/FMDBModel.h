//
//  FMDBModel.h
//  HuiLianYiPlatform
//
//  Created by Liyanjun on 2018/3/7.
//  Copyright © 2018年 HAND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+TSStorageManager.h"

// MARK:  只要继承这个类，数据库字段就会创建fmdbmodelId和userOID，并且fmdbmodelId作为主键
@interface FMDBModel : NSObject
// MARK:  只要继承这个类，数据库字段就会创建fmdbmodelId和userOID，并且fmdbmodelId作为主键
@property (nonatomic, copy) NSString* fmdbmodelId;//这个用来作为字表的外键
// MARK:  只要继承这个类，数据库字段就会创建fmdbmodelId和userOID，并且fmdbmodelId作为主键
@property (nonatomic, copy) NSString* userOID;//用户的id用于做外键

// MARK:  用这个设置userId 会自动设置fmdbmodelId
-  (void)fmdb_setUserOID:(NSString *)userOID;
    

@end
