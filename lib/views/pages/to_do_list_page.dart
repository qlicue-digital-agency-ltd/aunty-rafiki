import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/task_provider.dart';
import 'package:aunty_rafiki/views/components/buttons/color_letter_button.dart';
import 'package:aunty_rafiki/views/components/cards/task/completed_task.dart';
import 'package:aunty_rafiki/views/components/cards/task/incoming_task.dart';
import 'package:aunty_rafiki/views/components/cards/task/incomplete_task.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  bool _isPullToRefresh = false;

  @override
  Widget build(BuildContext context) {
    final _taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Row(
          children: [
            ///Container for Content
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TODO LIST",
                      style: TextStyle(
                          fontSize: 18,
                          height: 1.2,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900,
                          color: Colors.blueGrey[200]),
                    ),

                    ///For spacing
                    SizedBox(
                      height: 4,
                    ),

                    Row(
                      children: [
                        ///Text
                        Expanded(
                          child: Text(
                            _taskProvider.selectedLetterButton.tittle,
                            style: TextStyle(
                              fontSize: 25,
                              height: 1.2,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///List of all the task
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () {
                          setState(() {
                            _isPullToRefresh = true;
                          });
                          return _taskProvider.fetchTasks();
                        },
                        child: _taskProvider.isFetchingTaskData &&
                                !_isPullToRefresh
                            ? Center(child: CircularProgressIndicator())
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  return _taskProvider.filteredTasks.isEmpty
                                      ? Center(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3,
                                              ),
                                              NoItemTile(
                                                icon:
                                                    'assets/access/to-do-list.png',
                                                title: 'No Tasks',
                                              ),
                                            ],
                                          ),
                                        )
                                      : (_taskProvider
                                                  .filteredTasks[index].stage ==
                                              TodoTask.COMPLETED
                                          ? Dismissible(
                                              onDismissed: (direction) {
                                                print(direction);
                                              },
                                              key: Key(index.toString()),
                                              child: CompletedTask(
                                                task: _taskProvider
                                                    .filteredTasks[index],
                                                onTap: () {},
                                              ),
                                            )
                                          : _taskProvider.filteredTasks[index]
                                                      .stage ==
                                                  TodoTask.INCOMING
                                              ? Dismissible(
                                                  onDismissed: (direction) {
                                                    print(direction);
                                                  },
                                                  key: Key(index.toString()),
                                                  child: IncomingTask(
                                                    task: _taskProvider
                                                        .filteredTasks[index],
                                                    onTap: () {},
                                                  ),
                                                )
                                              : Dismissible(
                                                  onDismissed: (direction) {
                                                    print(direction);
                                                  },
                                                  key: Key(index.toString()),
                                                  child: IncompleteTask(
                                                    task: _taskProvider
                                                        .filteredTasks[index],
                                                    onTap: () {},
                                                  ),
                                                ));
                                },
                                separatorBuilder: (context, index) => Divider(
                                  height: 16,
                                  color: Colors.transparent,
                                ),
                                itemCount: _taskProvider.filteredTasks.isEmpty
                                    ? 1
                                    : _taskProvider.filteredTasks.length,
                              ),
                      ),
                    ),

                    ///For spacing
                    SizedBox(
                      height: 16,
                    ),

                    ///Button for add new task
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        color: Colors.pink[400],
                        child: Text(
                          "ADD NEW TASK",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, createTaskPage);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

            ///Container for task categories
            Container(
              width: MediaQuery.of(context).size.width * 0.22,
              color: Colors.pink,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
              child: Column(
                children: [
                  ///For space
                  Spacer(),

                  Column(
                    children:
                        _taskProvider.availableLetterButton.map((element) {
                      return ColorLetterButton(
                        letterButton: element,
                        onTap: () {
                          _taskProvider.toogleLetterButton = element.id;
                        },
                      );
                    }).toList(),
                  ),

                  ///ForSpace
                  Spacer(),

                  ///Menu button
                  IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
