//
//  BCMStore+CoreDataProperties.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/19.
//  Copyright © 2016年 鲁智星. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BCMStore.h"

NS_ASSUME_NONNULL_BEGIN

@interface BCMStore (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *logo;
@property (nullable, nonatomic, retain) NSString *logohosturl;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<BCMApp *> *store_app;

@end

@interface BCMStore (CoreDataGeneratedAccessors)

- (void)addStore_appObject:(BCMApp *)value;
- (void)removeStore_appObject:(BCMApp *)value;
- (void)addStore_app:(NSSet<BCMApp *> *)values;
- (void)removeStore_app:(NSSet<BCMApp *> *)values;

@end

NS_ASSUME_NONNULL_END
