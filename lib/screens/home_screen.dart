import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/task_storage.dart';
import '../models/task_model.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("To-Do List"),
        centerTitle: true,
      ),
      body: Consumer<TaskStorage>(
        builder: (context, taskStorage, child) {
          final tasks = taskStorage.tasks;

          return AnimatedList(
            key: _listKey,
            initialItemCount: tasks.length,
            itemBuilder: (context, index, animation) {
              final task = tasks[index];
              return SizeTransition(
                sizeFactor: animation,
                child: TaskTile(
                  title: task.title,
                  isDone: task.isDone,
                  onToggle: () {
                    taskStorage.toggleTask(task);
                  },
                  onDelete: () {
                    final removedTask = task;
                    taskStorage.deleteTask(task);
                    _listKey.currentState?.removeItem(
                      index,
                          (context, animation) => SizeTransition(
                        sizeFactor: animation,
                        child: TaskTile(
                          title: removedTask.title,
                          isDone: removedTask.isDone,
                          onToggle: () {},
                          onDelete: () {},
                        ),
                      ),
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Task"),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: "Enter task title"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _controller.clear();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (_controller.text.trim().isNotEmpty) {
                final task = TaskModel(title: _controller.text.trim());
                final taskStorage =
                Provider.of<TaskStorage>(context, listen: false);
                taskStorage.addTask(task);
                _listKey.currentState?.insertItem(
                  taskStorage.tasks.length - 1,
                  duration: const Duration(milliseconds: 300),
                );
                Navigator.pop(context);
                _controller.clear();
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
