import 'package:flutter/material.dart';
import 'package:inherited_widget/app.dart';
import 'package:inherited_widget/model.dart';

class CreateTaskView extends StatefulWidget {
  final bool? isEdit;
  const CreateTaskView({Key? key, this.isEdit = false}) : super(key: key);

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  final titleCtrl = TextEditingController();
  final contentCtrl = TextEditingController();
  final notesCtrl = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  String date = '';
  String time = '';
  List<TaskModel> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            TextField(
              controller: contentCtrl,
              decoration: const InputDecoration(hintText: "Tasks"),
            ),
            TextField(
              maxLines: 3,
              controller: notesCtrl,
              decoration: const InputDecoration(hintText: "Notes"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedTime.format(context)),
                TextButton(
                  onPressed: () {
                    chooseTime(context);
                  },
                  child: const Text("Choose Time"),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}"),
                Align(
                  child: TextButton(
                    onPressed: () {
                      chooseDate(context);
                    },
                    child: const Text("Choose Date"),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 0.7, color: Colors.grey),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _addingTaskToList();

                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> chooseTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        time = selectedTime.format(context);
        debugPrint(time);
      });
    }
  }

  Future<void> chooseDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        date = "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
      });
    }
  }

  _addingTaskToList() {
    final AppState app = App.of(context);
    tasks.addAll([
      TaskModel(
        title: titleCtrl.text,
        taskName: contentCtrl.text,
        notes: notesCtrl.text,
        date: date,
        time: time,
      ),
    ]);
    app.saveTask(tasks);
  }
}
