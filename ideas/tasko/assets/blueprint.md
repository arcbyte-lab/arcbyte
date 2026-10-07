# Blueprint

## TasksListPanel

_assemble_

```
Task
├── title/name
├── priority . status . due date
```

_handle_

```
1. topbar: open log
2. topbar: open notification
3. topbar: account setting
4. topbar: log out
5. pulse-panel: toggle fullscreen
6. pulse-panel: swipe month
7. tasks-list-panel: group *by attr
8. tasks-list-panel: sort *asc/dsc attr
9. tasks-list-panel: filter *by attr val
10. tasks-list-panel: search
```

## CreateTaskSheet

_assemble_

```
Create Task Form
├── title/name
├── note [add new column]
├── priority [select-priority-level]
├── due date [date picker]
├── assignee [select-user] *div/proj.
```

_handle_

```
1. done
```

## TaskDetailSheet

_assemble_

```
TaskDetailView
├── title/name
├── note [add new column]
├── priority [select-priority-level]
├── due date [date picker]
├── recurring [recurring-setup-screen]
├── sub-tasks
├── discussions *div/proj.
├── assignee [select-user] *div/proj.
```

_handle_

```
1. archive task *only-author
2. request extend due date *only-member
3. mark start task
4. submit proof
5. approve submition *author/management
6. decline submition *author/management
```

## RecurringSetupScreen

_assemble_

```
Setup Rercurring Form
├── every (day, week, month, year)
    ├── atTime
├── start *first creation only
├── end 
    ├── never
    ├── onDate
    ├── after n occurences
```

_handle_

```
1. done
```

_priority-level_

1. Low

2. Medium

3. High

4. Urgent

_status_

- waiting

- in-progress

- review \*div/proj

- done