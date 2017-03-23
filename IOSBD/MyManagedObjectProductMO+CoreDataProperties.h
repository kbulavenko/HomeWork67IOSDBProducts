//
//  MyManagedObjectProductMO+CoreDataProperties.h
//  IOSBD
//
//  Created by Z on 22.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MyManagedObjectProductMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyManagedObjectProductMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSNumber *weight;

@end

NS_ASSUME_NONNULL_END
