//
//  ViewController.h
//  SyncMultipleAsyncTasks
//
//  Created by Aya Irshaid on 7/9/19.
//  Copyright © 2019 Aya Irshaid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    NSMutableArray* booksTableData;
    NSMutableArray* appsTableData;
    dispatch_group_t serviceGroup;
    NSString *booksURL;
    NSString *appsURL;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *dimView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

