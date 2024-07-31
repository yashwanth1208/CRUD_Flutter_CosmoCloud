class Employee {
  String id;
  String name;
  String addressLine1;
  String city;
  String country;
  String zipCode;
  List<ContactMethod> contactMethods;

  Employee({
    required this.id,
    required this.name,
    required this.addressLine1,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.contactMethods,
  });

  // Constructor for creating a new Employee without an ID
  Employee.create({
    required this.name,
    required this.addressLine1,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.contactMethods,
  }) : id = '';

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['_id'],
      name: json['name'],
      addressLine1: json['address']['line1'],
      city: json['address']['city'],
      country: json['address']['country'],
      zipCode: json['address']['zipCode'],
      contactMethods: (json['contactMethods'] as List)
          .map((i) => ContactMethod.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': {
        'line1': addressLine1,
        'city': city,
        'country': country,
        'zipCode': zipCode,
      },
      'contactMethods': contactMethods.map((i) => i.toJson()).toList(),
    };
  }
}

class ContactMethod {
  String contactMethod;
  String value;

  ContactMethod({required this.contactMethod, required this.value});

  factory ContactMethod.fromJson(Map<String, dynamic> json) {
    return ContactMethod(
      contactMethod: json['contactMethod'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contactMethod': contactMethod,
      'value': value,
    };
  }
}
