import 'package:flutter/material.dart';
import 'package:flutter_todo_app_riverpod/widgets/title_widget.dart';
import 'package:flutter_todo_app_riverpod/widgets/todo_list_item_widget.dart';
import 'package:flutter_todo_app_riverpod/widgets/toolbar_widget.dart';

class TodoApp extends StatelessWidget {
  TodoApp({super.key});
  final todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            decoration: const InputDecoration(
              labelText: "What are you going to do ?",
            ),
            controller: todoController,
            onSubmitted: (newTodo) {
              debugPrint('add $newTodo');
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const ToolBarWidget(),
          const TodoListItemWidget(),
          const TodoListItemWidget(),
        ],
      ),
    );
  }
}
