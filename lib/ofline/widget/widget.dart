import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:taskmanager/ofline/screens/screens.dart';

import '../data_base_models.dart';
import '../database_helper.dart';
import '../main_provide.dart';

class TaskCard extends StatelessWidget {
  String taskTitle;
  String TaskName;
  DateTime deadline;

  TaskCard(
      {Key? key,
        required this.taskTitle,
        required this.TaskName,
        required this.deadline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var date = DateFormat('MMMM dd  yyyy').format(deadline);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF9C2CF3),
                Color(0xFFCA1DFA)
              ]
          )),
      padding: EdgeInsets.all(15),
      width: width * .6,
      height: width * .6,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: Container(
                width: width * .3,
                height: width*.3,
                decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(.3),
                    borderRadius: BorderRadius.circular(100)),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  taskTitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PoppinsBold',
                      fontSize: 24),
                ),
              ]),
              Text(
                TaskName,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PoppinsBold',
                    fontSize: 28),
              ),
              Text(
                '${date}',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PoppinsBold',
                    fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem(this.task, {Key? key}) : super(key: key);

  void updateTaskList(context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.updateTaskList();
  }

  void deletaeTask(context)async{
    await DatabaseHelper.intance.delete(task.id!);
    updateTaskList(context);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const  SizedBox(
          height: 12,
        ),
        Container(
          padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: ListTile(
            title: Text(
              task.title ?? "...",
              style:const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(task.startTime ?? "..."),
            trailing: PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'edit',
                    child:const Text('Edit'),
                    onTap: () {},
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  )
                ];
              },
              onSelected: (String value) {
                if (value == 'edit') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => CreateTaskPage(currentTask: task),
                  ))
                      .then((value) => updateTaskList(context));
                }
                else if(value == "delete"){
                  deletaeTask(context);
                }
              },
            ),
            leading: Container(
              height: 61.0,
              width: 61.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient:const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF9C2CF3),
                      Color(0xFF3A49F9),
                    ],
                  )),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Image.asset(
                  'assets/images/list_icon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class TaskStatus extends StatelessWidget {
  TaskStatus({Key? key, required this.task, required this.taskStatus})
      : super(key: key);
  String task;
  bool taskStatus;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width * .28,
      height: 50,
      decoration: BoxDecoration(
          color: taskStatus ? Colors.white : Color(0xCCE5EAFC),
          borderRadius: BorderRadius.circular(40)),
      child: Center(
        child: Text(
          task,
          style: TextStyle(fontFamily: taskStatus ? 'PoppinsBold' : 'Poppins', fontSize: 15,color: Color(0xFF2E3A59)),),

      ),
    );
  }
}