import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  AddScreen({Key key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _picker = ImagePicker();
  DateTime _deadline = DateTime.now();
  File _image;

  void _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 3600)),
    );
    if (picked != null) {
      setState(() {
        _deadline = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _deadline.hour,
          _deadline.minute,
        );
      });
    }
  }

  void _selectTime() async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_deadline),
    );
    if (picked != null) {
      setState(() {
        _deadline = DateTime(
          _deadline.year,
          _deadline.month,
          _deadline.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  void _selectImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _onAdd() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Judul'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Deskripsi'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 4),
                  child: Text(
                    'Tanggal',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                InkWell(
                  onTap: _selectDate,
                  child: Text(
                    '${_deadline.day}/${_deadline.month}/${_deadline.year}',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 4),
                  child: Text(
                    'Jam',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                InkWell(
                  onTap: _selectTime,
                  child: Text('${_deadline.hour}:${_deadline.minute}'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 4),
                  child: Text(
                    'Lampiran',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                InkWell(
                  onTap: _selectImage,
                  child: Text(_image != null ? _image.path : 'Pilih Gambar'),
                ),
                SizedBox(height: 18),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    onPressed: _onAdd,
                    child: Text('Tambah'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
