//
//  TableInfo.m
//  LittleSqlite
//
//  Created by liyanjun on 15/1/6.
//  Copyright (c) 2015年 liyanjun. All rights reserved.
//

#import "TableInfo.h"
#import <objc/runtime.h>
#import "NSObject+TSStorageManager.h"
#import "FMDBModel.h"

static NSMutableDictionary * tableInfoMap;

@implementation TableInfo
{
    
    NSMutableDictionary * _propertyMap;
    
    
    NSString * _myTableName;
    
    Class _myClass;
    
    Boolean isTableExist;
    
    NSString * _primaryFieldName;
    
    NSMutableArray* _ignoreupdatearray;

    
}


-(id)initWithClass:(Class)class
{
    self = [super init];
    if(self){
        
        _myClass = class;
        _propertyMap = [[NSMutableDictionary alloc] init];
        _ignoreupdatearray = [[NSMutableArray alloc] init];
        isTableExist = NO;
        _primaryFieldName = nil;
        [self initTableInfo];
    }
    
    return  self;
    
    
}

-(void)initTableInfo
{
    
    NSString * className = [NSString stringWithUTF8String:class_getName(_myClass)];
    
    [self setTableName:className];
    
    [self buildProperty];
    

    
}

-(void)buildProperty
{
    unsigned int outCount, i;
    
    

    objc_property_t *properties = class_copyPropertyList(_myClass, &outCount);
    if ([_myClass respondsToSelector:@selector(primaryKeyName)]) {
        _primaryFieldName = [_myClass primaryKeyName];
    }
    
    NSDictionary* dic;
    if ([_myClass respondsToSelector:@selector(fmdb_replaceType)]) {
        dic = [_myClass fmdb_replaceType];
    }
    
    
    if ([_myClass respondsToSelector:@selector(fmdb_ignoreupdate)]) {
        _ignoreupdatearray = [[_myClass fmdb_ignoreupdate] copy];
    }
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString * propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString * attributeName = [[NSString alloc] initWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
        
        if (dic!=nil&&dic[propertyName]!=nil) {
             [_propertyMap setObject:dic[propertyName] forKey:propertyName];
        }else{
             [_propertyMap setObject:attributeName forKey:propertyName];
        }
       
        
    }

    //父类
   
    Class supclass = [_myClass superclass];
     NSObject* obj = [supclass new];
    if ([obj isKindOfClass:[FMDBModel class]]) {
        objc_property_t *propertiessupclass = class_copyPropertyList(supclass, &outCount);
        
        for (i = 0; i < outCount; i++) {
            objc_property_t property = propertiessupclass[i];
            NSString * propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            NSString * attributeName = [[NSString alloc] initWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
            
            
            [_propertyMap setObject:attributeName forKey:propertyName];
            
            
        }
    }
   
    

    if(_primaryFieldName == nil){
        _primaryFieldName = @"fmdbid";
        [_propertyMap setObject:@"PrimaryKey" forKey:@"fmdbid"];
        
    }
}

-(NSString *)getPrimaryFieldName
{
    return _primaryFieldName;
}

-(void)setCheckedTableExist:(Boolean)_checkedTableExist
{
    
    isTableExist =_checkedTableExist;
    
}

-(NSMutableDictionary *)getPropertyMap
{
    
    return _propertyMap;
}


-(NSMutableArray*) getignoreupdatearray{
    return _ignoreupdatearray;
}

-(Boolean)getCheckedTableExist
{
    
    return isTableExist;
}



-(NSString *)getTableName
{
    
    
    return _myTableName;
}


-(void)setTableName:(NSString *)_tableName
{
    
    _myTableName = _tableName;
}



+(instancetype) getTableInfo :(Class )class{

//    NSParameterAssert(class);
   

    NSString * className = [NSString stringWithUTF8String:class_getName(class)];
    
    
    if(tableInfoMap == nil){
        
        tableInfoMap = [[NSMutableDictionary alloc] init];
        
    }
    
    if([tableInfoMap valueForKey:className ] != nil)
    {
        return [tableInfoMap valueForKey:className];
        
    }
    
    
    TableInfo * tableinfo = [[self alloc] initWithClass:class];
    
    [tableInfoMap setValue:tableinfo forKey:className];
    
    
    return tableinfo;
    
    
}





@end
