import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app_riverpod/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description) {
    var newTodo = TodoModel(const Uuid().v4(), description);
    state = [...state, newTodo];
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(todo.id, todo.description, isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }

  void edit({required String id, required String newDescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(todo.id, newDescription, isCompleted: todo.isCompleted)
        else
          todo
    ];
  }

  void remove(TodoModel removeTodo) {
    state = state.where((element) => element.id != removeTodo.id).toList();
  }

  int uncompletedTodoCount() {
    return state.isEmpty
        ? -1
        : state.where((element) => !element.isCompleted).length;
  }
}
