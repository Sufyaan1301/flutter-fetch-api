import 'package:flutter/material.dart';
import 'package:learn_fetch_api/add_blog.dart';
import 'package:learn_fetch_api/model.dart';
import 'package:learn_fetch_api/repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'belajar fetch API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // routes: {
      //   '/home': (context) => MyHomePage(title: 'tampilan fetch API'),
      //   '/add_blog': (context) => AddBlog(isAdd: true),
      // },
      home: const MyHomePage(title: 'tampilan fetch API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Blog> listBlog = [];
  Repository repository = Repository();
  getData() async {
    List<Blog> blogs = await repository.getdata();
    setState(() {
      listBlog = blogs;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddBlog(isAdd: true)),
                ),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              AddBlog(isAdd: false, blog: listBlog[index]),
                    ),
                  );
                  // print(listBlog.toList());
                  // Navigator.of(context).pushNamed(
                  //   '/add_blog',
                  //   arguments: [
                  //     listBlog[index].id,
                  //     listBlog[index].nama,
                  //     listBlog[index].pass,
                  //     listBlog[index].email,
                  //   ],
                  // );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("nama: ${listBlog[index].nama}"),
                    Text("pass: ${listBlog[index].pass}"),
                    Text("email: ${listBlog[index].email}"),
                    Text("id: ${listBlog[index].id}"),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  bool response = await repository.deleteData(
                    listBlog[index].id,
                  );
                  if (response) {
                    print('delete data success');
                  } else {
                    print('delete data failed');
                  }
                  getData();
                },
                icon: Icon(Icons.delete),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: listBlog.length,
      ),
    );
  }
}
