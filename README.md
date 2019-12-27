# Synchronize Async Tasks

Get notified when a list of Async tasks are done using `dispatch_group`.

![Notified after all Async tasks are done.](images/screenshots/1.gif)


## Using:

**API calls:** AFNetworking | **Data display:** UITableView


## Notes:

### In `ViewController+SyncTasks.m` check the following: 
 
**1.** Call async tasks.

> I used API calls to get some data.

```objective-c
// Call async tasks
[self backgroundGet:booksURL  objectKey:@"Books" ];
[self backgroundGet:appsURL  objectKey:@"Apps" ];
```

**2.** Insert each task in dispatch_group using `dispatch_group_enter()`.

```objective-c
// Insert the task in dispatch_group
dispatch_group_enter(serviceGroup);
```


**3.** Remove the task from dispatch_group when the task is done using `dispatch_group_leave()`.

```objective-c
// Remove the task from dispatch_group when done
dispatch_group_leave(self->serviceGroup);
```

**4.** Get notified when all tasks are completed.
> When all 'dispatch_group_leave' have been called,
> we are notified that the action is done.

```objective-c
// Get notified when all tasks are completed, this is when all 'dispatch_group_leave' have been called
dispatch_group_notify(serviceGroup, dispatch_get_main_queue(),^{
        ...
});
```
   


