//
//  BCMFolder+CoreDataProperties.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/19.
//  Copyright © 2016年 鲁智星. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BCMFolder.h"

NS_ASSUME_NONNULL_BEGIN

@interface BCMFolder (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *logo;
@property (nullable, nonatomic, retain) NSString *logohosturl;
@property (nullable, nonatomic, retain) NSString *timestamp;
@property (nullable, nonatomic, retain) NSString *visiblelevel;
@property (nullable, nonatomic, retain) NSString *forcepush;
@property (nullable, nonatomic, retain) NSString *foldertypename;
@property (nullable, nonatomic, retain) NSString *defaultopen;
@property (nullable, nonatomic, retain) NSString *folderlevel;
@property (nullable, nonatomic, retain) NSString *parentid;
@property (nullable, nonatomic, retain) NSString *remark;
@property (nullable, nonatomic, retain) NSString *extinfo;
@property (nullable, nonatomic, retain) NSString *deptId;
@property (nullable, nonatomic, retain) NSString *localcontent;
@property (nullable, nonatomic, retain) NSString *releasemethodfilter;
@property (nullable, nonatomic, retain) NSString *storeId;
@property (nullable, nonatomic, retain) NSString *appId;
@property (nullable, nonatomic, retain) BCMApp *folder_app;
@property (nullable, nonatomic, retain) NSSet<BCMContent *> *folder_content;

@end

@interface BCMFolder (CoreDataGeneratedAccessors)

- (void)addFolder_contentObject:(BCMContent *)value;
- (void)removeFolder_contentObject:(BCMContent *)value;
- (void)addFolder_content:(NSSet<BCMContent *> *)values;
- (void)removeFolder_content:(NSSet<BCMContent *> *)values;

@end

NS_ASSUME_NONNULL_END
