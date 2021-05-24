import 'dart:convert';

import 'package:employee_mobile_ui/model/EmployeeModel.dart';
import 'package:employee_mobile_ui/screens/delete_employee.dart';
import 'package:employee_mobile_ui/screens/employee_drawer.dart';
import 'package:employee_mobile_ui/screens/update_employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetAllEmployees extends StatefulWidget {
  const GetAllEmployees({Key key}) : super(key: key);

  @override
  _GetAllEmployeesState createState() => _GetAllEmployeesState();
}

class _GetAllEmployeesState extends State<GetAllEmployees> {
  var employees = List<EmployeeModel>.generate(200, (index) => null);

  Future<List<EmployeeModel>> getAllEmployees() async {
    var data =
        await http.get('http://localhost:8080/getAllEmployees');
    var jsonData = json.decode(data.body);

    List<EmployeeModel> employee = [];
    for (var e in jsonData) {
      EmployeeModel employees = new EmployeeModel();
      employees.id = e["id"];
      employees.firstName = e["firstName"];
      employees.lastName = e["lastName"];
      employee.add(employees);
    }
    return employee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All employees Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EmployeeDrawer()));
          },
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: getAllEmployees(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Icon(Icons.error));
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('ID' + ' ' + 'First Name' + ' ' + 'Last Name'),
                    subtitle: Text('${snapshot.data[index].id}' +
                        ' '+
                        '${snapshot.data[index].firstName}' +
                        '  '+
                        '${snapshot.data[index].lastName}'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data[index])));
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  EmployeeModel employeeModel;

  DetailPage(this.employeeModel);

  deleteEmployee1(EmployeeModel employeeModel) async {
    final url = Uri.parse('http://localhost:8080/deleteEmployee');
    final request = http.Request("DELETE", url);
    request.headers
        .addAll(<String, String>{"Content-type": "application/json"});
    request.body = jsonEncode(employeeModel);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employeeModel.firstName),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UpdateEmployee(employeeModel: employeeModel,)));
              })
        ],
      ),
      body: Container(
        child: Text('FirstName' +
            ' ' +
            employeeModel.firstName +
            ' ' 'Last name' +
            employeeModel.lastName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteEmployee1(employeeModel);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DeleteEmployee()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
