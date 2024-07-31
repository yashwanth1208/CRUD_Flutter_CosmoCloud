import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../models/contact_method.dart';
import '../services/api_service.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final List<ContactMethod> _contactMethods = [];

  void _addContactMethod() {
    setState(() {
      _contactMethods.add(ContactMethod(contactMethod: '', value: ''));
    });
  }

  void _removeContactMethod(int index) {
    setState(() {
      _contactMethods.removeAt(index);
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final newEmployee = Employee(
        id: '',
        name: _nameController.text,
        addressLine1: _addressLine1Controller.text,
        city: _cityController.text,
        country: _countryController.text,
        zipCode: _zipCodeController.text,
        contactMethods: _contactMethods,
      );
      await ApiService().createEmployee(newEmployee);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressLine1Controller,
                  decoration: InputDecoration(labelText: 'Address Line 1'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address line 1';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(labelText: 'Country'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter country';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _zipCodeController,
                  decoration: InputDecoration(labelText: 'Zip Code'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter zip code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text('Contact Methods', style: TextStyle(fontSize: 18)),
                ..._contactMethods.asMap().entries.map((entry) {
                  int index = entry.key;
                  ContactMethod contactMethod = entry.value;
                  return Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: contactMethod.contactMethod.isEmpty
                              ? null
                              : contactMethod.contactMethod,
                          items: ['EMAIL', 'PHONE'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              contactMethod.contactMethod = value!;
                            });
                          },
                          decoration:
                              InputDecoration(labelText: 'Contact Method'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a contact method';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          initialValue: contactMethod.value,
                          onChanged: (value) {
                            contactMethod.value = value;
                          },
                          decoration: InputDecoration(labelText: 'Value'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a value';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          _removeContactMethod(index);
                        },
                      ),
                    ],
                  );
                }),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Add Contact Method'),
                    onPressed: _addContactMethod,
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
