import 'package:employee_mobile_ui/screens/get_all_employees.dart';
import 'package:employee_mobile_ui/screens/register_employee.dart';
import 'package:flutter/material.dart';

class EmployeeDrawer extends StatefulWidget {
  const EmployeeDrawer({Key key}) : super(key: key);

  @override
  _EmployeeDrawerState createState() => _EmployeeDrawerState();
}

class _EmployeeDrawerState extends State<EmployeeDrawer> {
  final minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employee Management")),
      body: Center(
        child: Text("Welcome Employee!"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
          children: <Widget>[
            DrawerHeader(
              child: Text("Employee Management"),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text("Register Employee"),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterEmployee()));
              },
            ),
            ListTile(
              title: Text("Get Employees"),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>GetAllEmployees()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
