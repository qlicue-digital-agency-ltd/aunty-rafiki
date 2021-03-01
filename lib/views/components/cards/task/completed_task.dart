import 'package:aunty_rafiki/models/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CompletedTask extends StatelessWidget {
  final Task task;
  final Function onTap;
  // date format instance
  final DateFormat format = DateFormat("MMMM d, y");
  CompletedTask({Key key, @required this.task, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey[100]),
          color: Colors.pink[400]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Show completed check
          ///Task Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  task.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),

              ///For Space

              SizedBox(
                width: 4,
              ),

              Icon(
                Icons.check_circle,
                color: Colors.white,
              )
            ],
          ),

          ///For Space
          SizedBox(
            height: 8,
          ),

          ///Task Detail
          Row(
            children: [
              Text(
                '${format.format(DateTime.parse(task.date))}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.white70),
              ),
              Spacer(),
              Text(
                "COMPLETED",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
