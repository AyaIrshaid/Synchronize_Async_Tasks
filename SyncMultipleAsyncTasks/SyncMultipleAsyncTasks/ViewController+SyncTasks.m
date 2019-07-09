//
//  ViewController+SyncTasks.m
//  SyncMultipleAsyncTasks
//
//  Created by Aya Irshaid on 7/9/19.
//  Copyright © 2019 Aya Irshaid. All rights reserved.
//

#import "ViewController+SyncTasks.h"
#import "AFNetworking.h"

@implementation ViewController (SyncTasks)


- (void)getData{
    
    
    // 1- Call async tasks
    [self backgroundGet:booksURL  objectKey:@"Books" ];
    [self backgroundGet:appsURL  objectKey:@"Apps" ];
    
    
    // 4- Get notified when all tasks are completed, this is when all 'dispatch_group_leave' have been called
    dispatch_group_notify(serviceGroup, dispatch_get_main_queue(),^{
        
        //
        self.dimView.hidden = YES;
        self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimating];
        
        //
        [self showAlertWithTitle:@"Done"
                      andMessage:@"Got you data successfully!"
                inViewController:self
         withButtonFunctionality:nil];
        
        //
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
}


- (void)backgroundGet: (NSString *)url objectKey:(NSString *)objectKey
{
    
    [self postRequestWithURL:url completionHandler:^(NSURLResponse *response, id responseObject) {
        
        if (responseObject) {
            
            //
            NSDictionary *feed = [responseObject valueForKey:@"feed"];
            NSDictionary *results = [feed valueForKey:@"results"];
            //
            for(id resultObject in results){
                
                NSDictionary *result = resultObject;
                NSMutableDictionary *object = NSMutableDictionary.new;
                
                if ([objectKey  isEqualToString: @"Books"]){
                    
                    [object setObject:[result valueForKey:@"artistName"] forKey:@"title"];
                    [object setObject:[result valueForKey:@"name"] forKey:@"auther"];
                    
                    [self->booksTableData addObject:object];
                    
                }else if ([objectKey  isEqualToString: @"Apps"]){
                    
                    [object setObject:[result valueForKey:@"artistName"] forKey:@"title"];
                    [object setObject:[result valueForKey:@"name"] forKey:@"auther"];
                    
                    [self->appsTableData addObject:object];
                    
                }
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        
        
    }];
    
}


#pragma mark - URL Requests
- (void)postRequestWithURL:(NSString *)url
         completionHandler:(void (^) (NSURLResponse *response, id responseObject))completionHandler
{
    
    //
    self.dimView.hidden = NO;
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    // 2- insert the task in dispatch_group
    dispatch_group_enter(serviceGroup);
    
    //
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    [sessionManager setRequestSerializer: [AFJSONRequestSerializer serializer]];
    
    [sessionManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completionHandler(task.response, responseObject);
            
            // 3- remove the task from dispatch_group when done
            dispatch_group_leave(self->serviceGroup);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // remove the task from dispatch_group
        dispatch_group_leave(self->serviceGroup);
    }];
    
}



- (void)showAlertWithTitle:(NSString *)title
                andMessage:(NSString *)message
          inViewController:(UIViewController *)viewController
   withButtonFunctionality:(void (^)(void))buttonHandler
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* alertAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil)
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            if (buttonHandler)
                                                                buttonHandler();
                                                        }];
    [alertController addAction: alertAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}


@end
