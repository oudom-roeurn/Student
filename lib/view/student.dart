import 'package:storage/database/database_helper.dart';

class Student {
  int? id;
  String? gender;
  String? name;
  int? age;

  Student({this.id, this.name, this.gender, this.age});
  Map<String, dynamic> toMap() {
    return {
      DatabaseHalper().columGender: gender,
      DatabaseHalper().columName: name,
      DatabaseHalper().columage: age,
    };
  }

  Student.fromMap(Map<String, dynamic> map)
      : id = map[DatabaseHalper().columId],
        name = map[DatabaseHalper().columName],
        gender = map[DatabaseHalper().columGender],
        age = map[DatabaseHalper().columage];
}
