import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';

class TaskDetailScreen extends StatelessWidget {
  final Todo todo;

  const TaskDetailScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TodoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Task Detail",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.blue.shade500,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Title
            Text(
              todo.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // 🔹 Card info
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (todo.time.isNotEmpty) ...[
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 18,
                            color: Colors.blueGrey,
                          ),
                          const SizedBox(width: 6),
                          Text(todo.time, style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (todo.description.isNotEmpty) ...[
                      Text(
                        todo.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                    ],
                    Text(
                      "Status: ${todo.isDone ? "Done ✅" : "Not Done ❌"}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: todo.isDone ? Colors.green : Colors.yellow[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // 🔹 Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: todo.isDone
                          ? Colors.blue.shade500
                          : Colors.blue,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      provider.toggleTodoStatus(todo.id);
                      Navigator.pop(context);
                    },
                    child: Text(
                      todo.isDone ? "Mark as Undone" : "Mark as Done",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(60, 48),
                  ),
                  onPressed: () {
                    provider.removeTodo(todo.id);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Task deleted")),
                    );
                  },
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
