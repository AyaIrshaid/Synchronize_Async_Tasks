# Synchronize Async Tasks

Get notified when a list of Async tasks are done using 'dispatch_group'.

Notes:

- In 'ViewController+SyncTasks.m' check the following: 
 
- 1_ Call async tasks: These are API calls to get some data.
- 2_ Insert each task in dispatch_group: dispatch_group_enter().
- 3_ Remove the task from dispatch_group when the task is done: dispatch_group_leave().
- 4_ Get notified when all tasks are completed, this is when all 'dispatch_group_leave' have been called: 
   This is where my user gets notified that the action is done.
   
Used:
- API calls: AFNetworking
- Data display: UITableView

