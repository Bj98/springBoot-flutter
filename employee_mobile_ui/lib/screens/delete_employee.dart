import 'dart:convert';

import 'package:employee_mobile_ui/model/EmployeeModel.dart';
import 'package:employee_mobile_ui/screens/get_all_employees.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteEmployee extends StatefulWidget {
  const DeleteEmployee({Key/*!*/ key}) : super(key: key);

  @override
  _DeleteEmployeeState createState() => _DeleteEmployeeState();
}

Future<EmployeeModel> deleteEmployees(String firstName,String lastName)async{
  var url="http://localhost:8080/deleteEmployee";
  var response=await http.delete(
  url,
  headers:<String,String>{"Content-Type":"application/json;charset=UTF-8"},
  );
  return EmployeeModel.fromJson(jsonDecode(response.body));
}
class _DeleteEmployeeState extends State<DeleteEmployee> {
  @override
  Widget build(BuildContext context) {
    return GetAllEmployees();
  }
}
