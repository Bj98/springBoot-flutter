import 'dart:convert';

EmployeeModel employeeModelJson(String str)=>
    EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data)=> json.encode(data.toJson());

class EmployeeModel {
  int id;
  String firstName;
  String lastName;

  EmployeeModel({this.id, this.firstName, this.lastName});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"]
      );

  Map<String,dynamic> toJson()=>{
    "id":id,
    "firstName":firstName,
    "lastName":lastName
  };

  // String get firstName => firstName;
  // String get lastName =>lastName;
}
