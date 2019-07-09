//
//  ViewController+SyncTasks.h
//  SyncMultipleAsyncTasks
//
//  Created by Aya Irshaid on 7/9/19.
//  Copyright © 2019 Aya Irshaid. All rights reserved.
//

#import "ViewController.h"


@interface ViewController (SyncTasks)

- (void)getData;
- (void)postRequestWithURL:(NSString *)url
         completionHandler:(void (^) (NSURLResponse *response, id responseObject))completionHandler;

@end

