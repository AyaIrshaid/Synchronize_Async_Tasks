# Synchronise_Async_Tasks

Get notified when a list of Async tasks are done using 'dispatch_group'.

Notes:

- In 'ViewController+SyncTasks.m' check the following: 
 
1 - Call async tasks: These are API calls to get some data.
2 - Insert the task in dispatch_group: dispatch_group_enter().
3 - Remove the task from dispatch_group when done: dispatch_group_leave().
4 - Get notified when all tasks are completed, this is when all 'dispatch_group_leave' have been called: 
   This is where my user gets notified that the action is done.

