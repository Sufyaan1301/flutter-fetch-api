import 'package:flutter/material.dart';
import 'package:learn_fetch_api/main.dart';
import 'package:learn_fetch_api/repository.dart';

import 'model.dart';

class AddBlog extends StatefulWidget {
  final bool isAdd;
  final Blog? blog;
  const AddBlog({super.key, required this.isAdd, this.blog});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  Repository repository = Repository();
  final _namaController = TextEditingController();
  final _passController = TextEditingController();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.blog?.nama ?? '';
    _passController.text = widget.blog?.pass ?? '';
    _emailController.text = widget.blog?.email ?? '';
    _idController.text = widget.blog?.id ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.isAdd == false) {
    //   final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    //   if (args[1] != null) {
    //     _namaController.text = args[1];
    //   }
    //   if (args[2] != null) {
    //     _passController.text = args[2].toString();
    //   }
    //   if (args[3] != null) {
    //     _emailController.text = args[3];
    //   }
    // }

    return Scaffold(
      appBar: AppBar(title: Text('add blog')),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: InputDecoration(hintText: 'nama'),
            ),
            TextField(
              controller: _passController,
              decoration: InputDecoration(hintText: 'pass'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'email'),
            ),
            TextField(
              controller: _idController,
              decoration: InputDecoration(hintText: 'id'),
            ),
            ElevatedButton(
              onPressed: () async {
                bool response = await repository.postdata(
                  _namaController.text,
                  _passController.text,
                  _emailController.text,
                  _idController.text,
                );
                if (response) {
                  Navigator.pop(context);
                } else {
                  print('post data gagal');
                }
              },
              child: Text('submit'),
            ),
            ElevatedButton(
              onPressed: () async {
                print(_passController.text);
                bool response = await repository.putData(
                  _idController.text,
                  _namaController.text,
                  _passController.text,
                  _emailController.text,
                );
                if (response) {
                  Navigator.pop(context);
                  await repository.getdata();
                } else {
                  print('Update data gagal');
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
