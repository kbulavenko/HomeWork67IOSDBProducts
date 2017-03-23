//
//  ViewController.m
//  IOSBD
//
//  Created by  Z on 22.03.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize btnAdd, btnDlt, btnEdt, tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIEdgeInsets  inset  = UIEdgeInsetsMake(20, 20, 0, 0);
    
    self.tableView.contentInset   = inset;
    self.tableView.scrollIndicatorInsets  = inset;
    
    srand((unsigned int)time(NULL));
    MyDataController    *MDC      = [[MyDataController alloc] init];
    
    self.MTVC.MDCDS = MDC;
    
    
    //  Создание объекта продукт на основании EntityDescription (создали его визуально)
    //  NSEntityDescription
    for (int i = 1; i < 2; i++)
    {
        MyManagedObjectProductMO    *product   =      [NSEntityDescription   insertNewObjectForEntityForName:@"Product"   inManagedObjectContext: [MDC managedObjectContext]  ];
        // Заполнение полями
        [product setName:   [NSString stringWithFormat: @"Mars-%i", rand() %1000 + i *100]];
        [product setPrice:   @(12.5 + (double)(rand() % 100)/10.0 )];
        [product setWeight:   @(20+(rand() % 10) * 5)];
        
        // ----- Сохранение объекта "Продукт" ---------------------
        NSError			*error		= nil;
        if ([[MDC managedObjectContext] save : nil] == false)   //  save   to DB
        {
            NSLog(@"Error saving context: %@\n%@",  [error localizedDescription], [error userInfo]);
        }
        else
        {
            NSLog(@"Saved OK");
        }
    }
    for (int i = 1; i < 2; i++)
    {
        MyManagedObjectProductMO    *product   =   [NSEntityDescription insertNewObjectForEntityForName:@"Product"  inManagedObjectContext: [MDC managedObjectContext]  ];
        // Заполнение полями
        [product setName:   [NSString stringWithFormat: @"Snickers-%i",rand() %10000 + i *100 ]];
        [product setPrice:   @(12.5 + (double)(rand() % 100)/10.0 )];
        [product setWeight:   @(20+(rand() % 10) * 5)];
        
        // ----- Сохранение объекта "Продукт" ---------------------
        NSError			*error		= nil;
        if ([[MDC managedObjectContext] save : nil] == false)   //  save   to DB
        {
            NSLog(@"Error saving context: %@\n%@",   [error localizedDescription], [error userInfo]);
        }
        else
        {
            NSLog(@"Saved OK");
        }
    }
    
    for (int i = 1; i < 2; i++)
    {
        MyManagedObjectProductMO    *product   = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext: [MDC managedObjectContext] ];
        // Заполнение полями
        [product setName:   [NSString stringWithFormat: @"ChockoBoom-%i",rand() %10000 + i *100]];
        [product setPrice:   @(12.5 + (double)(rand() % 100)/10.0 )];
        [product setWeight:   @(20+(rand() % 10) * 5)];
        // ----- Сохранение объекта "Продукт" ---------------------
        NSError			*error		= nil;
        if ([[MDC managedObjectContext] save : nil] == false)   //  save   to DB
        {
            NSLog(@"Error saving context: %@\n%@",    [error localizedDescription], [error userInfo]);
        }
        else
        {
          //  NSLog(@"Saved OK");
        }
        
    }
    
    // Set Data to Data Source
    [self.MTVC reloadDB];
    
#pragma mark   Request
#pragma mark   ____
    
    
    
    // Создаем запрос
    NSFetchRequest    *request   = [NSFetchRequest fetchRequestWithEntityName: @"Product"];
    
#pragma mark   predicate begin
#pragma mark   ____
    
    
    NSError  *error1   = nil;
    
 //   NSString  *attributeName = @"name";  //  Название столбца
  //  NSString   *attributeValue = @"Mars";   // Значение для сравнения
    
  //  NSString  *attributeName1 = @"weight";  //  Название столбца
 //   int   attributeValue1 = 30;   // Значение для сравнения
 //   NSPredicate   *predicate   = [NSPredicate   predicateWithFormat: @"(name contains 'Mars' ) AND (weight = 35)"];
    // NSPredicate   *predicate   = [NSPredicate   predicateWithFormat: @"%K like '%@'", attributeName, attributeValue];
    //request.predicate  = predicate;
    
#pragma mark   predicate
#pragma mark   ____
    
    
    NSArray  *results   = [[MDC managedObjectContext] executeFetchRequest: request error: &error1 ];
    if(!results)
    {
        NSLog(@"Error fetching Products objects: %@\n%@",  [error1 localizedDescription], [error1 userInfo]);
        exit(0);
    }
    
    for (int i =0; i < results.count; i++)
    {
        MyManagedObjectProductMO   *product  =
        (MyManagedObjectProductMO *) [results objectAtIndex:i];
        
        NSString   *strID  = [[[[[product objectID] URIRepresentation]  lastPathComponent] componentsSeparatedByCharactersInSet:[[NSCharacterSet  decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
        
        NSLog(@"ID: %@ Name : %@\tPrice :  %f\tWeight : %i", strID, product.name, product.price.doubleValue, product.weight.intValue);
        //NSLog(@"%@", );
        
    }

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender
{
    if(sender == self.btnAdd)
    {
        
#pragma mark   Добавление
#pragma mark   ______________

        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Enter new product!"
                                                                       message:@"Name\nPrice\nWeight"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style: UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action)
                    {
                        
                        
                        
                        NSString   *name   = alert.textFields.firstObject.text.copy;
                        NSString   *weight = alert.textFields.lastObject.text.copy;
                        NSString   *price  = [alert.textFields objectAtIndex:1].text.copy;
                        
                        if([self isStringDecimalNumber:weight])
                        {
                            NSLog(@"weight is");
                        }
                        
                        if([self isStringDecimalNumber: price])
                        {
                            NSLog(@"price is");
                        }
                        
                        
                        if(name.length !=0 && weight.length != 0 && price.length != 0 && [self isStringDecimalNumber: price] && [self isStringDecimalNumber:weight])
                        {
                            
                          
                              NSDictionary    *d  = @{
                                                      @"name" : name.copy,
                                                      @"price" : @(price.doubleValue),
                                                      @"weight" : @(weight.intValue)
                                                      };
                              
                              [self addToDB: d];
                              
                              NSLog(@"1111111111111111111111111");
                              
                              
                              [self.MTVC reloadDB];
                              [self.tableView reloadData];
                        }
                        else
                        {
                            [self warningAlert:@"Incorrectly entered data!"];
                        }


                                                  
                  }];
       // alert.preferredStyle  = ;
        
        [alert addAction:defaultAction];
        
        //- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;
        
        UITextField    *name    = [[UITextField  alloc]   initWithFrame: CGRectMake(0, 0, 20, 150)];
        UITextField    *price   = [[UITextField  alloc]   initWithFrame: CGRectMake(160, 0, 20, 150)];
        UITextField    *weight  = [[UITextField  alloc]   initWithFrame: CGRectMake(320, 0, 20, 150)];
        
        [alert  addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField   = name;
        }];
        
        
        [alert  addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField   = price;
        }];
        
        
        
        [alert  addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField   = weight;
        }];
        
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        //   Считать Action
        
        
        // Обработать Action  return для Cancel
        
        
        //  Для Ок  Добавить в базу
        
        
       
    }
    else if(sender == self.btnDlt)
    {
       
#pragma mark   Удаление
#pragma mark   ______________

        
        if(self.MTVC.MyData.count == 0)  return;
        NSDictionary *dict  =   [self.MTVC.MyData  objectAtIndex: self.tableView.indexPathForSelectedRow.section];
        NSLog(@"Удаление %@, selecttion = %li", dict, self.tableView.indexPathForSelectedRow.section);
        int ID  =  [dict[@"id"] intValue];
        
        // Удаление записи
        
         NSFetchRequest   *request2   = [NSFetchRequest fetchRequestWithEntityName:@"Product"];
        
        NSError   *error2   = nil;
        NSArray  *results2  = [[self.MTVC.MDCDS managedObjectContext]  executeFetchRequest:request2 error:&error2];
        if(!results2)
        {
            NSLog(@"Error fetching Products objects : %@\n%@", [error2 localizedDescription], [error2 userInfo]);
            exit(0);
        }
        for (NSInteger i = 0; i<results2.count; i++)
        {
            MyManagedObjectProductMO  *product  = (MyManagedObjectProductMO *) [results2 objectAtIndex:i];
            NSString   *strID  = [[[[[product objectID] URIRepresentation]  lastPathComponent] componentsSeparatedByCharactersInSet:[[NSCharacterSet  decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
            if(strID.intValue ==  ID)
            {
                NSLog(@"Удаление");
                NSLog(@"ID: %@ Name: %@\tPrice : %f\tWeight: %i",strID, product.name, product.price.doubleValue, product.weight.intValue);
                // [ [MDC managedObjectContext]  deleteObject: [[MDC managedObjectContext] objectWithID: product.objectID    ]];
                [ [self.MTVC.MDCDS managedObjectContext]  deleteObject: product];
                NSError  *error3 = nil;
                
                if ([[self.MTVC.MDCDS managedObjectContext] save : &error3] == false)   //  save   to DB
                {
                    NSLog(@"Error saving context: %@\n%@",    [error3 localizedDescription], [error3 userInfo]);
                }
                else
                {
                    NSLog(@"Saved OK");
                }
                break;
            }
        }
        
        
        
        
        
        [self.MTVC reloadDB];
        [self.tableView reloadData];
    }
    else if(sender == self.btnEdt)
    {
        
#pragma mark   Редактирование
#pragma mark   ______________
        
        if(self.MTVC.MyData.count == 0)  return;
        NSDictionary *dict  =   [self.MTVC.MyData  objectAtIndex: self.tableView.indexPathForSelectedRow.section];
        NSLog(@"Удаление %@, selecttion = %li", dict, self.tableView.indexPathForSelectedRow.section);
        int ID  =  [dict[@"id"] intValue];
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Edit your product!"
                                                                       message:@"Name\nPrice\nWeight"
                                                                preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style: UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action)
        {
              NSString   *name   = alert.textFields.firstObject.text.copy;
              NSString   *weight = alert.textFields.lastObject.text.copy;
              NSString   *price  = [alert.textFields objectAtIndex:1].text.copy;
            
            
            
              if(name.length !=0 && weight.length != 0 && price.length != 0 && [self isStringDecimalNumber: price] && [self isStringDecimalNumber:weight])
              {
                  NSDictionary    *d  = @{
                                          @"name" : name.copy,
                                          @"price" : @(price.doubleValue),
                                          @"weight" : @(weight.intValue)
                                          };
                  [self updateToDB:  d id: ID ];
                  NSLog(@"222222222222222222222222222222");
                  [self.MTVC reloadDB];
                  [self.tableView reloadData];
              }
              else
              {
                  [self warningAlert:@"Incorrectly entered data!"];
              }
        }];
        // alert.preferredStyle  = ;
        
        [alert addAction:defaultAction];
        
        //- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;
        
        UITextField    *name   = [[UITextField  alloc]   initWithFrame: CGRectMake(0, 0, 150, 30)];
       
        name.text   =  [dict[@"name"] copy];
        UITextField    *price   = [[UITextField  alloc]   initWithFrame: CGRectMake(160, 0, 150, 30)];
        price.text   =  [NSString stringWithFormat:@"%5.2f", [dict[@"price"] doubleValue] ];
        UITextField    *weight   = [[UITextField  alloc]   initWithFrame: CGRectMake(320, 0, 150, 30)];
        weight.text   = [NSString stringWithFormat:@"%i", [dict[@"weight"] intValue] ];
        [alert  addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField   = name;
        }];
        
        
        [alert  addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField   = price;
        }];
        
        
        
        [alert  addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField   = weight;
        }];
        
        name.text   =  [dict[@"name"] copy];
        price.text   =  [NSString stringWithFormat:@"%5.2f", [dict[@"price"] doubleValue] ];
        weight.text   = [NSString stringWithFormat:@"%i", [dict[@"weight"] intValue] ];
        

        
        [self presentViewController:alert animated:YES completion:nil];

        name.text   =  [dict[@"name"] copy];
        price.text   =  [NSString stringWithFormat:@"%5.2f", [dict[@"price"] doubleValue] ];
        weight.text   = [NSString stringWithFormat:@"%i", [dict[@"weight"] intValue] ];
        
        alert.textFields.firstObject.text   = [dict[@"name"] copy];
        
//        UILabel   *lbl   = [[UILabel alloc]  initWithFrame:CGRectMake(100, -10, 150-100, 30)];
//        lbl.text = @"name";
//        lbl.backgroundColor  = [UIColor  clearColor];
//        lbl.textColor       = [UIColor  lightGrayColor];
//        
//      //  [alert.textFields.firstObject  setFrame: CGRectMake(0, 0, 150, 30)];
//        [ alert.textFields.firstObject  addSubview: lbl];
//        
//        
//        UILabel   *lblPrice   = [[UILabel alloc]  initWithFrame:CGRectMake(100, -40, 150-100, 60)];
//        lbl.text = @"price";
//        lbl.backgroundColor  = [UIColor  clearColor];
//        lbl.textColor       = [UIColor  lightGrayColor];
        
      //  [alert.textFields.firstObject  setFrame: CGRectMake(0, 0, 150, 30)];
       // [ [alert.textFields objectAtIndex:1]  addSubview: lblPrice];
        

        
        
        
        
        [alert.textFields objectAtIndex:1].text   = [NSString stringWithFormat:@"%5.2f", [dict[@"price"] doubleValue] ];
        alert.textFields.lastObject.text   = [NSString stringWithFormat:@"%i", [dict[@"weight"] intValue] ];
        
        
        
        
       
        
        
    }
}


-(void)addToDB: (NSDictionary *) d
{
    MyManagedObjectProductMO    *product   =      [NSEntityDescription   insertNewObjectForEntityForName:@"Product"   inManagedObjectContext: [self.MTVC.MDCDS managedObjectContext]  ];
    // Заполнение полями
    [product setName:   d[@"name"]];
    [product setPrice:   @([d[@"price"] doubleValue])];
    [product setWeight:   @([d[@"weight"] intValue])];
    
    // ----- Сохранение объекта "Продукт" ---------------------
    NSError			*error		= nil;
    if ([[self.MTVC.MDCDS managedObjectContext] save : &error] == false)   //  save   to DB
    {
        NSLog(@"Error saving context: %@\n%@",  [error localizedDescription], [error userInfo]);
    }
    else
    {
        NSLog(@"Saved OK");
    }

}

-(void)updateToDB: (NSDictionary *) d id: (int) ID
{
    
    
//    
//    MyManagedObjectProductMO    *productEdit   =      [NSEntityDescription   insertNewObjectForEntityForName:@"Product"   inManagedObjectContext: [self.MTVC.MDCDS managedObjectContext]  ];
//    // Заполнение полями
//    [productEdit setName:   d[@"name"]];
//    [productEdit setPrice:   @([d[@"price"] doubleValue])];
//    [productEdit setWeight:   @([d[@"weight"] intValue])];
//
//    
    
    
    NSFetchRequest   *request2   = [NSFetchRequest fetchRequestWithEntityName:@"Product"];
    
    NSError   *error2   = nil;
    NSArray  *results2  = [[self.MTVC.MDCDS managedObjectContext]  executeFetchRequest:request2 error:&error2];
    if(!results2)
    {
        NSLog(@"Error fetching Products objects : %@\n%@", [error2 localizedDescription], [error2 userInfo]);
        exit(0);
    }

    
    for (NSInteger i = 0; i<results2.count; i++)
    {
        MyManagedObjectProductMO  *product  = (MyManagedObjectProductMO *) [results2 objectAtIndex:i];
        NSString   *strID  = [[[[[product objectID] URIRepresentation]  lastPathComponent] componentsSeparatedByCharactersInSet:[[NSCharacterSet  decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
        if(strID.intValue ==  ID)
        {
            NSLog(@"Замена");
            NSLog(@"ID: %@ Name: %@\tPrice : %f\tWeight: %i",strID, product.name, product.price.doubleValue, product.weight.intValue);
          //  NSLog(@"на :");
            
            
         //   NSLog(@"ID: %@ Name: %@\tPrice : %f\tWeight: %i",strID, productEdit.name, productEdit.price.doubleValue, productEdit.weight.intValue);
            // [ [MDC managedObjectContext]  deleteObject: [[MDC managedObjectContext] objectWithID: product.objectID    ]];
            
            [product setName:   d[@"name"]];
            [product setPrice:   @([d[@"price"] doubleValue])];
             [product setWeight:   @([d[@"weight"] intValue])];
            

            
            
           // [ [self.MTVC.MDCDS  managedObjectContext] refreshObject:  [[self.MTVC.MDCDS  managedObjectContext] objectWithID: productEdit.objectID    ] mergeChanges: NO];
            
            
           // [ [self.MTVC.MDCDS managedObjectContext]  deleteObject: product];
            NSError  *error3 = nil;
            
            if ([[self.MTVC.MDCDS managedObjectContext] save : &error3] == false)   //  save   to DB
            {
                NSLog(@"Error saving context: %@\n%@",    [error3 localizedDescription], [error3 userInfo]);
            }
            else
            {
                NSLog(@"Saved OK");
            }
            break;
        }
    }

    
    
    
    
    
    
}

-(void)warningAlert: (NSString *)  message
{
    if(message == nil) return;
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                   message: message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style: UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    

}


-(bool) isStringDecimalNumber :(NSString *) stringValue
{
    BOOL result = false;
    
    NSString *decimalRegex = @"^(?:|-)(?:|0|[1-9]\\d*)(?:\\.\\d*)?$";
    NSPredicate *regexPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    
    if ([regexPredicate evaluateWithObject: stringValue]){
        //Matches
        result = true;
    }
    
    return result;
}


@end
