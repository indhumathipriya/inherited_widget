import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inherited_widget/app.dart';
import 'package:inherited_widget/create_task.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    final AppState app = App.of(context);
    final AppData data = AppProvider.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateTaskView()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Tasks"),
        actions: [
          Center(
            child: IconButton(
              onPressed: () {
                app.switchThemeMode();
              },
              icon: const Icon(Icons.sunny),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
        ],
      ),
      body: data.tasks.isEmpty
          ? const Center(
              child: Text("Click + to create a Task"),
            )
          : ListView.separated(
              itemCount: data.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                var taskData = data.tasks.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            taskData.title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                data.tasks.removeAt(index);
                              });
                            },
                            icon: const Icon(
                              CupertinoIcons.xmark_seal,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(taskData.taskName),
                              const Divider(thickness: 0.6, color: Colors.grey),
                              const SizedBox(
                                height: 8.0,
                              ),
                              const Text(
                                "Notes",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(taskData.notes),
                              const SizedBox(
                                height: 64,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(taskData.date),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  Text(taskData.time),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 16.0,
                );
              },
            ),
    );
  }
}
