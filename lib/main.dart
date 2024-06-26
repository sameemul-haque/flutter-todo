import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const TodoPage(title: 'Todo List'),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key, required this.title});

  final String title;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

final List<Todo> _todoList = [];

class _TodoPageState extends State<TodoPage> {
  TextEditingController controller = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  void _addTodo(val) {
    if (controller.text.isEmpty) return;
    setState(() {
      _todoList.add(Todo(
        action: controller.text,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: controller,
              focusNode: myFocusNode,
              decoration:
                  const InputDecoration(labelText: 'Enter your activity here'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                _addTodo(controller.text);
                controller.clear();
                myFocusNode.requestFocus();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text("Submit",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('View Todo List'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewTodoList()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ViewTodoList extends StatelessWidget {
  const ViewTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Second Route'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Expanded(
              child: ListView.builder(
                  itemCount: _todoList.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(_todoList[i].action),
                      tileColor: i % 2 == 0 ? Colors.black26 : Colors.black12,
                    );
                  })),
        ));
  }
}
