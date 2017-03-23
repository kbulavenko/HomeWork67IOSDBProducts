//
//  MyTableViewDataSource.h
//  IOSBD
//
//  Created by  Z on 22.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MyDataController.h"
#import "MyManagedObjectProductMO.h"
#import "MyTableViewDataSource.h"




@interface MyTableViewDataSource : NSObject<UITableViewDataSource>

@property  MyDataController    *MDCDS ;
@property  NSMutableArray<NSDictionary *> *MyData;

-(void)reloadDB;



@end


