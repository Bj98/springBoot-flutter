import 'dart:convert';

import 'package:employee_mobile_ui/model/EmployeeModel.dart';
import 'package:employee_mobile_ui/screens/employee_drawer.dart';
import 'package:employee_mobile_ui/screens/register_employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class UpdateEmployee extends StatefulWidget {
  EmployeeModel employeeModel;

  UpdateEmployee({this.employeeModel});

  @override
  _UpdateEmployeeState createState()=>_UpdateEmployeeState(employeeModel);
  // EmployeeModel employeeModel;
  //
  // UpdateEmployee(this.employeeModel);
  //
  // @override
  // _UpdateEmployeeState createState() => _UpdateEmployeeState(employeeModel);
}

// ignore: missing_return
Future<EmployeeModel> updateEmployees(
    EmployeeModel employeeModel, BuildContext context) async {
  var url = "http://localhost:8080/updateEmployee";
  var response = await http.put(url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(employeeModel));
  if (response.statusCode == 200) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(
              title: "Backend Response", content: response.body);
        });
  }
}

class _UpdateEmployeeState extends State<UpdateEmployee> {
  EmployeeModel employeeModel;
  final minimumPadding = 5.0;
  TextEditingController employeeNumber;
  bool _isEnabled = false;
  Future<List<EmployeeModel>> employees;
  TextEditingController firstController;
  TextEditingController lastController;

  _UpdateEmployeeState(this.employeeModel) {
    employeeNumber =
        TextEditingController(text: this.employeeModel.id.toString());
    firstController = TextEditingController(text: this.employeeModel.firstName);
    lastController = TextEditingController(text: this.employeeModel.lastName);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Employee"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EmployeeDrawer()));
          },
        ),
      ),
      body: Container(
          child: Form(
              child: Padding(
        padding: EdgeInsets.all(minimumPadding * 2),
        child: ListView(children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
            child: TextFormField(
              style: textStyle,
              controller: employeeNumber,
              enabled: _isEnabled,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Please enter your ID!";
                }
              },
              decoration: InputDecoration(
                  labelText: "Employee ID",
                  hintText: "Enter Employee ID",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
            child: TextFormField(
              style: textStyle,
              controller: firstController,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Please enter your name!";
                }
              },
              decoration: InputDecoration(
                  labelText: "First Name",
                  hintText: "Enter your first name",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
            child: TextFormField(
              style: textStyle,
              controller: lastController,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Please enter your name!";
                }
              },
              decoration: InputDecoration(
                  labelText: "Last Name",
                  hintText: "Enter your last name",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          ElevatedButton(
              child: Text("Update Details"),
              onPressed: () async {
                // String firstName = firstController.text;
                // String lastName = lastController.text;
                EmployeeModel emp = new EmployeeModel();
                emp.id = employeeModel.id;
                emp.firstName = firstController.text;
                emp.lastName = lastController.text;

                EmployeeModel employees = await updateEmployees(emp, context);
                setState(() {
                  employeeModel = employees;
                });
              })
        ]),
      ))),
    );
  }
}
