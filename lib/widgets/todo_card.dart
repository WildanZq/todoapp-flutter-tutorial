import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;

  const TodoCard({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
    );
  }
}
