// lib/providers/todo_provider.dart
import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  final Map<String, List<Todo>> _todosByDate = {}; // key: 'yyyy-mm-dd'

  // helper -> buat key string untuk map dari DateTime
  String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  // public getter selected date
  DateTime get selectedDate => _selectedDate;

  // ambil list task untuk tanggal yg sedang dipilih
  List<Todo> get todosForSelectedDate =>
      _todosByDate[_dateKey(_selectedDate)] ?? [];

  // ubah tanggal terpilih (memaksa ke midnight agar konsisten)
  void setSelectedDate(DateTime d) {
    _selectedDate = DateTime(d.year, d.month, d.day);
    notifyListeners();
  }

  // next / prev helper
  void nextDate() =>
      setSelectedDate(_selectedDate.add(const Duration(days: 1)));
  void prevDate() =>
      setSelectedDate(_selectedDate.subtract(const Duration(days: 1)));

  // menambahkan todo ke tanggal tertentu (default: selectedDate)
  void addTodo(Todo todo, [DateTime? date]) {
    final key = _dateKey(date ?? _selectedDate);
    _todosByDate.putIfAbsent(key, () => []).add(todo);
    notifyListeners();
  }

  // toggle status berdasarkan id di selectedDate
  void toggleTodoStatus(String id) {
    final key = _dateKey(_selectedDate);
    final list = _todosByDate[key];
    if (list == null) return;
    for (var t in list) {
      if (t.id == id) {
        t.isDone = !t.isDone;
        notifyListeners();
        return;
      }
    }
  }

  // hapus todo berdasarkan id di selectedDate
  void removeTodo(String id) {
    final key = _dateKey(_selectedDate);
    final list = _todosByDate[key];
    if (list == null) return;
    list.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  // utility: buat rentang tanggal sekitar selected (mis -3 .. +3)
  List<DateTime> rangeAroundSelected(int before, int after) {
    return List.generate(
      before + after + 1,
      (i) => _selectedDate.subtract(Duration(days: before - i)),
    );
  }
}
