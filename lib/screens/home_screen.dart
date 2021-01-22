import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todoapp/screens/add_screen.dart';
import 'package:todoapp/screens/login_screen.dart';
import 'package:todoapp/widgets/todo_card.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  HomeScreen({
    Key key,
    @required this.name,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  Future<void> _onLogout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App ${widget.name}'),
        actions: [
          IconButton(
            onPressed: _onLogout,
            icon: Icon(Icons.logout),
          ),
        ],
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
