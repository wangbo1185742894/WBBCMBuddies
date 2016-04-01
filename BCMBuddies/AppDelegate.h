//
//  AppDelegate.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic,strong) NSString *m_appId;
@property (nonatomic,strong) NSString *m_deptId;
@property (nonatomic,strong) NSString *m_urlPath;
@property (nonatomic,strong) NSString *m_isTFI;

@property (nonatomic,assign) BOOL m_isFull;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (BOOL)isTIFServerInfo;
- (void)initDeptIdPath:(NSString *)deptIdString;
- (void)initURLPath:(NSString *)TFI;
- (void)showMainViewController;
- (void)showFirstViewController;

@end

