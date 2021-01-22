import 'package:flutter/material.dart';
import 'package:todoapp/screens/add_screen.dart';
import 'package:todoapp/widgets/todo_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _todoList = [
    {'title': 'judul A', 'desc': 'deskripsi A'},
    {'title': 'judul B'},
    {'title': 'judul B'},
    {'title': 'judul B'},
  ];

  void _goToAddScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          return TodoCard(
            title: _todoList[i]['title'],
            subtitle: _todoList[i]['desc'],
            onTap: () {},
          );
        },
        itemCount: _todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddScreen,
        child: Icon(Icons.add),
      ),
    );
  }
}
