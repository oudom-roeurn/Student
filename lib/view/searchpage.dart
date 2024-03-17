import 'package:flutter/material.dart';
import 'package:storage/database/database_helper.dart';
import 'package:storage/view/student.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Student> studentList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.blue,
        flexibleSpace: SafeArea(
            child: Container(
          margin: const EdgeInsets.fromLTRB(50, 20, 15, 15),
          padding: const EdgeInsets.fromLTRB(0, 0, 2, 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: TextField(
            maxLines: 1,
            textAlignVertical: TextAlignVertical.center,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
                hintText: "Search Here....",
                prefixIcon: Icon(Icons.search, color: Colors.black45),
                border: InputBorder.none),
            onChanged: (value) async {
              await DatabaseHalper().searchStudent(value).then(
                (student) {
                  setState(() {
                    studentList = student;
                  });
                },
              );
            },
          ),
        )),
      ),
      body: ListView.builder(
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            // onLongPress: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             HomescreenPage(student: studentList[index]),
            //       ));
            // },
            title: Text(
              studentList[index].name.toString(),
            ),
            subtitle: Text(
              studentList[index].age.toString(),
            ),
            trailing: IconButton(
                onPressed: () async {
                  // await DatabaseHalper()
                  //     .deleteTask(id: studentList[index].id!)
                  //     .whenComplete(() => getFetchDatabase());
                },
                icon: Icon(Icons.delete)),
          ));
        },
      ),
    );
  }
}
