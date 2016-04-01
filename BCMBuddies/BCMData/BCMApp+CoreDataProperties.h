//
//  BCMApp+CoreDataProperties.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/19.
//  Copyright © 2016年 鲁智星. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BCMApp.h"

NS_ASSUME_NONNULL_BEGIN

@interface BCMApp (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *logo;
@property (nullable, nonatomic, retain) NSString *deptName;
@property (nullable, nonatomic, retain) NSString *deptId;
@property (nullable, nonatomic, retain) NSString *deptLon;
@property (nullable, nonatomic, retain) NSString *deptLat;
@property (nullable, nonatomic, retain) NSString *deptPhone;
@property (nullable, nonatomic, retain) NSString *deptLogo;
@property (nullable, nonatomic, retain) NSString *isarea;
@property (nullable, nonatomic, retain) NSString *logohosturl;
@property (nullable, nonatomic, retain) NSString *forcepush;
@property (nullable, nonatomic, retain) NSString *visiblelevel;
@property (nullable, nonatomic, retain) NSString *timestamp;
@property (nullable, nonatomic, retain) NSString *storeId;
@property (nullable, nonatomic, retain) BCMStore *app_store;
@property (nullable, nonatomic, retain) NSSet<BCMFolder *> *app_folder;

@end

@interface BCMApp (CoreDataGeneratedAccessors)

- (void)addApp_folderObject:(BCMFolder *)value;
- (void)removeApp_folderObject:(BCMFolder *)value;
- (void)addApp_folder:(NSSet<BCMFolder *> *)values;
- (void)removeApp_folder:(NSSet<BCMFolder *> *)values;

@end

NS_ASSUME_NONNULL_END
