import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/helpers/firebase_storage.dart';
import 'package:todoapp/widgets/task_form.dart';

class EditScreen extends StatefulWidget {
  final String id;
  final String title;
  final String desc;
  final DateTime deadline;
  final String imageUrl;

  EditScreen({
    Key key,
    @required this.id,
    @required this.title,
    @required this.deadline,
    @required this.desc,
    this.imageUrl,
  }) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final CollectionReference tasks = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('tasks');
  DateTime _deadline = DateTime.now();
  bool _loading = false;
  bool _loadingDelete = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _descController.text = widget.desc;
    _deadline = widget.deadline;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _onDelete() {}

  _onEditTask(DateTime deadline, File file) async {
    if (!_loading && _formKey.currentState.validate()) {
      try {
        setState(() {
          _loading = true;
        });
        String attachment;
        // menghapus data lama dan upload data baru di firebase storage
        if (file != null) {
          await getRefFromUrl(widget.imageUrl)?.delete();
          attachment = await uploadFile(file);
        }
        // selesai olah file
        await tasks.doc(widget.id).update({
          "title": _titleController.text,
          "description": _descController.text,
          "deadline": Timestamp.fromDate(deadline),
          "attachment": attachment ?? widget.imageUrl,
        });
        Navigator.of(context).pop();
      } catch (error) {
        setState(() {
          _loading = false;
        });
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              "Error edit data ${error.toString()}",
            ),
          ),
        );
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Ubah'),
        actions: [
          _loadingDelete
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: _onDelete,
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: TaskForm(
          formKey: _formKey,
          titleController: _titleController,
          descController: _descController,
          deadline: _deadline,
          onSubmit: _onEditTask,
          loading: _loading,
          btnText: 'Ubah',
          imageUrl: widget.imageUrl,
        ),
      ),
    );
  }
}
