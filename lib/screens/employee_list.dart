import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/api_service.dart';
import 'employee_details.dart';
import 'add_employee.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<List<Employee>> futureEmployees;

  @override
  void initState() {
    super.initState();
    futureEmployees = ApiService().getEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
      ),
      body: FutureBuilder<List<Employee>>(
        future: futureEmployees,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Employees in the system'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final employee = snapshot.data![index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text(employee.id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EmployeeDetailsScreen(employeeId: employee.id),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await ApiService().deleteEmployee(employee.id);
                      setState(() {
                        futureEmployees = ApiService().getEmployees();
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEmployeeScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
