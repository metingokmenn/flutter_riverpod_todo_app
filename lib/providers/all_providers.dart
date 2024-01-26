import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app_riverpod/models/todo_model.dart';
import 'package:flutter_todo_app_riverpod/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

enum TodoListFilter { all, active, completed }

final todoListFilter =
    StateProvider<TodoListFilter>((ref) => TodoListFilter.all);

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(const Uuid().v4(), 'Spora Git'),
    TodoModel(const Uuid().v4(), 'Alışveriş'),
    TodoModel(const Uuid().v4(), 'Ders Çalış', isCompleted: true)
  ]);
});

final filteredTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.completed:
      return todoList.where((element) => element.isCompleted).toList();
    case TodoListFilter.active:
      return todoList.where((element) => !element.isCompleted).toList();
  }
});

final uncompletedTodoCountProvider = Provider<int>((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((element) => !element.isCompleted).length;

  return allTodo.isEmpty ? -1 : count;
});

final currentTodoProvider = Provider<TodoModel>(
  (ref) {
    throw UnimplementedError();
  },
);
