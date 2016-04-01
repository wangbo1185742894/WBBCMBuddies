//
//  BCMContentRes+CoreDataProperties.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/19.
//  Copyright © 2016年 鲁智星. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BCMContentRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface BCMContentRes (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *size;
@property (nullable, nonatomic, retain) NSString *filehosturl;
@property (nullable, nonatomic, retain) NSString *lastmodify;
@property (nullable, nonatomic, retain) NSString *contentId;
@property (nullable, nonatomic, retain) NSString *file;
@property (nullable, nonatomic, retain) NSString *usage;
@property (nullable, nonatomic, retain) NSString *contentResUrl;
@property (nullable, nonatomic, retain) NSString *contentResPath;

@end

NS_ASSUME_NONNULL_END
