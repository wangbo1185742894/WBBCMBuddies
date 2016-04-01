//
//  AppDelegate.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "AppDelegate.h"
#import "BCMFirstViewController.h"
#import "BCMRootViewController.h"
#import "BCMNavigationController.h"
#include <SystemConfiguration/CaptiveNetwork.h>
#import "BCMDefineFile.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <sys/sysctl.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import "route.h"      /*the very same from google-code*/

#define CTL_NET         4               /* network, see socket.h */

#define ROUNDUP(a) \
((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))

@interface AppDelegate ()

@end

@implementation AppDelegate
- (NSString *)getGatewayIPAddress {
    
    NSString *address = nil;
    
    /* net.route.0.inet.flags.gateway */
    int mib[] = {CTL_NET, PF_ROUTE, 0, AF_INET,
        NET_RT_FLAGS, RTF_GATEWAY};
    size_t l;
    char * buf, * p;
    struct rt_msghdr_c * rt;
    struct sockaddr * sa;
    struct sockaddr * sa_tab[RTAX_MAX];
    int i;
    int r = -1;
    
    if(sysctl(mib, sizeof(mib)/sizeof(int), 0, &l, 0, 0) < 0) {
        address = @"192.168.0.1";
    }
    
    if(l>0) {
        buf = malloc(l);
        if(sysctl(mib, sizeof(mib)/sizeof(int), buf, &l, 0, 0) < 0) {
            address = @"192.168.0.1";
        }
        
        for(p=buf; p<buf+l; p+=rt->rtm_msglen) {
            rt = (struct rt_msghdr *)p;
            sa = (struct sockaddr *)(rt + 1);
            for(i=0; i<RTAX_MAX; i++)
            {
                if(rt->rtm_addrs & (1 << i)) {
                    sa_tab[i] = sa;
                    sa = (struct sockaddr *)((char *)sa + ROUNDUP(sa->sa_len));
                } else {
                    sa_tab[i] = NULL;
                }
            }
            
            if( ((rt->rtm_addrs & (RTA_DST|RTA_GATEWAY)) == (RTA_DST|RTA_GATEWAY))
               && sa_tab[RTAX_DST]->sa_family == AF_INET
               && sa_tab[RTAX_GATEWAY]->sa_family == AF_INET) {
                unsigned char octet[4]  = {0,0,0,0};
                int i;
                for (i=0; i<4; i++){
                    octet[i] = ( ((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr >> (i*8) ) & 0xFF;
                }
                if(((struct sockaddr_in *)sa_tab[RTAX_DST])->sin_addr.s_addr == 0) {
                    in_addr_t addr = ((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr;
                    r = 0;
                    address = [NSString stringWithFormat:@"%s", inet_ntoa(*((struct in_addr*)&addr))];
                    NSLog(@"\naddress%@",address);
                    break;
                }
            }
        }
        free(buf);
    }
    return address;
}
- (void)initURLPath:(NSString *)TFI
{
    if([TFI isEqualToString:@"YES"])
    {
        NSString *wd_ipString = [self getGatewayIPAddress];
        self.m_urlPath = [NSString stringWithFormat:@"http://%@%@/",wd_ipString,@":12202"];
    }
    else
    {
        self.m_urlPath = @"http://tfi.11max.com/";
    }
    self.m_isTFI = TFI;
    self.m_appId = @"8388609";
}
- (void)initDeptIdPath:(NSString *)deptIdString
{
    self.m_deptId = deptIdString;
    NSUserDefaults *wd_userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *wd_dic = [[NSMutableDictionary alloc] init];
    [wd_dic setObject:self.m_urlPath forKey:@"LastURLPath"];
    [wd_dic setObject:self.m_appId forKey:@"LastAPPID"];
    [wd_dic setObject:self.m_deptId forKey:@"LastDeptId"];
    [wd_dic setObject:self.m_isTFI forKey:@"LastISTFI"];
    [wd_userDefaults setObject:wd_dic forKey:@"lastInfo"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    NSUserDefaults *wd_userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *wd_dic = [wd_userDefaults objectForKey:@"lastInfo"];
    if(wd_dic)
    {
        self.m_urlPath = [wd_dic objectForKey:@"LastURLPath"];
        self.m_appId = [wd_dic objectForKey:@"LastAPPID"];
        self.m_deptId = [wd_dic objectForKey:@"LastDeptId"];
        self.m_isTFI = [wd_dic objectForKey:@"LastISTFI"];
        [self showMainViewController];
    }
    else
    {
        if([self isTIFServerInfo])
        {
            [self initURLPath:@"YES"];
        }
        else
        {
            [self initURLPath:@"NO"];
        }
        [self showFirstViewController];
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
{
    if(self.m_isFull)
    {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.gstarcad.xian.mcpro.BCMBuddies" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BCMBuddies" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BCMBuddies.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (id)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info;
}

- (BOOL)isTIFServerInfo
{
    NSDictionary *wd_dic = [self fetchSSIDInfo];
    if(wd_dic)
    {
        return [BCMToolLib NativeCheckTSSID:[wd_dic objectForKey:@"SSID"] MacID:[wd_dic objectForKey:@"BSSID"]];
    }
    return NO;
}

- (void)showMainViewController
{
    BCMRootViewController *wd_rootViewController = [[BCMRootViewController alloc] initWithNibName:@"BCMRootViewController" bundle:nil];
    BCMNavigationController *wd_navigationController = [[BCMNavigationController alloc] initWithRootViewController:wd_rootViewController];
    [wd_navigationController setNavigationBarHidden:YES animated:NO];
    [wd_navigationController setToolbarHidden:YES animated:NO];
    self.window.rootViewController = wd_navigationController;
}

- (void)showFirstViewController
{
    BCMFirstViewController *wd_firstViewController = [[BCMFirstViewController alloc] initWithNibName:@"BCMFirstViewController" bundle:nil];
    BCMNavigationController *wd_navigationController = [[BCMNavigationController alloc] initWithRootViewController:wd_firstViewController];
    [wd_navigationController setNavigationBarHidden:YES animated:NO];
    [wd_navigationController setToolbarHidden:YES animated:NO];
    self.window.rootViewController = wd_navigationController;
}

@end
