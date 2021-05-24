import 'dart:convert';

import 'package:employee_mobile_ui/model/EmployeeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

class RegisterEmployee extends StatefulWidget {
  const RegisterEmployee({Key key}) : super(key: key);

  @override
  _RegisterEmployeeState createState() => _RegisterEmployeeState();
}

Future<EmployeeModel> registerEmployee(
    String firstName, lastName, BuildContext context) async {
  var url = "http://localhost:8080/addEmployee";
  var response = await http.post(url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
          <String, String>{"firstName": firstName, "lastName": lastName}));
  String responseString = response.body;
  if (response.statusCode == 200) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(title: "Backend Response", content: response.body);
      },
    );
  }
}

class _RegisterEmployeeState extends State<RegisterEmployee> {
  final minimumPadding = 5.0;

  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle2;

    return Scaffold(
        appBar: AppBar(
          title: Text("Register Employee"),
        ),
        body: Form(
            child: Padding(
          padding: EdgeInsets.all(minimumPadding * 2),
          child: ListView(children: <Widget>[
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
            RaisedButton(
                child: Text("Submit"),
                onPressed: () async {
                  String firstName = firstController.text;
                  String lastName = lastController.text;
                  EmployeeModel employees =
                      await registerEmployee(firstName, lastName, context);
                  firstController.text = '';
                  lastController.text = '';
                  setState(() {
                    employee = employees;
                  });
                })
          ]),
        )));
  }
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({this.title, this.content, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
      actions: actions,
      content: Text(
        content,
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}
