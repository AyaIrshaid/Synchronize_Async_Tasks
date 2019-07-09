//
//  ViewController.m
//  SyncMultipleAsyncTasks
//
//  Created by Aya Irshaid on 7/9/19.
//  Copyright © 2019 Aya Irshaid. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+SyncTasks.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //
    serviceGroup = dispatch_group_create();
    booksTableData = NSMutableArray.new;
    appsTableData = NSMutableArray.new;
    
    //
    _dimView.hidden = YES;
    _activityIndicator.hidden = YES;
    
    //
    booksURL = @"https://rss.itunes.apple.com/api/v1/jo/books/top-free/all/25/explicit.json";
    appsURL = @"https://rss.itunes.apple.com/api/v1/jo/ios-apps/top-free/all/25/explicit.json";
    

}


#pragma mark - Table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return [booksTableData count];
    }
    
    if (section == 1){
        return [appsTableData count];
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0){
        return @"Books";
    }
    
    if (section == 1){
        return @"Apps";
    }
    
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0){
        [cell.textLabel setText:[booksTableData[indexPath.row] valueForKey: @"title"]];
        [cell.detailTextLabel setText:[booksTableData[indexPath.row] valueForKey: @"auther"]];
    }
    if (indexPath.section == 1){
        [cell.textLabel setText:[appsTableData[indexPath.row] valueForKey: @"title"]];
        [cell.detailTextLabel setText:[appsTableData[indexPath.row] valueForKey: @"auther"]];
    }
    
    return cell;
    //
}


#pragma mark - IBActions
- (IBAction)getDataButtonTapped:(id)sender {
    
    //
    [self getData];
    
}

@end
