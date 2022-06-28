import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taskmanager/ofline/widget/widget.dart';

import '../app_colors.dart';
import '../data_base_models.dart';
import '../database_helper.dart';
import '../main_provide.dart';

class CreateTaskPage extends StatefulWidget {
  Task? currentTask;

  CreateTaskPage({this.currentTask, Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  @override
  late TimeOfDay time;
  late TimeOfDay time2;
  late TimeOfDay picket;
  late TimeOfDay picket2;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
    time2 = TimeOfDay.now();

    if (widget.currentTask != null) {
      _nameController.text = widget.currentTask?.title ?? "...";
      _dateController.text = widget.currentTask?.startTime ?? "...";
    }
  }

  //select time
  Future<void> selectTime(BuildContext context) async {
    picket = (await showTimePicker(context: context, initialTime: time))!;
    if (picket != null) {
      setState(() {
        time = picket;
      });
    }
  }

  Future<void> selectTime2(BuildContext context) async {
    picket2 = (await showTimePicker(context: context, initialTime: time2))!;
    if (picket2 != null) {
      setState(() {
        time2 = picket2;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: const Color(0xff3A49F9),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff9C2CF3), Color(0xff3A49F9)],
                        begin: const FractionalOffset(1.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        tileMode: TileMode.clamp),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 64,
                            ),
                            Text(
                              widget.currentTask == null
                                  ? 'Create a Task'
                                  : 'Update a task',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(
                              width: 64,
                            ),
                            const Icon(
                              Icons.search,
                              size: 32,
                              color: Colors.white,
                            )
                          ],
                        ),
                        form()
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Time(context),
                        divider(context),
                        const SizedBox(
                          height: 26,
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(color: Color(0xffBFC8E8), fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Lorem ipsum dolor sit amet, "
                              "er adipiscing elit, sed dianummy "
                              "nibh euismod dolor sit amet, er adipiscing elit, "
                              "sed dianummy nibh euismod.",
                          style: TextStyle(
                              color: Color(0xff2E3A59), fontSize: 20, height: 1.2),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        divider(context),
                        const SizedBox(
                          height: 26,
                        ),
                        const Text(
                          "Category",
                          style: TextStyle(color: Color(0xffBFC8E8), fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        categories(context),
                        const SizedBox(
                          height: 30,
                        ),
                        createButton(),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget Time(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            InkWell(
                onTap: () {
                  selectTime(context);
                  print(time);
                },
                child:const Text(
                  "Start Time",
                  style: TextStyle(fontSize: 20, color: Color(0xffBFC8E8)),
                )),
            const SizedBox(
              width: 70,
            ),
            InkWell(
              onTap: () {
                selectTime2(context);
                print(time2);
              },
              child: const Text("End Time",
                  style: TextStyle(fontSize: 20, color: Color(0xffBFC8E8))),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              "${time.hour}:${(time.minute < 10) ? '0${time.minute}' : '${time.minute}'}",
              style: const TextStyle(fontSize: 28, color: Color(0xff2E3A59)),
            ),
            const SizedBox(
              width: 70,
            ),
            Text(
              "${time2.hour}:${(time2.minute < 10) ? '0${time2.minute}' : '${time2.minute}'} ",
              style: const TextStyle(fontSize: 28, color: Color(0xff2E3A59)),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget divider(BuildContext context) {
    return const Divider(
      height: 3,
      color: Color(0xffBFC8E8),
    );
  }

  Widget categories(BuildContext context) {
    return Wrap(
        spacing: 10,
        runSpacing: 8,
        children: List.generate(CategoryTask.topics.length, (index) {
          var category = CategoryTask.topics[index];
          return ChoiceChip(
            padding: const EdgeInsets.all(16),
            selectedColor: AppsColors.lightbottomGradient,
            disabledColor: AppsColors.lightNoSelectColor,
            backgroundColor: AppsColors.lightNoSelectColor,
            labelStyle: TextStyle(
                color: category.isSelected ? Colors.white : Colors.black),
            label: Text(category.title),
            selected: category.isSelected,
            onSelected: (value) {
              setState(() {
                category.isSelected = !category.isSelected;
              });
            },
          );
        }));
  }

  Widget createButton() {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff9C2CF3), Color(0xff3A49F9)],
                begin: const FractionalOffset(1.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                tileMode: TileMode.clamp),
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: TextButton(
          onPressed: () {
            widget.currentTask == null ? createTask() : updateTask();
          },
          child: Center(
            child: Text(
              widget.currentTask == null ? 'Create task' : 'Update task',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ));
  }

  Widget form() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          style: const TextStyle(color: Colors.white, fontSize: 30),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: "Name",
            fillColor: Colors.white,
            labelStyle:
            TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 3),
          ),
        ),
        SizedBox(
          height: 14,
        ),
        TextFormField(
          controller: _dateController,
          style: const TextStyle(color: Colors.white, fontSize: 30),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: "Date",
            fillColor: Colors.white,
            labelStyle:
            TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 3),
          ),
        )
      ],
    );
  }

  void createTask() async {
    Task newTask = Task(
        _nameController.text, "description1", DateTime.now(), "07:47", "19:00");

    var res = await DatabaseHelper.intance.insert(newTask);
    print(res);

    Navigator.pop(context);
  }

  void updateTask() async {
    Task currentTask = Task.withId(
      widget.currentTask?.id,
      _nameController.text,
      "description1",
      DateTime.now(),
      _dateController.text,
      "19:00",
    );

    var res = await DatabaseHelper.intance.update(currentTask);
    print("Updated task : $res");
    Navigator.pop(context);
  }
}




class MyHomePageScreen extends StatefulWidget {
  const MyHomePageScreen({Key? key}) : super(key: key);

  @override
  State<MyHomePageScreen> createState() => _MyHomePageScreenState();
}

class _MyHomePageScreenState extends State<MyHomePageScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 0.8, keepPage: true);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding:const EdgeInsets.only(left: 20, right: 0),
          color: Colors.grey.shade200,
          child: Column(children: <Widget>[
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.add_circle_outlined),),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Icon(Icons.add_circle_outlined)
                    )),
              ],
            ),
            SizedBox(
              height: height * .05,
            ),
            const  Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hello Dear!",
                style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 40,
                    color: Color(0xFF2E3A59),
                    height: 0.8),
              ),
            ),
            const   SizedBox(
              height: 6,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "have a nice day",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    color:const Color(0xFF2E3A59).withOpacity(.4),
                    height: 0.8),
              ),
            ),
            const  SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TaskStatus(task: "My Tasks", taskStatus: true),
                TaskStatus(task: "In-progress", taskStatus: false),
                Container(
                    margin:const EdgeInsets.only(right: 15),
                    child: TaskStatus(task: "Completed", taskStatus: false)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            projectList(width, height, controller),
            const SizedBox(
              height: 10,
            ),
            Container(
              // color: Colors.red.withOpacity(.4),
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotWidth: 12,
                  dotHeight: 12,
                  dotColor: Colors.deepPurple.withOpacity(.5),
                  activeDotColor: Colors.deepPurple,
                  spacing: 20.0,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Progress',
                style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 18),
              ),
            ),
            tasksList()
          ]),
        ),
      ),
    );
  }

  Widget projectList(
      double width,
      double height,
      PageController controller,
      ) {
    return SizedBox(
        width: width,
        height: height * .25,
        child: PageView.builder(
            itemCount: 3,
            controller: controller,
            itemBuilder: (_, index) {
              return Padding(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: TaskCard(
                      taskTitle: "Project 1",
                      TaskName: "Front end Development",
                      deadline: DateTime.now()));
            }));
  }

  Widget tasksList() {
    return SizedBox(
        height: MediaQuery.of(context).size.height * .3,
        child: Consumer<MainProvider>(builder: (context, data, child) {
          return FutureBuilder(
              future: DatabaseHelper.intance.getTasks(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 10),
                  itemBuilder: (context, index) {
                    return TaskItem(snapshot.data![index]);
                  },
                  itemCount: snapshot.data?.length ?? 0,
                );
              });
        }));
  }
}

///3



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  List<Widget> screen = [
    const MyHomePageScreen(),
    const SecondPage(),
    Container(),
    Container()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: screen.elementAt(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          backgroundColor: Colors.grey.shade200,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.height),
              icon: Icon(Icons.height),
              label: "",
            ),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.height),
                icon: Icon(Icons.height),
                label: ''),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.height),
                icon:Icon(Icons.height),
                label: ''),
            BottomNavigationBarItem(
                activeIcon:Icon(Icons.height),
                icon: Icon(Icons.height),
                label: ''),
          ],
          currentIndex: selectedIndex,
          onTap: (int i) {
            setState(() {
              selectedIndex = i;
            });
          },
        ),
      ),
    );
  }
}


///4



class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFF2F5FF),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              shape:const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              backgroundColor: Colors.white,
              expandedHeight: MediaQuery.of(context).size.height * 0.25,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration:const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      )),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MainScreen() ));
                              },
                              child:const Icon(
                                Icons.arrow_back,
                                size: 24,
                                color: Color(0xFF324646),
                              ),
                            ),
                            const Icon(
                              Icons.search,
                              size: 24,
                              color: Color(0xFF324646),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children:const [
                                Text(
                                  "Oct, ",
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "2020",
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            addTaskButton()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 0.0,
                child: Center(
                  child: Text(' '),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tasks",
                            style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2E3A59)),
                          ),
                          tasksList()
                        ],
                      ));
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateTaskList(context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.updateTaskList();
  }
  Widget addTaskButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CreateTaskPage(),
        )).then((value) => updateTaskList(context));
      },
      child: Container(
        height: 40,
        width: 118,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: [
              Color(0xFF9C2CF3),
              Color(0xFF3A49F9),
            ],
          ),
          color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
            child: Text(
              "+ Add Task",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }

  Widget tasksList() {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Consumer<MainProvider>(builder: (context, data, child) {
          return FutureBuilder(
              future: DatabaseHelper.intance.getTasks(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 10),
                  itemBuilder: (context, index) {
                    return TaskItem(snapshot.data![index]);
                  },
                  itemCount: snapshot.data?.length ?? 0,
                );
              });
        }));
  }
}