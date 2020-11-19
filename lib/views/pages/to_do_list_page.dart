import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/providers/task_provider.dart';
import 'package:aunty_rafiki/views/components/cards/task/completed_task.dart';
import 'package:aunty_rafiki/views/components/cards/task/incoming_task.dart';
import 'package:aunty_rafiki/views/components/cards/task/incomplete_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_task_page.dart';

class ToDoListPage extends StatelessWidget {
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
                      "TASKS LIST",
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
                        Text(
                          "Clinic",
                          style: TextStyle(
                            fontSize: 50,
                            height: 1.2,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[800],
                          ),
                        ),

                        Spacer(),

                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        )
                      ],
                    ),

                    ///List of all the task
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () {
                          return _taskProvider.fetchTasks();
                        },
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return _taskProvider.availableTasks[index].stage ==
                                    TodoTask.COMPLETED
                                ? CompletedTask(
                                    task: _taskProvider.availableTasks[index],
                                    onTap: () {},
                                  )
                                : _taskProvider.availableTasks[index].stage ==
                                        TodoTask.INCOMING
                                    ? IncomingTask(
                                        task:
                                            _taskProvider.availableTasks[index],
                                        onTap: () {},
                                      )
                                    : IncompleteTask(
                                        task:
                                            _taskProvider.availableTasks[index],
                                        onTap: () {},
                                      );
                          },
                          separatorBuilder: (context, index) => Divider(
                            height: 16,
                            color: Colors.transparent,
                          ),
                          itemCount: _taskProvider.availableTasks.length,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateTaskScreen()));
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
                    children: [
                      ///Container for cat button
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.orangeAccent),
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            "A",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 24),
                          ),
                        ),
                      ),

                      ///More buttons

                      ///ForSpace
                      SizedBox(
                        height: 16,
                      ),

                      ///Container for cat button
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[800]),
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            "C",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 24),
                          ),
                        ),
                      ),

                      ///More buttons

                      ///ForSpace
                      SizedBox(
                        height: 16,
                      ),

                      ///Container for cat button
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[800]),
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            "S",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 24),
                          ),
                        ),
                      ),

                      ///More buttons

                      ///ForSpace
                      SizedBox(
                        height: 16,
                      ),

                      ///Container for cat button
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[800]),
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            "D",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 24),
                          ),
                        ),
                      ),

                      ///More buttons
                    ],
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
