// lib/models/todo.dart
class Todo {
  final String id; // unique id untuk tiap task
  final String title; // judul task (wajib)
  final String description; // deskripsi singkat (opsional)
  final String time; // teks jam, mis. "08:00 - 09:00" (opsional)
  bool isDone; // status centang

  Todo({
    required this.id,
    required this.title,
    this.description = '',
    this.time = '',
    this.isDone = false,
  });
}
