import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime deadline;
  final Function onTap;

  const TodoCard({
    Key key,
    @required this.title,
    @required this.description,
    @required this.deadline,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      subtitle: description != null ? Text(description) : null,
    );
  }
}
