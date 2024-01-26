import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app_riverpod/providers/all_providers.dart';
import 'package:flutter_todo_app_riverpod/widgets/title_widget.dart';
import 'package:flutter_todo_app_riverpod/widgets/todo_list_item_widget.dart';
import 'package:flutter_todo_app_riverpod/widgets/toolbar_widget.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});
  final todoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
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
              ref.read(todoListProvider.notifier).addTodo(newTodo);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ToolBarWidget(),
          allTodos.isEmpty
              ? const Center(child: Text('Nothing to show.'))
              : const SizedBox(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
              key: ValueKey(allTodos[i].id),
              onDismissed: (_) {
                ref.read(todoListProvider.notifier).remove(allTodos[i]);
              },
              child: ProviderScope(overrides: [
                currentTodoProvider.overrideWithValue(allTodos[i])
              ], child: const TodoListItemWidget()),
            )
        ],
      ),
    );
  }
}
