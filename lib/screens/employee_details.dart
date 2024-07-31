import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/api_service.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final String employeeId;

  EmployeeDetailsScreen({required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
      ),
      body: FutureBuilder<Employee>(
        future: ApiService().getEmployeeById(employeeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Employee not found'));
          } else {
            final employee = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${employee.name}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text(
                      'Address: ${employee.addressLine1}, ${employee.city}, ${employee.country}, ${employee.zipCode}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Contact Methods:', style: TextStyle(fontSize: 18)),
                  ...employee.contactMethods.map((cm) => Text(
                      '${cm.contactMethod}: ${cm.value}',
                      style: TextStyle(fontSize: 16))),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
