import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/task_storage.dart';
import '../models/task_model.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskStorage = Provider.of<TaskStorage>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
      ),
      body: ListView.builder(
        itemCount: taskStorage.tasks.length,
        itemBuilder: (context, index) {
          final task = taskStorage.tasks[index];
          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            leading: Checkbox(
              value: task.isDone,
              onChanged: (_) => taskStorage.toggleTask(task),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => taskStorage.deleteTask(task),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            taskStorage.addTask(TaskModel(title: _controller.text));
            _controller.clear();
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter Task',
          ),
        ),
      ),
    );
  }
}
