//
//  BCMContent+CoreDataProperties.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/19.
//  Copyright © 2016年 鲁智星. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BCMContent.h"

NS_ASSUME_NONNULL_BEGIN

@interface BCMContent (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *language;
@property (nullable, nonatomic, retain) NSString *tag;
@property (nullable, nonatomic, retain) NSString *area;
@property (nullable, nonatomic, retain) NSString *style;
@property (nullable, nonatomic, retain) NSString *isAdd;

@property (nullable, nonatomic, retain) NSString *appname;
@property (nullable, nonatomic, retain) NSString *downloadurl;
@property (nullable, nonatomic, retain) NSString *hasads;
@property (nullable, nonatomic, retain) NSString *systemrequire;
@property (nullable, nonatomic, retain) NSString *description1;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *logo;
@property (nullable, nonatomic, retain) NSString *logohosturl;
@property (nullable, nonatomic, retain) NSString *usecount;
@property (nullable, nonatomic, retain) NSString *validdatebegin;
@property (nullable, nonatomic, retain) NSString *validdateend;
@property (nullable, nonatomic, retain) NSString *visiblelevel;
@property (nullable, nonatomic, retain) NSString *remark;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *file;
@property (nullable, nonatomic, retain) NSString *filehosturl;
@property (nullable, nonatomic, retain) NSString *downloadsetting;
@property (nullable, nonatomic, retain) NSString *size;
@property (nullable, nonatomic, retain) NSString *releasemethodfilter;
@property (nullable, nonatomic, retain) NSString *timestamp;
@property (nullable, nonatomic, retain) NSString *defaultopenlink;
@property (nullable, nonatomic, retain) NSString *resfiles;
@property (nullable, nonatomic, retain) NSString *catalog;
@property (nullable, nonatomic, retain) NSString *iszip;
@property (nullable, nonatomic, retain) NSString *storeId;
@property (nullable, nonatomic, retain) NSString *appId;
@property (nullable, nonatomic, retain) NSString *folderId;
@property (nullable, nonatomic, retain) NSString *fileLocalPath;
@property (nullable, nonatomic, retain) NSString *wd_operator;
@property (nullable, nonatomic, retain) NSString *fundPurevalue;
@property (nullable, nonatomic, retain) NSString *fundPurelabel;
@property (nullable, nonatomic, retain) NSString *fundRosevalue;
@property (nullable, nonatomic, retain) NSString *fundRoselabel;
@property (nullable, nonatomic, retain) NSString *fundTag;
@property (nullable, nonatomic, retain) NSString *servername;
@property (nullable, nonatomic, retain) NSString *goldPrice;
@property (nullable, nonatomic, retain) NSString *finProductcode;
@property (nullable, nonatomic, retain) NSString *finProductstatus;
@property (nullable, nonatomic, retain) NSString *finExprevenuevalue;
@property (nullable, nonatomic, retain) NSString *finExprevenuelabel;
@property (nullable, nonatomic, retain) NSString *finExprevenuerange;
@property (nullable, nonatomic, retain) NSString *finTermvalue;
@property (nullable, nonatomic, retain) NSString *finTermlabel;
@property (nullable, nonatomic, retain) NSString *servName;
@property (nullable, nonatomic, retain) NSString *servPosition;
@property (nullable, nonatomic, retain) NSString *servPhone;
@property (nullable, nonatomic, retain) NSString *servRespbusiness;
@property (nullable, nonatomic, retain) NSString *servWorkyears;
@property (nullable, nonatomic, retain) NSString *servIntroduce;
@property (nullable, nonatomic, retain) NSString *servOnduty;
@property (nullable, nonatomic, retain) NSString *servLevel;
@property (nullable, nonatomic, retain) NSString *score;
@property (nullable, nonatomic, retain) NSString *packagename;
@property (nullable, nonatomic, retain) NSString *versioncode;
@property (nullable, nonatomic, retain) NSString *versionname;
@property (nullable, nonatomic, retain) NSString *app_version;
@property (nullable, nonatomic, retain) NSString *resource_id;
@property (nullable, nonatomic, retain) NSString *app_name;
@property (nullable, nonatomic, retain) NSString *page_name;
@property (nullable, nonatomic, retain) NSString *caid;
@property (nullable, nonatomic, retain) NSString *album;
@property (nullable, nonatomic, retain) NSString *artist;
@property (nullable, nonatomic, retain) NSString *director;
@property (nullable, nonatomic, retain) NSString *length;
@property (nullable, nonatomic, retain) NSString *productarea;
@property (nullable, nonatomic, retain) NSString *year;
@property (nullable, nonatomic, retain) NSString *author;
@property (nullable, nonatomic, retain) NSString *aboutauthor;
@property (nullable, nonatomic, retain) NSString *imgeType;
@property (nullable, nonatomic, retain) BCMFolder *content_folder;

@end

NS_ASSUME_NONNULL_END
