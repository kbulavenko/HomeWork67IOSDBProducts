//
//  MyDataController.h
//  IOSBD
//
//  Created by Z on 22.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
//#import <Cocoa/Cocoa.h>
//#import <>

@interface MyDataController : NSObject


@property  (strong)   NSManagedObjectContext *managedObjectContext;

-(void)initializeCoreData;



@end
