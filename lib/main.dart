import 'package:flutter/material.dart';

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

class _TodoPageState extends State<TodoPage> {
  final _todoList = [];

  void _addTodo(val) {
    setState(() {
      _todoList.add(val);
    });
  }

  TextEditingController controller = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  String bullet = "\u2022 ";

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
                decoration: const InputDecoration(labelText: 'Enter your activity here'),
                onSubmitted: (val) => {
                  _addTodo(val),
                  controller.clear(),
                  myFocusNode.requestFocus(),
                }
            ),
            Expanded(child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, i) {
                  return Text(bullet + _todoList[i]);
                }
            ))
          ],
        ),
      ),

    );
  }
}
