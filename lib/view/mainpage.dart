import 'package:flutter/material.dart';
import 'package:storage/database/database_helper.dart';
import 'package:storage/view/homescreen.dart';
import 'package:storage/view/searchpage.dart';
import 'package:storage/view/student.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Student> studentList = [];
  void getFetchDatabase() async {
    await DatabaseHalper().getStudent().then((value) {
      setState(() {
        studentList = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFetchDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.blue,
        flexibleSpace: SafeArea(
            child: Container(
          margin: const EdgeInsets.fromLTRB(15, 20, 15, 15),
          padding: const EdgeInsets.fromLTRB(0, 0, 2, 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: TextField(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            maxLines: 1,
            textAlignVertical: TextAlignVertical.center,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search, color: Colors.black45),
                border: InputBorder.none),
          ),
        )),
      ),
      body: ListView.builder(
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            onLongPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomescreenPage(student: studentList[index]),
                  ));
            },
            title: Text(
              studentList[index].name.toString(),
            ),
            subtitle: Text(
              studentList[index].age.toString(),
            ),
            trailing: IconButton(
                onPressed: () async {
                  await DatabaseHalper()
                      .deleteTask(id: studentList[index].id!)
                      .whenComplete(() => getFetchDatabase());
                },
                icon: Icon(Icons.delete)),
          ));
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          // Image.network("https://image.shutterstock.com/image-photo/group-students-digital-tablet-laptop-260nw-2347371743.jpg")
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomescreenPage()));
            },
            child: Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: const Center(
                  child: Text(
                "AddStudent",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ]),
      ),
    );
  }
}
