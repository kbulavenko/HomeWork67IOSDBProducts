//
//  MyDataController.m
//  IOSBD
//
//  Created by Z on 22.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

//
//  MyDataController.m
//  MhzCoreData
//
//  Created by MHz on 06.06.16.
//  Copyright © 2016 MHz. All rights reserved.
//

/*
 * NSManagedObjectModel
 * --------------------
 * 		object describes a schema—a collection of entities (data models)
 *		that you use in your application.
 *
 *		The model contains one or more NSEntityDescription objects representing the entities in the schema.
 *		Each NSEntityDescription object has property description objects (instances of subclasses of
 *		NSPropertyDescription) that represent the properties (or fields) of the entity in the schema.
 *
 *		Managed object model files are typically stored in a project or a framework.
 *
 * NSPersistentStoreCoordinator
 * ----------------------------
 *		Instances of NSPersistentStoreCoordinator associate persistent stores (by type) with a model
 *		and serve to mediate between the persistent store and the managed object context. Instances of
 *		NSManagedObjectContext use a coordinator to save object graphs to persistent storage and
 *		to retrieve model information.
 * ------------------------------------------------------------------------
 */

#import "MyDataController.h"

@implementation MyDataController


- (id)init
{
    self = [super init];
    if (!self) return nil;
    
    [self initializeCoreData];
    
    return self;
}

- (void)initializeCoreData
{
    
    
   // NSString                *pathDoc  = [NSString stringWithFormat:@"%@/Documents/IOSBD.momd", NSHomeDirectory()];
    NSURL					*modelURL	= [[NSBundle mainBundle] URLForResource : @"IOSBD" withExtension : @"momd"];
   // modelURL   =  [ NSURL  URLWithString:  pathDoc];
    NSLog(@"modelURL  = %@", modelURL );
   // modelURL
    NSManagedObjectModel	*mom		= [[NSManagedObjectModel alloc] initWithContentsOfURL : modelURL];
    NSAssert(mom != nil,  @"Error initializing Managed Object Model");
    
    NSPersistentStoreCoordinator	*psc	= [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel : mom];
    NSManagedObjectContext			*moc	= [[NSManagedObjectContext alloc] initWithConcurrencyType : NSMainQueueConcurrencyType];
    [moc setPersistentStoreCoordinator : psc];
    
    [self setManagedObjectContext : moc];
    
    NSFileManager			*fileManager	= [NSFileManager defaultManager];
    NSURL					*documentsURL	= [[fileManager URLsForDirectory : NSDocumentDirectory inDomains : NSUserDomainMask] lastObject];
    NSURL					*storeURL		= [documentsURL URLByAppendingPathComponent : @"DataModel.sqlite"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^(void)
                   {
                       NSLog(@"Hello World!");
                       NSError							*error	= nil;
                       NSPersistentStoreCoordinator	*psc	= [[self managedObjectContext] persistentStoreCoordinator];
                       NSPersistentStore				*store	=
                       [psc addPersistentStoreWithType : NSSQLiteStoreType configuration : nil
                                                   URL : storeURL options : /*options*/nil error : &error];
                       NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
                   });
}



@end
