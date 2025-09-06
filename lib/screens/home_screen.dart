// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item.dart';
import '../models/todo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _monthShort(int m) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return months[m - 1];
  }

  String formatHeaderDate(DateTime d) {
    return '${d.day} ${_monthShort(d.month)}';
  }

  void _showAddTodoDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final timeCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Add New Task"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                TextField(
                  controller: descCtrl,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
                TextField(
                  controller: timeCtrl,
                  decoration: const InputDecoration(
                    labelText: "Time (e.g. 07:00 - 08:00)",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel", style: TextStyle(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleCtrl.text.trim().isEmpty) return;
                context.read<TodoProvider>().addTodo(
                  Todo(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleCtrl.text,
                    description: descCtrl.text,
                    time: timeCtrl.text,
                  ),
                );
                Navigator.pop(ctx);
              },
              child: const Text("Save", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();
    final todos = provider.todosForSelectedDate;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue.shade500,
        elevation: 0,
        centerTitle: true,
        title: Text(
          formatHeaderDate(provider.selectedDate),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: provider.selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              ).then((picked) {
                if (picked != null) provider.setSelectedDate(picked);
              });
            },
          ),
        ],
      ),

      // 🔹 Body tanpa kotak-kotak tanggal
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Title "My Tasks"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'My Tasks',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => provider.prevDate(),
                    icon: const Icon(Icons.chevron_left),
                  ),
                  IconButton(
                    onPressed: () => provider.nextDate(),
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),

            // 🔹 List todo
            Expanded(
              child: todos.isEmpty
                  ? Center(
                      child: Text(
                        'No tasks for this day',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      itemCount: todos.length,
                      itemBuilder: (context, i) {
                        final t = todos[i];
                        return TodoItem(
                          todo: t,
                          onToggle: () => context
                              .read<TodoProvider>()
                              .toggleTodoStatus(t.id),
                          onDelete: () =>
                              context.read<TodoProvider>().removeTodo(t.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTodoDialog(context),
        label: const Text('Add New'),
        icon: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 202, 233, 255),
      ),
    );
  }
}
