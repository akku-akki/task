import 'dart:convert';

User createUser(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.status,
    this.data,
  });

  String status;
  UserData data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };

  @override
  String toString() {
    return "${this.status} ${this.data.name} ${this.data.age} ${this.data.salary} ";
  }
}

class UserData {
  UserData({
    this.name,
    this.salary,
    this.age,
    this.id,
  });

  String name;
  String salary;
  String age;
  int id;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        name: json["name"],
        salary: json["salary"],
        age: json["age"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "salary": salary,
        "age": age,
        // "id": id,
      };
}
