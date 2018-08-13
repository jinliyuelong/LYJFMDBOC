//
//  FMDBModel.m
//  HuiLianYiPlatform
//
//  Created by Liyanjun on 2018/3/7.
//  Copyright © 2018年 HAND. All rights reserved.
//

#import "FMDBModel.h"

@implementation FMDBModel


//获得主键的名称
+(NSString*)primaryKeyName{
    return @"fmdbmodelId";
}



-  (void)fmdb_setUserOID:(NSString *)userOID{
    _userOID = userOID;
    
    self.fmdbmodelId = [NSString stringWithFormat:@"%f",[ [NSDate date] timeIntervalSince1970]];
}


@end
