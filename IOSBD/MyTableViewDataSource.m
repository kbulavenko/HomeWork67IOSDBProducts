//
//  MyTableViewDataSource.m
//  IOSBD
//
//  Created by  Z on 22.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "MyTableViewDataSource.h"

@implementation MyTableViewDataSource
@synthesize MDCDS;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"numberOfRowsInSection");
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  NSLog(@"cellForRowAtIndexPath");
 // //  UITableViewCell   *cell = [[UITableViewCell   alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: [NSString stringWithFormat: @"Id1", rand() % 10000]];
   // [cell TextLabel:  [[UILabel alloc ]  init]];
  //  UITextField  *tf = [[UITextField  alloc] init];
   // [tf insertText:@"safsad"];
   // tf.text   = @"11111";
    //[cell addSubview: tf];
    
    NSInteger   section  = indexPath.section;
    NSDictionary  *dict  = [self.MyData objectAtIndex: section];
    NSInteger   rowNum  = indexPath.row ;
    UITableViewCell *cell  = nil;
  //  NSLog(@"dict  = %@",dict);
    switch (rowNum)
    {
        case 0:
        {
//            cell = [tableView  dequeueReusableCellWithIdentifier: @"name"];
//            if(!cell)
//            {
                cell = [[UITableViewCell   alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: [NSString stringWithFormat: @"name"]];
               // NSLog(@"Cell created");
//                
//            }
//            else
//            {
//                NSLog(@"Cell reused");
//            }
            cell.textLabel.text = [dict[@"name"] copy];
            
            
            break;
        }
        case 1:
        {
//            cell = [tableView  dequeueReusableCellWithIdentifier: @"price"];
//            if(!cell)
//            {
                cell = [[UITableViewCell   alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: [NSString stringWithFormat: @"price"]];
             //   NSLog(@"Cell created");
                
//            }
//            else
//            {
//                NSLog(@"Cell reused");
//            }
            cell.textLabel.text = [NSString  stringWithFormat: @"Price : %@", dict[@"price"]  ];
            
            
            break;
        }
        case 2:
        {
//            cell = [tableView  dequeueReusableCellWithIdentifier: @"weight"];
//            if(!cell)
//            {
                cell = [[UITableViewCell   alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: [NSString stringWithFormat: @"weight"]];
              //  NSLog(@"Cell created");
                
//            }
//            else
//            {
//                NSLog(@"Cell reused");
//            }
            cell.textLabel.text = cell.textLabel.text = [NSString  stringWithFormat: @"Weight : %@", dict[@"weight"]  ];
            
            
            break;
        }
            
        default:
            break;
    }
    
//    NSLog(@"indexPath = %@", indexPath);
//    
//    UITableViewCell *cell  = [tableView  dequeueReusableCellWithIdentifier: @"name"];
//    
//       if(!cell)
//    {
//        cell = [[UITableViewCell   alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: [NSString stringWithFormat: @"Id1", rand() % 10000]];
//        NSLog(@"Cell created");
//
//    }
//    else
//    {
//        NSLog(@"Cell reused");
//    }
//    cell.textLabel.text = [NSString   stringWithFormat:@"Section : %li Row = %li", indexPath.section, indexPath.row];
//    
    
//    CGFloat   redT = 0.1 ; //  + 0.1 *  ((double)(section % 5 ))  ;
//    CGFloat   greenT = 0.3  ;
//    CGFloat   blueT = 0.4  ;
//    CGFloat   alphaT = 0.9 ;
//    
    
    cell.selectionStyle     =  UITableViewCellSelectionStyleBlue ;//   = [UIColor  colorWithRed:redT green:greenT blue:blueT alpha:alphaT];
    
    
    CGFloat   red = 0.1   ;
    CGFloat   green = 0.5  + 0.1 *  ((double)(section % 7 )) ;
    CGFloat   blue = 0.1 + 0.1 *  ((double)(section % 6 ));
    CGFloat   alpha = 0.5 ;
    
    
    cell.backgroundColor =  [UIColor  colorWithRed:red green:green blue:blue alpha:alpha];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.MyData.count  ;
}


-(void)reloadDB
{
    // Создаем запрос
    NSFetchRequest    *request   = [NSFetchRequest fetchRequestWithEntityName: @"Product"];
    
#pragma mark   predicate begin
#pragma mark   ____
    
    
    NSError  *error1   = nil;
    
    NSString  *attributeName = @"name";  //  Название столбца
    NSString   *attributeValue = @"Mars";   // Значение для сравнения
    
    NSString  *attributeName1 = @"weight";  //  Название столбца
    int   attributeValue1 = 30;   // Значение для сравнения
    NSPredicate   *predicate   = [NSPredicate   predicateWithFormat: @"(name contains 'Mars' ) AND (weight = 35)"];
    // NSPredicate   *predicate   = [NSPredicate   predicateWithFormat: @"%K like '%@'", attributeName, attributeValue];
    //request.predicate  = predicate;
    
#pragma mark   predicate
#pragma mark   ____
    
    
    NSArray  *results   = [[self.MDCDS managedObjectContext] executeFetchRequest: request error: &error1 ];
    if(!results)
    {
        NSLog(@"Error fetching Products objects: %@\n%@",  [error1 localizedDescription], [error1 userInfo]);
        exit(0);
    }
    self.MyData = [NSMutableArray<NSDictionary*> array];
    
    for (int i =0; i < results.count; i++)
    {
        MyManagedObjectProductMO   *product  =
        (MyManagedObjectProductMO *) [results objectAtIndex:i];
        
        NSString   *strID  = [[[[[product objectID] URIRepresentation]  lastPathComponent] componentsSeparatedByCharactersInSet:[[NSCharacterSet  decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
        
      //  NSLog(@"Reading to DS : ID: %@ Name : %@\tPrice :  %f\tWeight : %i", strID, product.name, product.price.doubleValue, product.weight.intValue);
        NSDictionary   *dict1   = @{
                                   @"id"   :   strID,
                                   @"name"   :   product.name,
                                   @"weight"   :   @(product.weight.intValue),
                                   @"price"   :   @(product.price.doubleValue)
                                   };
        
        [self.MyData  addObject: dict1];
        
        
    }
   // NSLog(@"%@",self.MyData);
    

}


@end
