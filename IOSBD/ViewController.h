//
//  ViewController.h
//  IOSBD
//
//  Created by  Z on 22.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MyDataController.h"
#import "MyManagedObjectProductMO.h"
#import "MyTableViewDataSource.h"


@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet MyTableViewDataSource *MTVC;


@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@property (weak, nonatomic) IBOutlet UIButton *btnEdt;

@property (weak, nonatomic) IBOutlet UIButton *btnDlt;


- (IBAction)btnClick:(id)sender;



@end

